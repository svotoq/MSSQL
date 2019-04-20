use UNIVERlab4
go

--task1
select TEACHER.TEACHER_NAME[Name], TEACHER.GENDER[Gender], Rtrim(TEACHER.PULPIT)[Pulpit]
	from TEACHER
		where TEACHER.PULPIT = '����'
			for xml path('Teacher'),
				root('Teacher_list'), elements

--task2
select AUDITORIUM.AUDITORIUM_NAME[Name], rtrim(AUDITORIUM.AUDITORIUM_TYPE)[Type], AUDITORIUM.AUDITORIUM_CAPACITY[Capacity]
	from AUDITORIUM join AUDITORIUM_TYPE on AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE
		where AUDITORIUM.AUDITORIUM_TYPE like '��%'
			for	xml auto,
				root('Auditorium_list'), elements

--subject, subject_name, pulpit
--task3
declare @h int = 0,
		@xmlDOC nvarchar(max) = 
		'<ROOT> 
		<subjects subject="����" name="������������ ��������� � �������" pulpit="����"></subjects>
		<subjects subject="���" name="����������������" pulpit="����"></subjects>
		<subjects subject="���" name="������ ������� ����������" pulpit="����"></subjects>
		</ROOT>'
exec sp_xml_preparedocument @h output, @xmlDOC
insert into SUBJECT select [subject], [name], [pulpit]
	from openxml(@h,'/ROOT/subjects',0)
		with([subject] char(10), [name] varchar(100), [pulpit] char(20))
exec sp_xml_removedocument @h;     
go
select * from SUBJECT where SUBJECT.SUBJECT in ('����', '���','���')
delete from SUBJECT where SUBJECT.SUBJECT in ('����', '���','���')
go

--task4
declare @h int = 0,
		 @StudentInfo xml =
		'<student_info>
			<student>
				<passport_series>��</passport_series>
				<passport_id>2550499</passport_id>
				<adress>
					<country>��������</country>
					<city>�����</city>
					<street>����������</street>
					<house_number>25</house_number>
				</adress>
			</student>
		</student_info>'
insert into STUDENT(IDGROUP, NAME, BDAY, INFO) values(5,'������ ������� ��������', '2000-03-11',@StudentInfo)
update STUDENT set INFO = @StudentInfo where STUDENT.NAME = '������ ������� ��������'
go
select	STUDENT.NAME[name],
		STUDENT.INFO.value('(/student_info/student/passport_series)[1]','varchar(2)')[passport_series],
		STUDENT.INFO.value('(/student_info/student/passport_id)[1]','int')[passport_id],
		STUDENT.INFO.query('(/student_info/student/adress)')[adress]
	 from STUDENT
		where STUDENT.NAME = '������ ������� ��������'
go

--task5
create database UNIVER
go
use UNIVER
go
create xml schema collection Student as 
N'<?xml version="1.0" encoding="utf-16" ?>
<xs:schema attributeFormDefault="unqualified" 
           elementFormDefault="qualified"
           xmlns:xs="http://www.w3.org/2001/XMLSchema">
       <xs:element name="�������">  
       <xs:complexType><xs:sequence>
       <xs:element name="�������" maxOccurs="1" minOccurs="1">
       <xs:complexType>
       <xs:attribute name="�����" type="xs:string" use="required" />
       <xs:attribute name="�����" type="xs:unsignedInt" use="required"/>
       <xs:attribute name="����"  use="required" >  
       <xs:simpleType>  <xs:restriction base ="xs:string">
   <xs:pattern value="[0-9]{2}.[0-9]{2}.[0-9]{4}"/>
   </xs:restriction> 	</xs:simpleType>
   </xs:attribute> </xs:complexType> 
   </xs:element>
   <xs:element maxOccurs="3" name="�������" type="xs:unsignedInt"/>
   <xs:element name="�����">   <xs:complexType><xs:sequence>
   <xs:element name="������" type="xs:string" />
   <xs:element name="�����" type="xs:string" />
   <xs:element name="�����" type="xs:string" />
   <xs:element name="���" type="xs:string" />
   <xs:element name="��������" type="xs:string" />
   </xs:sequence></xs:complexType>  </xs:element>
   </xs:sequence></xs:complexType>
   </xs:element>
</xs:schema>';
go
create table STUDENT
(
	IDSTUDENT integer  identity(1000,1)  primary key,
	IDGROUP integer,        
	NAME nvarchar(100), 
	BDAY  date,
	STAMP timestamp,
	INFO   xml(STUDENT), 
	FOTO  varbinary
)
go
declare @Scheme xml = (select XML_SCHEMA_NAMESPACE (N'dbo',N'STUDENT'))
select @Scheme
	set @scheme.modify('
		insert <element name="inserted_line"></element>
			into (/scheme/element/complexType/complexContent/restriction/sequence)[1]')