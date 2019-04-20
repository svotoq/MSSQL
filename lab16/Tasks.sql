use UNIVERlab4
go
create table TR_AUDIT
(
ID int identity,
STMT varchar(20) check(STMT in('INS','DEL','UPD')),
TRNAME varchar(50),
CC varchar(300)
)
go

--task1
create trigger TR_TEACHER_INS on TEACHER after insert
as 
	declare	@teacher char(10) = (select inserted.TEACHER from inserted), 
			@teacher_name varchar(100) = (select inserted.TEACHER_NAME from inserted), 
			@gender char(1) = (select inserted.GENDER from inserted),
			@pulpit char(20) = (select inserted.PULPIT from inserted),
			@CC varchar(300);
	SET @CC = @teacher + ' ' + @teacher_name + ' ' + @gender + ' ' + @pulpit
	insert into TR_AUDIT(STMT,TRNAME,CC) values ('INS','TR_TEACHER_INS',@CC)
	return
go
insert into TEACHER values('ЧЕРН','Чернявский Алексей','м','ИСиТ')
go
drop trigger TR_TEACHER_INS
go

--task2
create trigger TR_TEACHER_DEL on TEACHER after delete
as 
	declare	@teacher char(10) = (select deleted.TEACHER from deleted), 
			@teacher_name varchar(100) = (select deleted.TEACHER_NAME from deleted), 
			@gender char(1) = (select deleted.GENDER from deleted),
			@pulpit char(20) = (select deleted.PULPIT from deleted),
			@CC varchar(300);
	SET @CC = @teacher + ' ' + @teacher_name + ' ' + @gender + ' ' + @pulpit
	insert into TR_AUDIT(STMT,TRNAME,CC) values ('DEL','TR_TEACHER_DEL',@CC)
	return
go
delete from TEACHER where TEACHER.TEACHER = 'ЧЕРН'
go
drop trigger TR_TEACHER_DEL
go

--task3
create trigger TR_TEACHER_UPD on TEACHER after update
as 
	declare	@teacher char(10) = (select deleted.TEACHER from deleted), 
			@teacher_name varchar(100) = (select deleted.TEACHER_NAME from deleted), 
			@gender char(1) = (select deleted.GENDER from deleted),
			@pulpit char(20) = (select deleted.PULPIT from deleted),
			@CC varchar(300);
	SET @CC = @teacher + ' ' + @teacher_name + ' ' + @gender + ' ' + @pulpit
	set @teacher = (select inserted.TEACHER from inserted)
	set @teacher_name = (select inserted.TEACHER_NAME from inserted)
	set @gender = (select inserted.GENDER from inserted)
	set @pulpit = (select inserted.PULPIT from inserted)
	SET @CC ='До: ' + @teacher + ' ' + @teacher_name + ' ' + @gender + ' ' + @pulpit + ' ' + 'После: ' + @CC
	insert into TR_AUDIT(STMT,TRNAME,CC) values ('UPD','TR_TEACHER_UPD',@CC)
	return
go
update TEACHER set TEACHER.GENDER = 'ж' where TEACHER.TEACHER = 'ЧЕРН'
go
drop trigger TR_TEACHER_UPD
go

--task4
create trigger TR_TEACHER on TEACHER after insert, update, delete
as 
	declare	@teacher char(10), @teacher_name varchar(100), @gender char(1), 
			@pulpit char(20), @CC varchar(300);
	declare @ins int = (select count(*) from inserted),
			@del int = (select count(*) from deleted)
	if @ins > 0 and @del = 0
		begin
			set @teacher = (select inserted.TEACHER from inserted)
			set @teacher_name = (select inserted.TEACHER_NAME from inserted)
			set @gender = (select inserted.GENDER from inserted)
			set @pulpit = (select inserted.PULPIT from inserted)
			set @CC = @teacher + ' ' + @teacher_name + ' ' + @gender + ' ' + @pulpit
			insert into TR_AUDIT(STMT,TRNAME,CC) values ('INS','TR_TEACHER',@CC)
		end
	if @ins = 0 and @del > 0
		begin
			set @teacher = (select deleted.TEACHER from deleted)
			set @teacher_name = (select deleted.TEACHER_NAME from deleted)
			set @gender = (select deleted.GENDER from deleted)
			set @pulpit = (select deleted.PULPIT from deleted)
			set @CC = @teacher + ' ' + @teacher_name + ' ' + @gender + ' ' + @pulpit
			insert into TR_AUDIT(STMT,TRNAME,CC) values ('DEL','TR_TEACHER',@CC)
		end
	if @ins > 0 and @del > 0
		begin
			set @teacher = (select deleted.TEACHER from deleted)
			set @teacher_name = (select deleted.TEACHER_NAME from deleted)
			set @gender = (select deleted.GENDER from deleted)
			set @pulpit = (select deleted.PULPIT from deleted)
			set @CC = @teacher + ' ' + @teacher_name + ' ' + @gender + ' ' + @pulpit
			set @teacher = (select inserted.TEACHER from inserted)
			set @teacher_name = (select inserted.TEACHER_NAME from inserted)
			set @gender = (select inserted.GENDER from inserted)
			set @pulpit = (select inserted.PULPIT from inserted)
			set @CC ='До: ' + @teacher + ' ' + @teacher_name + ' ' + @gender + ' ' + @pulpit + ' ' + 'После: ' + @CC
			insert into TR_AUDIT(STMT,TRNAME,CC) values ('UPD','TR_TEACHER',@CC)
		end
	return
