USE UNIVERlab4
CREATE TABLE TIMETABLE
(
ID integer  identity(1,1) constraint IDPAIR_PK  primary key, 
IDGROUP   integer  constraint TIMETABLE_GROUP_FK foreign key         
                      references GROUPS(IDGROUP),
AUDITORIUM   char(20)  constraint TIMETABLE_AUDITORIUM_PK  foreign key
						references AUDITORIUM(AUDITORIUM),
SUBJECT   char(10) constraint TIMETABLE_SUBJECT_FK foreign key
                      references SUBJECT(SUBJECT),   
TEACHER  char(10) constraint TIMETABLE_TEACHER_FK foreign key
						references TEACHER(TEACHER),
DAY nvarchar(15),
PAIR int CHECK(PAIR BETWEEN 1 AND 9)
);

insert into  TEACHER    (IDGROUP, AUDITORIUM, SUBJECT, TEACHER, DAY, PAIR )
                       values  ('1',    '206-1', '',  'ศั่า'),
           
