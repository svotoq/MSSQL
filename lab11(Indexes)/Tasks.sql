use UNIVERlab4
go
--task1
EXEC SP_HELPINDEX 'AUDITORIUM'
EXEC SP_HELPINDEX 'AUDITORIUM_TYPE'
EXEC SP_HELPINDEX 'FACULTY'
EXEC SP_HELPINDEX 'GROUPS'
EXEC SP_HELPINDEX 'PROFESSION'
EXEC SP_HELPINDEX 'PROGRESS'
EXEC SP_HELPINDEX 'PULPIT'
EXEC SP_HELPINDEX 'STUDENT'
EXEC SP_HELPINDEX 'SUBJECT'
EXEC SP_HELPINDEX 'TEACHER'
go
--task2
create table #local_table
(
Id int identity,
number int
)
go
declare @i int =0
while @i !=1000
	begin
	insert into #local_table values(@i)
	set @i=@i+1;
	end
go
select * from #local_table order by #local_table.number
go
checkpoint;
DBCC DROPCLEANBUFFERS;
Create clustered index #local_table_cl on #local_table(number asc)
go
select * from #local_table order by #local_table.number
go

--task3
create table #second_local_table
(
id int identity,
string nvarchar(100)
)
go
declare @index int = 0
while @index !=10000
	begin
		insert into #second_local_table values('Рандомная строка номер ' + cast(@index as nvarchar(10)))
		set @index = @index + 1;
	end
go
select * from #second_local_table
create index #second_local_table_nonclu on #second_local_table(Id, string)
    SELECT * from  #second_local_table where  id > 1500 and  id < 4500;  
	SELECT * from  #second_local_table where  id = 1556 and  len(string) > 30

--task4
create table #third_local_table
(
id int identity,
string nvarchar(100)
)
go
declare @index int = 0
while @index !=10000
	begin
		insert into #second_local_table values('Рандомная строка номер ' + cast(@index as nvarchar(10)))
		set @index = @index + 1;
	end
go
select * from #third_local_table
CREATE  index #thired_local_table_x on #third_local_table(id) INCLUDE (string)
SELECT string from #third_local_table where id>5000 
go

--task5
create table #fourth_local_table
(
id int identity,
string nvarchar(100)
)
go
declare @index int = 0
while @index !=10000
	begin
		insert into #second_local_table values('Рандомная строка номер ' + cast(@index as nvarchar(10)))
		set @index = @index + 1;
	end
go

SELECT id from  #fourth_local_table where id between 5000 and 10000; 
SELECT id from  #fourth_local_table where id>5000 and  id < 10000  
SELECT id from  #fourth_local_table where id=3000

CREATE  index #EX_WHERE on #fourth_local_table(id) where (id>=5000 and 
 id < 10000);  
