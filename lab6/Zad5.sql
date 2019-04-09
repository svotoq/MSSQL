USE UNIVERlab4
SELECT 
		STUDENT.NAME, 
		CASE 
		WHEN (PROGRESS.NOTE = 6 ) THEN '�����'
		WHEN (PROGRESS.NOTE = 7 ) THEN '����'
		WHEN (PROGRESS.NOTE = 8 ) THEN '������'
		end, SUBJECT.SUBJECT,
		PULPIT.PULPIT, FACULTY.FACULTY
		--, GROUPS.PROFESSION
FROM PROGRESS INNER JOIN STUDENT
ON PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT INNER JOIN SUBJECT
ON PROGRESS.SUBJECT = SUBJECT.SUBJECT INNER JOIN PULPIT
ON SUBJECT.PULPIT = PULPIT.PULPIT INNER JOIN FACULTY
ON PULPIT.FACULTY = FACULTY.FACULTY
 --INNER JOIN GROUPS
--ON FACULTY.FACULTY = GROUPS.FACULTY
WHERE PROGRESS.NOTE BETWEEN 6 AND 8 
ORDER BY
(CASE 
WHEN(PROGRESS.NOTE = 6) then 3
WHEN(PROGRESS.NOTE = 7) then 1
else 2
end)
