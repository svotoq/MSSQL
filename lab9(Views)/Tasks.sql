se UNIVERlab4
go
--zad1
create view	[�������������]
	as select	TEACHER.TEACHER			[���],
				TEACHER.TEACHER_NAME	[��� �������������],
				TEACHER.GENDER			[���],
				TEACHER.PULPIT			[��� �������]
	from		TEACHER
go
--zad2
create view [���������� ������]
	as select	FACULTY.FACULTY			[���������],
				count(PULPIT.PULPIT)	[���������� ������]
	from FACULTY inner join PULPIT on FACULTY.FACULTY = PULPIT.FACULTY
	group by FACULTY.FACULTY
go
--zad3
create view [���������]
	as select	AUDITORIUM.AUDITORIUM		[���],
				AUDITORIUM.AUDITORIUM_NAME	[������������ ���������],
				AUDITORIUM.AUDITORIUM_TYPE  [��� ���������]
	from		AUDITORIUM
	where		AUDITORIUM.AUDITORIUM_TYPE Like '��%'
go
insert [���������] values('210-1','210-1','��-�')
go
--zad4
create view [���������� ���������]
	as select	AUDITORIUM.AUDITORIUM		[���],
				AUDITORIUM.AUDITORIUM_NAME	[������������ ���������],
				AUDITORIUM.AUDITORIUM_TYPE  [��� ���������]
	from		AUDITORIUM
	where		AUDITORIUM.AUDITORIUM_TYPE like '��%' with check option
go
insert [���������� ���������] values('173-4','173-4','��-�')
go
create view [����������]
	as select top 150	
				SUBJECT.SUBJECT			[���],
				SUBJECT.SUBJECT_NAME	[������������ ����������],
				SUBJECT.PULPIT			[��� �������]
	from		SUBJECT
	order by SUBJECT_NAME
go
alter view [���������� ������] with schemabinding
	as select	fc.FACULTY			[���������],
				count(pu.PULPIT)	[���������� ������]
	from dbo.FACULTY fc join dbo.PULPIT pu on fc.FACULTY = pu.FACULTY
	group by fc.FACULTY
go
