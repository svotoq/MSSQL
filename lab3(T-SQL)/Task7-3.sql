USE lab3Univer
CREATE TABLE STUDENT
(
[Номер зачетки] bigint primary key,
Имя nvarchar(20) not null,
Пол nvarchar(10) Check(Пол in ('м','ж'))
);