go
insert into TEACHER values('ЧЕРН','Чернявский Алексей','м','ИСиТ')
update TEACHER set TEACHER.GENDER = 'ж' where TEACHER.TEACHER = 'ЧЕРН'
delete from TEACHER where TEACHER.TEACHER = 'ЧЕРН'
go
select * from TR_AUDIT
go
drop trigger TR_TEACHER
go

--task5
update TEACHER set TEACHER.GENDER = 'к' where TEACHER.TEACHER = 'ЧЕРН'
go

--task6
create trigger TR_TEACHER_DEL1 on TEACHER after delete
as
	declare	@teacher char(10), @teacher_name varchar(100), @gender char(1), 
			@pulpit char(20), @CC varchar(300);
			set @teacher = (select deleted.TEACHER from deleted)
			set @teacher_name = (select deleted.TEACHER_NAME from deleted)
			set @gender = (select deleted.GENDER from deleted)
			set @pulpit = (select deleted.PULPIT from deleted)
			set @CC = @teacher + ' ' + @teacher_name + ' ' + @gender + ' ' + @pulpit
			insert into TR_AUDIT(STMT,TRNAME,CC) values ('DEL','TR_TEACHER_DEL1',@CC)
return
go
create trigger TR_TEACHER_DEL2 on TEACHER after delete
as
	declare	@teacher char(10), @teacher_name varchar(100), @gender char(1), 
			@pulpit char(20), @CC varchar(300);
			set @teacher = (select deleted.TEACHER from deleted)
			set @teacher_name = (select deleted.TEACHER_NAME from deleted)
			set @gender = (select deleted.GENDER from deleted)
			set @pulpit = (select deleted.PULPIT from deleted)
			set @CC = @teacher + ' ' + @teacher_name + ' ' + @gender + ' ' + @pulpit
			insert into TR_AUDIT(STMT,TRNAME,CC) values ('DEL','TR_TEACHER_DEL2',@CC)
return
go
create trigger TR_TEACHER_DEL3 on TEACHER after delete
as
	declare	@teacher char(10), @teacher_name varchar(100), @gender char(1), 
			@pulpit char(20), @CC varchar(300);
			set @teacher = (select deleted.TEACHER from deleted)
			set @teacher_name = (select deleted.TEACHER_NAME from deleted)
			set @gender = (select deleted.GENDER from deleted)
			set @pulpit = (select deleted.PULPIT from deleted)
			set @CC = @teacher + ' ' + @teacher_name + ' ' + @gender + ' ' + @pulpit
			insert into TR_AUDIT(STMT,TRNAME,CC) values ('DEL','TR_TEACHER_DEL3',@CC)
return
go
select sys_triggers.name, sys_trigger_events.type_desc
	from sys.triggers sys_triggers join sys.trigger_events sys_trigger_events
		on sys_triggers.object_id = sys_trigger_events.object_id
			where OBJECT_NAME(sys_triggers.parent_id) = 'TEACHER'
				and sys_trigger_events.type_desc = 'DELETE'
go
exec sp_settriggerorder @triggername = 'TR_TEACHER_DEL3',
						@order = 'First',
						@stmttype = 'DELETE'
exec sp_settriggerorder @triggername = 'TR_TEACHER_DEL2',
						@order = 'Last',
						@stmttype = 'DELETE'
go
insert into TEACHER values('ЧЕРН','Чернявский Алексей','м','ИСиТ')
delete from TEACHER where TEACHER.TEACHER = 'ЧЕРН'
go
select * from TR_AUDIT
go

--task7
--??????????????//

--task8
create trigger TR_FACULTY on FACULTY instead of delete
as
	raiserror(N'Удаление запрещено',10,1)
go
drop trigger TR_FACULTY
drop trigger TR_TEACHER_DEL1
drop trigger TR_TEACHER_DEL2
drop trigger TR_TEACHER_DEL3
go

--task8
use UNIVERlab4
go
create trigger TR_DDL_DATABASE_EVENTS on database for CREATE_TABLE, DROP_TABLE
as
	declare @t varchar(50) =  EVENTDATA().value('(/EVENT_INS-TANCE/EventType)[1]', 'varchar(50)')
	declare @t1 varchar(50) = EVENTDATA().value('(/EVENT_INS-TANCE/ObjectName)[1]', 'varchar(50)');
	declare @t2 varchar(50) = EVENTDATA().value('(/EVENT_INS-TANCE/ObjectType)[1]', 'varchar(50)'); 
	begin
		print 'Тип события: '+@t;
		print 'Имя объекта: '+@t1;
		print 'Тип объекта: '+@t2;
		raiserror( N'операции с таблицей Товары запрещены', 16, 1);  
		rollback;    
	end;
go

drop table TR_AUDIT
go