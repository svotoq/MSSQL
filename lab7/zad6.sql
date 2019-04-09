use UNIVERlab4
select top 1 
	(select avg(PROGRESS.NOTE) from PROGRESS
			where PROGRESS.SUBJECT = 'нюХо')[нюХо],
	(select avg(PROGRESS.NOTE) from PROGRESS
			where PROGRESS.SUBJECT = 'ад')[ад],
	(select avg(PROGRESS.NOTE) from PROGRESS
			where PROGRESS.SUBJECT = 'ясад')[ясад]
from PROGRESS