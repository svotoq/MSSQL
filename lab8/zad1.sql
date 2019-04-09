use UNIVERlab4

--Zad1
select max(AUDITORIUM.AUDITORIUM_CAPACITY)[������������ �����������],
min(AUDITORIUM.AUDITORIUM_CAPACITY)[����������� �����������],
avg(AUDITORIUM.AUDITORIUM_CAPACITY)[������� �����������],
sum(AUDITORIUM.AUDITORIUM_CAPACITY)[��������� �����������],
count(*) [���������� ���������]
from AUDITORIUM

--Zad2
select AUDITORIUM_TYPE.AUDITORIUM_TYPE[��� ���������],
max(AUDITORIUM.AUDITORIUM_CAPACITY)[������������ �����������],
min(AUDITORIUM.AUDITORIUM_CAPACITY)[����������� �����������],
avg(AUDITORIUM.AUDITORIUM_CAPACITY)[������� �����������],
sum(AUDITORIUM.AUDITORIUM_CAPACITY)[��������� �����������],
count(*) [���������� ���������]
from AUDITORIUM inner join AUDITORIUM_TYPE
on AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE
group by AUDITORIUM_TYPE.AUDITORIUM_TYPE

--zad3
select case 
	when PROGRESS.NOTE = 10 then '10'
	when PROGRESS.NOTE between 8 and 9 then '8-9'
	when PROGRESS.NOTE between 6 and 7 then '6-7'
	when PROGRESS.NOTE between 4 and 5 then '4-5'
	end [������], count(*)[����������]
from PROGRESS group by case 
	when PROGRESS.NOTE = 10 then '10'
	when PROGRESS.NOTE between 8 and 9 then '8-9'
	when PROGRESS.NOTE between 6 and 7 then '6-7'
	when PROGRESS.NOTE between 4 and 5 then '4-5'
	end
--zad3-2
select*
from (select case 
	when PROGRESS.NOTE = 10 then '10'
	when PROGRESS.NOTE between 8 and 9 then '8-9'
	when PROGRESS.NOTE between 6 and 7 then '6-7'
	when PROGRESS.NOTE between 4 and 5 then '4-5'
	end [������], count(*)[����������]
from PROGRESS group by case 
	when PROGRESS.NOTE = 10 then '10'
	when PROGRESS.NOTE between 8 and 9 then '8-9'
	when PROGRESS.NOTE between 6 and 7 then '6-7'
	when PROGRESS.NOTE between 4 and 5 then '4-5'
	end ) as T
	order by case [������]
	when '10' then 1
	when '8-9' then 2
	when '6-7' then 3
	when '4-5' then 4
	end

--zad4
select	FACULTY.FACULTY[���������],
		GROUPS.PROFESSION[�������������],
		[����] = (select 2015 - g.YEAR_FIRST from GROUPS g where g.IDGROUP = GROUPS.IDGROUP),
		[������� ������] = (select avg(p.NOTE) from PROGRESS p 
		where p.IDSTUDENT = STUDENT.IDSTUDENT and STUDENT.IDGROUP = GROUPS.IDGROUP)
from	FACULTY inner join GROUPS 
		on FACULTY.FACULTY = GROUPS.FACULTY inner join STUDENT 
		on GROUPS.IDGROUP = STUDENT.IDGROUP

--zad5
--zad6
select	GROUPS.PROFESSION[�������������],
		PROGRESS.SUBJECT[����������],
		avg(PROGRESS.NOTE)[������� ������]
from	FACULTY inner join GROUPS
		on FACULTY.FACULTY = GROUPS.FACULTY inner join STUDENT
		on GROUPS.IDGROUP = STUDENT.IDGROUP inner join PROGRESS
		on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
where	FACULTY.FACULTY = '����'
		group by rollup(GROUPS.PROFESSION, PROGRESS.SUBJECT,FACULTY.FACULTY )