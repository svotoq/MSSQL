USE UNIVERlab4
--1
SELECT*FROM PULPIT FULL OUTER JOIN TEACHER ON PULPIT.PULPIT = TEACHER.PULPIT
WHERE TEACHER.PULPIT IS NULL
--2
SELECT*FROM PULPIT FULL OUTER JOIN TEACHER ON PULPIT.PULPIT = TEACHER.PULPIT
WHERE PULPIT.PULPIT IS NULL
--3
SELECT*FROM PULPIT FULL OUTER JOIN TEACHER ON PULPIT.PULPIT = TEACHER.PULPIT
WHERE TEACHER.PULPIT IS NOT NULL
