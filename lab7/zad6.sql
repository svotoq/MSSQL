use UNIVERlab4
select top 1 
	(select avg(PROGRESS.NOTE) from PROGRESS
			where PROGRESS.SUBJECT = '����')[����],
	(select avg(PROGRESS.NOTE) from PROGRESS
			where PROGRESS.SUBJECT = '��')[��],
	(select avg(PROGRESS.NOTE) from PROGRESS
			where PROGRESS.SUBJECT = '����')[����]
from PROGRESS