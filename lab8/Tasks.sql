use UNIVERlab4

--Task1
select max(AUDITORIUM.AUDITORIUM_CAPACITY)[Максимальная вместимость],
min(AUDITORIUM.AUDITORIUM_CAPACITY)[Минимальная вместимость],
avg(AUDITORIUM.AUDITORIUM_CAPACITY)[Средняя вместимость],
sum(AUDITORIUM.AUDITORIUM_CAPACITY)[Суммарная вместимость],
count(*) [Количество аудиторий]
from AUDITORIUM

--Task2
select AUDITORIUM_TYPE.AUDITORIUM_TYPE[Тип аудитории],
max(AUDITORIUM.AUDITORIUM_CAPACITY)[Максимальная вместимость],
min(AUDITORIUM.AUDITORIUM_CAPACITY)[Минимальная вместимость],
avg(AUDITORIUM.AUDITORIUM_CAPACITY)[Средняя вместимость],
sum(AUDITORIUM.AUDITORIUM_CAPACITY)[Суммарная вместимость],
count(*) [Количество аудиторий]
from AUDITORIUM inner join AUDITORIUM_TYPE
on AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE
group by AUDITORIUM_TYPE.AUDITORIUM_TYPE

--Task3
select case 
	when PROGRESS.NOTE = 10 then '10'
	when PROGRESS.NOTE between 8 and 9 then '8-9'
	when PROGRESS.NOTE between 6 and 7 then '6-7'
	when PROGRESS.NOTE between 4 and 5 then '4-5'
	end [Оценки], count(*)[Количество]
from PROGRESS group by case 
	when PROGRESS.NOTE = 10 then '10'
	when PROGRESS.NOTE between 8 and 9 then '8-9'
	when PROGRESS.NOTE between 6 and 7 then '6-7'
	when PROGRESS.NOTE between 4 and 5 then '4-5'
	end
--Task3-2
select*
from (select case 
	when PROGRESS.NOTE = 10 then '10'
	when PROGRESS.NOTE between 8 and 9 then '8-9'
	when PROGRESS.NOTE between 6 and 7 then '6-7'
	when PROGRESS.NOTE between 4 and 5 then '4-5'
	end [Оценки], count(*)[Количество]
from PROGRESS group by case 
	when PROGRESS.NOTE = 10 then '10'
	when PROGRESS.NOTE between 8 and 9 then '8-9'
	when PROGRESS.NOTE between 6 and 7 then '6-7'
	when PROGRESS.NOTE between 4 and 5 then '4-5'
	end ) as T
	order by case [Оценки]
	when '10' then 1
	when '8-9' then 2
	when '6-7' then 3
	when '4-5' then 4
	end

--Task4
select FACULTY.FACULTY as faculty, GROUPS.PROFESSION as proffesion, (2015 - GROUPS.YEAR_FIRST) as Course, round(avg(cast(PROGRESS.NOTE as float(4))),2) as Note
	from FACULTY join GROUPS on FACULTY.FACULTY = GROUPS.FACULTY
		join STUDENT on GROUPS.IDGROUP = STUDENT.IDGROUP
			join PROGRESS on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
			group by FACULTY.FACULTY, GROUPS.PROFESSION, GROUPS.YEAR_FIRST
				order by Note desc
--Task5
select FACULTY.FACULTY as faculty, GROUPS.PROFESSION as proffesion, (2015 - GROUPS.YEAR_FIRST) as Course, round(avg(cast(PROGRESS.NOTE as float(4))),2) as Note
	from FACULTY join GROUPS on FACULTY.FACULTY = GROUPS.FACULTY
		join STUDENT on GROUPS.IDGROUP = STUDENT.IDGROUP
			join PROGRESS on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
				where PROGRESS.SUBJECT in ('БД','ОАиП')
					group by FACULTY.FACULTY, GROUPS.PROFESSION, GROUPS.YEAR_FIRST
						order by Note desc
--Task6
select	GROUPS.PROFESSION[Специальность],
		PROGRESS.SUBJECT[Дисциплины],
		avg(PROGRESS.NOTE)[Средние оценки]
from	FACULTY inner join GROUPS on FACULTY.FACULTY = GROUPS.FACULTY
		inner join STUDENT on STUDENT.IDGROUP = GROUPS.IDGROUP
		inner join PROGRESS on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
where FACULTY.FACULTY = 'ХТиТ'
Group by rollup (GROUPS.PROFESSION, PROGRESS.SUBJECT)
--Task7
--Group by cube(GROUPS.PROFESSION, PROGRESS.SUBJECT)
--Task8
select	GROUPS.PROFESSION[Специальность],
		PROGRESS.SUBJECT[Дисциплины],
		avg(PROGRESS.NOTE)[Средние оценки]
from	FACULTY inner join GROUPS on FACULTY.FACULTY = GROUPS.FACULTY
		inner join STUDENT on STUDENT.IDGROUP = GROUPS.IDGROUP
		inner join PROGRESS on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
where FACULTY.FACULTY = 'ХТиТ'
Group by rollup (GROUPS.PROFESSION, PROGRESS.SUBJECT)
union all
--Task9 
--intersect
--Task10
--except
select	GROUPS.PROFESSION[Специальность],
		PROGRESS.SUBJECT[Дисциплины],
		avg(PROGRESS.NOTE)[Средние оценки]
from	FACULTY inner join GROUPS on FACULTY.FACULTY = GROUPS.FACULTY
		inner join STUDENT on STUDENT.IDGROUP = GROUPS.IDGROUP
		inner join PROGRESS on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
where FACULTY.FACULTY = 'ТОВ'
Group by rollup (GROUPS.PROFESSION, PROGRESS.SUBJECT)

--Task11
select	PROGRESS.NOTE[Оценка],
		Count(PROGRESS.IDSTUDENT)[Студентов]
from	PROGRESS
group by PROGRESS.NOTE
having PROGRESS.NOTE = 8 or PROGRESS.NOTE = 9