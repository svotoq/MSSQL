use UNIVERlab4
go
--task1
create procedure PSUBJECT
as
	begin
		declare @count int = (select count(*) from SUBJECT)
		select SUBJECT.SUBJECT[код], SUBJECT.SUBJECT_NAME[дисциплина], SUBJECT.PULPIT[Кафедра] from SUBJECT
		return @count
	end
go
declare @count int = 0
exec @count = PSUBJECT
print 'Результат: ' + cast(@count as nvarchar(10))
go

--task2
USE [UNIVERlab4]
GO
/****** Object:  StoredProcedure [dbo].[PSUBJECT]    Script Date: 12.04.2019 16:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[PSUBJECT] @p varchar(20) = null, @c int output 
as
	begin
		declare @count int = (select count(*) from SUBJECT)
		select SUBJECT.SUBJECT[код], SUBJECT.SUBJECT_NAME[дисциплина], SUBJECT.PULPIT[Кафедра] 
		from SUBJECT where SUBJECT.SUBJECT = @p
		set @c = @@ROWCOUNT
		return @count
	end
go

declare @count int = 0,
		@p varchar(20) = 'БД',
		@c int = 0
exec @count = PSUBJECT @p, @c output 
print 'Результат: ' + cast(@count as nvarchar(10))
print '@p: ' + @p + ' ' + '@c: ' + cast(@c as varchar(10))
go

--task3
create table #SUBJECT 
(
SUBJECT CHAR(10), 
SUBJECT_NAME varchar(100), 
PULPIT char(20) 
)
go
ALTER procedure PSUBJECT @p varchar(20) = null
as
	begin
		select SUBJECT.SUBJECT[код], SUBJECT.SUBJECT_NAME[дисциплина], SUBJECT.PULPIT[Кафедра] 
		from SUBJECT where SUBJECT.SUBJECT = @p
	end
go
insert into #SUBJECT execute PSUBJECT @p ='Кг'
select * from #SUBJECT
go

--task4
create procedure PAUDITORIUM_INSERT @a char(20), @n varchar(50), @c int = 0, @t char(10)
as
	begin try
	insert into AUDITORIUM	(AUDITORIUM, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY, AUDITORIUM_NAME)
				values		(@a,@t,@c,@n)
	return 1
	end try
	begin catch
	print 'ERROR!'
	print 'Number: ' + cast(error_number() as nvarchar(6))
	print 'Message: ' + error_message()
	print 'Level: ' + cast(error_severity() as nvarchar(6))
	print 'State: ' + cast(error_state() as nvarchar(8))
	print 'Line: ' + cast(error_line() as nvarchar(8))
	if error_procedure() is not null
		print 'Procedure: ' + error_procedure()
	return -1
	end catch
go
declare @code int = 0;
execute @code = PAUDITORIUM_INSERT '1-1', '1-1', 12, 'ЛБ-К'
print 'Транзакция завершилась с кодом: ' + cast(@code as char(2))
execute @code = PAUDITORIUM_INSERT '206-1', '1-1', 12, 'ЛБ-К'
print 'Транзакция завершилась с кодом: ' + cast(@code as char(2))
execute @code = PAUDITORIUM_INSERT 1, '1-1', 12, 12313
print 'Транзакция завершилась с кодом: ' + cast(@code as char(2))
execute @code = PAUDITORIUM_INSERT 'asdasdasdaasdasda asd asd asd asdsdsadasdas1-1', '1-1', 12, 123
print 'Транзакция завершилась с кодом: ' + cast(@code as char(2))

go
--task5

create procedure SUBJECT_REPORT @p char(10) = null
as
	begin
		declare @OutputString nvarchar(max) = ''
		select @OutputString = @OutputString + Rtrim(SUBJECT.SUBJECT) + ' '
			from SUBJECT
				where SUBJECT.PULPIT = @p
		if not exists (select SUBJECT.SUBJECT from SUBJECT where SUBJECT.PULPIT = @p)
			print 'Ошибка в параметрах'
		else
			begin
				declare @count int = (select count(*) from SUBJECT where SUBJECT.PULPIT = @p)
				print 'Результат: ' + @OutputString
				return @count
			end
		return 
	end
go
declare @count int
exec @count = SUBJECT_REPORT 'ИСиТ'
print 'Количество предметов: ' + cast(@count as nvarchar(10))
go

--task6
create procedure PAUDITORIUM_INSERTX @a char(20),
									 @n varchar(50), 
									 @c int = 0, 
									 @t char(10), 
									 @tn varchar(50) output
as
	begin try
		set transaction isolation level SERIALIZABLE
			begin tran
				insert into AUDITORIUM_TYPE	(AUDITORIUM_TYPE, AUDITORIUM_TYPENAME)
							values			(@t, @tn)
				declare @code int = 0;
				exec @code = PAUDITORIUM_INSERT @a, @n, @c, @t
			commit tran
		return @code
	end try
	begin catch
		print 'ERROR!'
		print 'Number: ' + cast(error_number() as nvarchar(6))
		print 'Message: ' + error_message()
		print 'Level: ' + cast(error_severity() as nvarchar(6))
		print 'State: ' + cast(error_state() as nvarchar(8))
		print 'Line: ' + cast(error_line() as nvarchar(8))
		if error_procedure() is not null
			print 'Procedure: ' + error_procedure()
		return -1
	end catch
go

declare @code int = 0;
execute @code = PAUDITORIUM_INSERTX'12-1', '12-1', 12, 'Л112-К', 'Компьютерный 1'
print 'Транзакция завершилась с кодом: ' + cast(@code as char(2))
execute @code = PAUDITORIUM_INSERTX '206-1', '1-1', 12, 'ЛБ-К', 'Компьютерный класс'
print 'Транзакция завершилась с кодом: ' + cast(@code as char(2))
execute @code = PAUDITORIUM_INSERTX 1, '1-1', 12, 12313, 'Компьютерный класс'
print 'Транзакция завершилась с кодом: ' + cast(@code as char(2))
execute @code = PAUDITORIUM_INSERTX 'asdasdasdaasdasda asd asd asd asdsdsadasdas1-1', '1-1', 12, 123, 'Компьютерный класс'
print 'Транзакция завершилась с кодом: ' + cast(@code as char(2))
