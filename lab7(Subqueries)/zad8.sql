use UNIVERlab4
select distinct GROUPS.IDGROUP[Группа]
from GROUPS inner join STUDENT 
on GROUPS.IDGROUP = STUDENT.IDGROUP inner join PROGRESS
on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
where PROGRESS.NOTE <=any (select PROGRESS.NOTE from PROGRESS where PROGRESS.NOTE < 6)

--выбрать группу в которой хотя бы у одного студента оцена ниже 6