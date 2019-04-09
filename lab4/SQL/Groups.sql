USE UniverPyrkinLab4
create table GROUPS 
(   IDGROUP  integer  identity(1,1) constraint GROUP_PK  primary key,              
    FACULTY   char(10) constraint  GROUPS_FACULTY_FK foreign key         
                                                         references FACULTY(FACULTY), 
     PROFESSION  char(20) constraint  GROUPS_PROFESSION_FK foreign key         
                                                         references PROFESSION(PROFESSION),
    YEAR_FIRST  smallint  check (YEAR_FIRST<=YEAR(GETDATE())),                  
  )
insert into GROUPS   (FACULTY,  PROFESSION, YEAR_FIRST )
         values ('ÕÒèÒ','1-36 01 08', 2013),---12 ãð                                                  
                ('ÕÒèÒ','1-36 01 08', 2012),
                ('ÕÒèÒ','1-36 07 01', 2011),
                ('ÕÒèÒ','1-36 07 01', 2010),
                ('ÒÎÂ','1-48 01 02', 2012), ---16 ãð 
                ('ÒÎÂ','1-48 01 02', 2011),
                ('ÒÎÂ','1-48 01 05', 2013),
                ('ÒÎÂ','1-54 01 03', 2012),
                ('ËÕÔ','1-75 01 01', 2013),--20 ãð      
                ('ËÕÔ','1-75 02 01', 2012),
                ('ËÕÔ','1-75 02 01', 2011),
                ('ËÕÔ','1-89 02 02', 2012),
                ('ËÕÔ','1-89 02 02', 2011),  
                ('ÒÒËÏ','1-36 05 01', 2013),
                ('ÒÒËÏ','1-36 05 01', 2012),
                ('ÒÒËÏ','1-46 01 01', 2012),--27 ãð
                ('ÈÝÔ','1-25 01 07', 2013), 
                ('ÈÝÔ','1-25 01 07', 2012),     
                ('ÈÝÔ','1-25 01 07', 2010),
                ('ÈÝÔ','1-25 01 08', 2013),
                ('ÈÝÔ','1-25 01 08', 2012) ---32 ãð       
