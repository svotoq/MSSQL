USE UniverPyrkinLab4
 create table TEACHER
 (   TEACHER    char(10)  constraint TEACHER_PK  primary key,
     TEACHER_NAME  varchar(100), 
     GENDER     char(1) CHECK (GENDER in ('�', '�')),
     PULPIT   char(20) constraint TEACHER_PULPIT_FK foreign key 
                         references PULPIT(PULPIT) 
 );
insert into  TEACHER    (TEACHER,   TEACHER_NAME, GENDER, PULPIT )
                       values  ('����',    '������ �������� �������������', '�',  '����');
insert into  TEACHER    (TEACHER,   TEACHER_NAME, GENDER, PULPIT )
                       values  ('�����',    '�������� ��������� ��������', '�', '����');
insert into  TEACHER    (TEACHER,   TEACHER_NAME, GENDER, PULPIT )
                       values  ('�����',    '���������� ������� ����������', '�', '����');
insert into  TEACHER    (TEACHER,   TEACHER_NAME, GENDER, PULPIT )
                       values  ('�����',    '�������� ������ ��������', '�', '����');
insert into  TEACHER    (TEACHER,   TEACHER_NAME, GENDER, PULPIT )
                       values  ('���',     '����� ��������� ����������', '�', '����');
insert into  TEACHER    (TEACHER,   TEACHER_NAME, GENDER, PULPIT )
                       values  ('���',     '��������� ����� ��������', '�', '����');
insert into  TEACHER    (TEACHER,   TEACHER_NAME, GENDER, PULPIT )
                      values  ('���',     '����� ������� ��������', '�', '����');
insert into  TEACHER    (TEACHER,   TEACHER_NAME, GENDER, PULPIT )
                       values  ('���',     '����� ������� �������������',  '�', '����');                     
insert into  TEACHER    (TEACHER,   TEACHER_NAME, GENDER, PULPIT )
                       values  ('���',     '����� ����� �������������',  '�',   '����');                                                                                           
insert into  TEACHER    (TEACHER,   TEACHER_NAME, GENDER, PULPIT )
                       values  ('������',   '����������� ��������� ��������', '�', '����');
insert into  TEACHER    (TEACHER,   TEACHER_NAME, GENDER, PULPIT )
                       values  ('����',   '������� ��������� ����������', '�', '����');
insert into  TEACHER    (TEACHER,   TEACHER_NAME, GENDER, PULPIT )
                       values  ('����', '������� ������ ����������',  '�',  '������');
insert into  TEACHER    (TEACHER,   TEACHER_NAME, GENDER, PULPIT )
                       values  ('���',     '���������� ������� ��������', '�', '������');
insert into  TEACHER    (TEACHER,   TEACHER_NAME, GENDER, PULPIT )
                       values  ('���',   '������ ������ ���������� ', '�', '��');                      
insert into  TEACHER    (TEACHER,   TEACHER_NAME, GENDER, PULPIT )
                       values  ('�����',   '��������� �������� ���������', '�', '�����'); 
insert into  TEACHER    (TEACHER,   TEACHER_NAME, GENDER, PULPIT )
                       values  ('������',   '���������� �������� ����������', '�', '��'); 
insert into  TEACHER    (TEACHER,   TEACHER_NAME, GENDER, PULPIT )
                       values  ('�����',   '�������� ������ ����������', '�', '��'); 
