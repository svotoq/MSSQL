USE lab3Univer
CREATE TABLE RESULTS(
ID int primary key identity(1,1),
STUDENT_NAME nvarchar(20),
FIZIKA int not null,
MATHEMATICA int not null,
AVER_VALUE as (FIZIKA+MATHEMATICA)/2
);