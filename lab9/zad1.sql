se UNIVERlab4
go
--zad1
create view	[Преподаватель]
	as select	TEACHER.TEACHER			[Код],
				TEACHER.TEACHER_NAME	[Имя преподавателя],
				TEACHER.GENDER			[Пол],
				TEACHER.PULPIT			[Код кафедры]
	from		TEACHER
go
--zad2
create view [Количество кафедр]
	as select	FACULTY.FACULTY			[Факультет],
				count(PULPIT.PULPIT)	[Количество кафедр]
	from FACULTY inner join PULPIT on FACULTY.FACULTY = PULPIT.FACULTY
	group by FACULTY.FACULTY
go
--zad3
create view [Аудитории]
	as select	AUDITORIUM.AUDITORIUM		[Код],
				AUDITORIUM.AUDITORIUM_NAME	[Наименование аудитории],
				AUDITORIUM.AUDITORIUM_TYPE  [Тип аудитории]
	from		AUDITORIUM
	where		AUDITORIUM.AUDITORIUM_TYPE Like 'ЛК%'
go
insert [Аудитории] values('210-1','210-1','ЛК-К')
go
--zad4
create view [Лекционные аудитории]
	as select	AUDITORIUM.AUDITORIUM		[Код],
				AUDITORIUM.AUDITORIUM_NAME	[Наименование аудитории],
				AUDITORIUM.AUDITORIUM_TYPE  [Тип аудитории]
	from		AUDITORIUM
	where		AUDITORIUM.AUDITORIUM_TYPE like 'ЛК%' with check option
go
insert [Лекционные аудитории] values('173-4','173-4','ЛБ-К')
go
create view [Дисицплины]
	as select top 150	
				SUBJECT.SUBJECT			[Код],
				SUBJECT.SUBJECT_NAME	[Наименование дисциплины],
				SUBJECT.PULPIT			[Код кафедры]
	from		SUBJECT
	order by SUBJECT_NAME
go
alter view [Количество кафедр] with schemabinding
	as select	fc.FACULTY			[Факультет],
				count(pu.PULPIT)	[Количество кафедр]
	from dbo.FACULTY fc join dbo.PULPIT pu on fc.FACULTY = pu.FACULTY
	group by fc.FACULTY
go
