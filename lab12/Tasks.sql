use UNIVERlab4
go

--task1
declare @Buf nvarchar(50), @Result nvarchar(max) =''
--declare GlobalSubjectCursor cursor
--	for select SUBJECT.SUBJECT from SUBJECT where SUBJECT.PULPIT = '»—Ë“'
open GlobalSubjectCursor
	print 'ƒËÒˆËÔÎËÌ˚ Ì‡ Í‡ÙÂ‰Â "»—Ë“"'
	fetch GlobalSubjectCursor into @Result
	set @Result = RTRIM(@Result) +', '
	while @@FETCH_STATUS = 0
		begin
			fetch GlobalSubjectCursor into @buf
			set @Result = @Result + rtrim(@Buf) + ', '
		end
close GlobalSubjectCursor
print @Result
go

--task2
declare @LocalResult nvarchar(max), @Buf nvarchar(50)
declare LocalSubjectCursor cursor local
	for select SUBJECT.SUBJECT from SUBJECT where SUBJECT.PULPIT = '»—Ë“'
open LocalSubjectCursor
	fetch LocalSubjectCursor into @LocalResult
	set @LocalResult = RTRIM(@LocalResult) +', '
	while @@FETCH_STATUS = 0
		begin
			fetch LocalSubjectCursor into @buf
			set @LocalResult = @LocalResult + rtrim(@Buf) + ', '
		end
print 'Local result: ' + @LocalResult
go
declare @GlobalResult nvarchar(max), @Buf nvarchar(50)
open GlobalSubjectCursor
	fetch GlobalSubjectCursor into @GlobalResult
	set @GlobalResult = RTRIM(@GlobalResult) +', '
	while @@FETCH_STATUS = 0
		begin
			fetch GlobalSubjectCursor into @buf
			set @GlobalResult = @GlobalResult + rtrim(@Buf) + ', '
		end
close GlobalSubjectCursor
print 'Global result: ' + @GlobalResult
go

--task3
declare @result nvarchar(max)='', @buf nvarchar(50)=''
declare SubjectCursor cursor local static
	for select count(*) from SUBJECT where SUBJECT.PULPIT = '»—Ë“'
open SubjectCursor
	fetch SubjectCursor into @buf
	print 'Untill changes: ' +  @buf
insert SUBJECT(SUBJECT, SUBJECT_NAME, PULPIT) values('Ã¿“ œ–Œ√¿','Ã¿“≈Ã¿ œ–Œ√–¿ÃÃ»–Œ¬¿Õ»≈', '»—Ë“')
	fetch SubjectCursor into @buf
	print 'After changes: ' +  @buf
delete SUBJECT where SUBJECT.SUBJECT = 'Ã¿“ œ–Œ√¿'
go
--dymanic

--task4
declare @buf nvarchar(50)='', @number int
declare SubjectCursor cursor local dynamic
	for select ROW_NUMBER() over(order by SUBJECT.SUBJECT), SUBJECT.SUBJECT from SUBJECT where SUBJECT.PULPIT = '»—Ë“'
open SubjectCursor
	fetch first from SubjectCursor into @number, @buf
	print 'First line: ' + cast(@number as nvarchar(10)) + ' ' + @buf
	fetch last from SubjectCursor into @number, @buf
	print 'Last line: ' + cast(@number as nvarchar(10)) + ' ' + @buf
go

--task5
select * from SUBJECT where SUBJECT.PULPIT = '»—Ë“'
go
declare @result nvarchar(max)='', @buf nvarchar(50)=''
declare LocalCursor cursor local dynamic scroll
	for select SUBJECT.SUBJECT
		from SUBJECT where SUBJECT.PULPIT = '»—Ë“' for update
open LocalCursor
--delete
fetch first from LocalCursor into @buf
print 'Until delete: ' + @buf
delete SUBJECT where current of LocalCursor
fetch first from LocalCursor into @buf
print 'After delete: ' + @buf
--update
fetch first from LocalCursor into @buf
print 'Untill update: ' + @buf
update SUBJECT set SUBJECT.SUBJECT = '»ÁÏÂÌËÎ' where current of LocalCursor
fetch first from LocalCursor into @buf
print 'After update: ' + @buf
go

--task6
select PROGRESS.IDSTUDENT
	 from PROGRESS join STUDENT on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
		join GROUPS on STUDENT.IDGROUP = GROUPS.IDGROUP
			where PROGRESS.NOTE < 4
	