use UNIVERlab4
select distinct GROUPS.IDGROUP[������]
from GROUPS inner join STUDENT 
on GROUPS.IDGROUP = STUDENT.IDGROUP inner join PROGRESS
on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
where PROGRESS.NOTE <=any (select PROGRESS.NOTE from PROGRESS where PROGRESS.NOTE < 6)

--������� ������ � ������� ���� �� � ������ �������� ����� ���� 6