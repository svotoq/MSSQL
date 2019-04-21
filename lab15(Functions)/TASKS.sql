use UNIVERlab4
go

--task1
create function COUNT_STUDENTS(@faculty varchar(20)) returns int
as
	begin
		declare @result int = 0
		set @result = (select count(STUDENT.IDSTUDENT) 
							from STUDENT join GROUPS on STUDENT.IDGROUP = GROUPS.IDGROUP
								join FACULTY on GROUPS.FACULTY = FACULTY.FACULTY
									where FACULTY.FACULTY = @faculty)
		return @result	
	end
go
declare @count int = dbo.COUNT_STUDENTS('ХТиТ')
print 'Студентов: ' + cast(@count as nvarchar(3))
go
create function COUNT_STUDENTS2(@faculty varchar(20), @prof varchar(20) = null) returns int
as
	begin
		declare @result int = 0
		set @result = (select count(STUDENT.IDSTUDENT) 
							from STUDENT join GROUPS on STUDENT.IDGROUP = GROUPS.IDGROUP
								join FACULTY on GROUPS.FACULTY = FACULTY.FACULTY
									where FACULTY.FACULTY = @faculty and GROUPS.PROFESSION = @prof)
		return @result	
	end
go
declare @count int = dbo.COUNT_STUDENTS2('ХТиТ','1-36 01 08')
print 'Студентов: ' + cast(@count as nvarchar(3))
go

--task3
create function FSUBJECTS(@p varchar(20)) returns varchar(300)
as
	begin
		declare @result varchar(300) = ''
		select @result = @result + Rtrim(SUBJECT.SUBJECT) + ', ' from SUBJECT where SUBJECT.PULPIT = @p
		return @result
	end
go
print dbo.FSUBJECTS('ИСиТ')

select PULPIT, dbo.FSUBJECTS(PULPIT)[Дисциплины] from PULPIT
go

--task4
create function FFACPUL(@faculty nvarchar(30), @pulpit nvarchar(30)) returns table
as return
	select FACULTY.FACULTY, PULPIT.PULPIT from FACULTY left outer join PULPIT on FACULTY.FACULTY = PULPIT.FACULTY
		where FACULTY.FACULTY = isnull(@faculty, FACULTY.FACULTY)
		and	PULPIT.PULPIT = isnull(@pulpit, PULPIT.PULPIT)
go
select * from dbo.FFACPUL(null,null)
select * from dbo.FFACPUL('ХТиТ',null)
select * from dbo.FFACPUL(null,'ИСиТ')
select * from dbo.FFACPUL('ИТ','ИСиТ')
go

--task4
create function FCTEACHER(@pulpit nvarchar(30)) returns int
as
	begin
		declare @result int = (select count(*) from TEACHER where TEACHER.PULPIT = isnull(@pulpit, TEACHER.PULPIT))
		return @result
	end
go
select PULPIT.PULPIT, dbo.FCTEACHER(PULPIT.PULPIT)[Преподователей] from PULPIT
select dbo.FCTEACHER(null)[Всего преподавателей]
go

--task5
alter function FACULTY_REPORT(@c int) returns @fr table
				([Факультет] varchar(50), [Количество кафедр] int, [Количество групп]  int, 
				 [Количество студентов] int, [Количество специальностей] int )
as begin 
	declare cc CURSOR static for 
	select FACULTY from FACULTY 
		where dbo.COUNT_STUDENTS(FACULTY) > @c; 
	declare @f varchar(30);
	open cc;  
	fetch cc into @f;
	while @@fetch_status = 0
	begin
		insert @fr values( @f,  dbo.FC_NUMBER_OF_PULPITS(@f),
		dbo.FC_NUMBER_OF_GROUPS(@f),   dbo.COUNT_STUDENTS(@f),
		dbo.FC_NUMBER_OF_PROFESSIONS(@f)); 
		fetch cc into @f;  
	end;   
	return; 
end;
go
create function FC_NUMBER_OF_PULPITS(@faculty nvarchar(30)) returns int
as
	begin
		declare @result int = (select count(PULPIT) from PULPIT where FACULTY = @faculty)
		return @result
	end
go
create function FC_NUMBER_OF_GROUPS(@faculty nvarchar(30)) returns int
as
	begin
		declare @result int = (select count(PROFESSION) from PROFESSION where FACULTY = @faculty)
		return @result
	end
go
create function FC_NUMBER_OF_PROFESSIONS(@faculty nvarchar(30)) returns int
as
	begin
		declare @result int = (select count(IDGROUP) from GROUPS where FACULTY = @faculty)
		return @result
	end
go
select* from dbo.FACULTY_REPORT(1)
go