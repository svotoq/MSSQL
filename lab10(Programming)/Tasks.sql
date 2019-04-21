--zad1
declare @_char char = 'c',
		@_datetime datetime= 1999-02-22,
		@_time time,
		@_smallint smallint,
		@_tinyint tinyint,
		@_numeric numeric(12,5)

set @_time = '23:54:12'

use UNIVERlab4
select @_smallint = min(PROGRESS.NOTE) from PROGRESS
select @_numeric = avg(PROGRESS.NOTE) from PROGRESS

select @_char, @_datetime, @_time

print 'smallint: ' + cast(@_smallint as nvarchar(10))
print 'tinyint: ' + cast(@_tinyint as nvarchar(10))
print 'numeric: ' + cast(@_numeric as nvarchar(10))

--zad2
declare @AuditoriumCapacity int = (select sum(AUDITORIUM.AUDITORIUM_CAPACITY) from AUDITORIUM)
if @AuditoriumCapacity > 200
	begin
		declare @NumberOfAuditoiums int = (select count(*) from AUDITORIUM)
		declare	@AvgCapacity int = (select avg(AUDITORIUM.AUDITORIUM_CAPACITY) from AUDITORIUM)
		declare	@NumberOfSmallAuditoriums int = (select count(*) from AUDITORIUM where AUDITORIUM.AUDITORIUM_CAPACITY < @AvgCapacity)
		declare @PercentOfSmallAuditoriums float = (@NumberOfAuditoiums - @NumberOfSmallAuditoriums) * 100 / @NumberOfAuditoiums
		print 'Number of auditorium: ' + cast(@NumberOfAuditoiums as nvarchar(10))
		print 'Average Capacity: ' + cast(@AvgCapacity as nvarchar(10))
		print 'Number of small auditorium: ' + cast(@NumberOfSmallAuditoriums as nvarchar(10))
		print 'Percent of small auditorium: ' + cast(@PercentOfSmallAuditoriums as nvarchar(10)) +'%'
	end
else
	print 'Auditorium capacity: ' + cast(@AuditoriumCapacity as nvarchar(10))

--zad3
print 'ROWCOUNT: ' + cast(@@ROWCOUNT as nvarchar(10))
print 'VERSION: ' + cast(@@VERSION  as nvarchar(10))
print 'SPID: ' + cast(@@SPID as nvarchar(10))
print 'ERROR: ' + cast(@@ERROR as nvarchar(10))
print 'SERVERNAME: ' + cast(@@SERVERNAME as nvarchar(10))
print 'TRANCOUNT: ' + cast(@@TRANCOUNT as nvarchar(10))
print 'FETCH_STATUS: ' + cast(@@FETCH_STATUS as nvarchar(10))
print 'NESTLEVEL: ' + cast(@@NESTLEVEL as nvarchar(10))

--zad4
--1
declare @t float = 0.5,
		@x float = 0.15,
		@z float

if @t > @x
	set @z = square(sin(@t))
if @t < @x
	set @z = 4 * (@t + @x)
if @t = @x 
	set @z = 1 - exp(@x-2)
print 'z = ' + cast(@z as nvarchar(10))
--2
declare @InsertName nvarchar(100) = 'Макейчик Татьяна Леонидовна',
		@ChangedName nvarchar(50)
declare @FirstIndex int = charindex(' ', @InsertName),
		@SecondIndex int = CHARINDEX(' ', reverse(@InsertName))
set @ChangedName = SUBSTRING(@InsertName,0,@FirstIndex) + Upper(Substring(@InsertName,@FirstIndex,2)) + '.'
	+ ' ' + upper(SUBSTRING(reverse(@InsertName),@SecondIndex-1,1)) +'.'
print @ChangedName
--3
select STUDENT.BDAY, DATEDIFF(year,STUDENT.BDAY,GETDATE()) as years from STUDENT where month(STUDENT.BDAY) = (month(GETDATE()) + 1)
--4
declare @GroupID int = 1
select  DATENAME(WEEKDAY, PROGRESS.PDATE ) AS PassDay 
from	STUDENT join PROGRESS on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT 
where	STUDENT.IDGROUP = @GroupID

--zad5
declare @AvgNote float = (select avg(PROGRESS.NOTE) from PROGRESS)
declare @MinNote int  = (select min(PROGRESS.NOTE) from PROGRESS)
if @AvgNote > @MinNote
	print 'AvgNote: ' + cast(@AvgNote as nvarchar(10))
else
	print 'MinNote: ' + cast(@MinNote as nvarchar(10))

--zad6
select	PROGRESS.SUBJECT, 
		case PROGRESS.NOTE
			when 4 then 'Четыре'
			when 5 then 'Пять'
			when 6 then 'Шесть'
			when 7 then 'Семь'
			when 8 then 'Восемь'
			when 9 then 'Девять'
		end AS NOTE, STUDENT.NAME
from STUDENT join PROGRESS on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT 
ORDER BY PROGRESS.SUBJECT
--zad7
create table #Stud
(
	IDSTUDENT int identity,
	NAME nvarchar(100),
	BDAY date
)
select top 10 STUDENT.IDSTUDENT, STUDENT.NAME, STUDENT.BDAY into #Stud from STUDENT
select * from #Stud
declare @Student int = 1000
declare @Id int, @Name nvarchar(100), @Bday date
while @Student < 1011
	begin
		select @Id = #Stud.IDSTUDENT, @Name = #Stud.NAME, @Bday = #Stud.BDAY 
		from #Stud where #Stud.IDSTUDENT = @Student
		print	'Id:	' + cast(@Id as nvarchar(10)) + 
				' Name: ' + @Name +
				' Bday: ' + cast(@Bday as nvarchar(30))
		set	@Student = @Student + 1 
	end

--zad8
Declare @Counter int = 5
while @Counter > 0
	begin
		if @Counter = 2
			return
		print @Counter
		set @counter = @Counter - 1
	end

--zad9
begin try
	Update AUDITORIUM set AUDITORIUM.AUDITORIUM = '100-1'
	where AUDITORIUM.AUDITORIUM_TYPE like 'ЛК%'
end try
begin catch
	print 'ERROR_NUMBER:	' + ERROR_NUMBER()
	print 'ERROR_MESSAGE:	' + ERROR_MESSAGE()
	print 'ERROR_LINE:		' + ERROR_LINE()
	print 'ERROR_PROCEDURE:	' + ERROR_PROCEDURE()
	print 'ERROR_SEVERITY:	' + ERROR_SEVERITY()
	print 'ERROR_STATE:		' + ERROR_STATE()
end catch