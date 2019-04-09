create table PROGRESS
 (  SUBJECT   char(10) constraint PROGRESS_SUBJECT_FK foreign key
                      references SUBJECT(SUBJECT),                
     IDSTUDENT integer  constraint PROGRESS_IDSTUDENT_FK foreign key         
                      references STUDENT(IDSTUDENT),        
     PDATE    date, 
     NOTE     integer check (NOTE between 1 and 10)
  )
insert into PROGRESS (SUBJECT,IDSTUDENT,PDATE, NOTE)
    values ('нюХо', 1000,  '01.10.2013',6),
           ('нюХо', 1001,  '01.10.2013',8),
           ('нюХо', 1002,  '01.10.2013',7),
           ('нюХо', 1003,  '01.10.2013',5),
           ('нюХо', 1005,  '01.10.2013',4),
      ('ясад', 1014,  '01.12.2013',5),
           ('ясад', 1015,  '01.12.2013',9),
           ('ясад', 1016,  '01.12.2013',5),
           ('ясад', 1017,  '01.12.2013',4),
    ('йц',   1018,  '06.5.2013',4),
           ('йц',   1019,  '06.05.2013',7),
           ('йц',   1020,  '06.05.2013',7),
           ('йц',   1021,  '06.05.2013',9),
           ('йц',   1022,  '06.05.2013',5),
           ('йц',   1023,  '06.05.2013',6)
