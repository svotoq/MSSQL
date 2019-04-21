use UNIVERlab4
go
--task1
create table Table1
(
t1 int,
t2 int,
t3 int
)
go
declare @N1 int = (select count(*) from AUDITORIUM),
		@N2 int = (select count(*) from STUDENT),
		@N3 int = (select count(*) from PROGRESS)
insert into Table1(t1,t2,t3) values (@N1,@N2,@N3)
go
--task2
select STUDENT.NAME
	from STUDENT join PROGRESS on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
		where PROGRESS.NOTE < 5
go
--task3
select * from PROGRESS
except 
select * from PROGRESS
go
--task4
create view [Отличники]
as	
	select STUDENT.IDSTUDENT[Id], STUDENT.NAME[Name], PROGRESS.NOTE[Note]
		from STUDENT join PROGRESS on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
			where PROGRESS.NOTE > 8
go
--task6
declare @string varchar(30) = '      5lspaces'
print 'Until ltrim: ' + @string
set @string = ltrim(@string)
print 'After ltrim: ' + @string
go

(select * from PROGRESS
union all 
select * from PROGRESS)
intersect
select * from PROGRESS