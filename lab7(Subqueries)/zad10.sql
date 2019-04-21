use UNIVERlab4

select s1.NAME, s1.BDAY
from STUDENT s1
where exists (select s2.BDAY from STUDENT s2 where s2.BDAY = s1.BDAY and s2.NAME <> s1.NAME) order by s1.BDAY desc