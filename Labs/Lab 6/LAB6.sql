use ITI
--1
alter function getMonth(@d date)
returns varchar(20)
	begin
		declare @date varchar(20)
		select @date = FORMAT(@d, 'MMMM')
		return @date
	end
select dbo.getMonth(getdate())
--2
create function getnum(@num1 int, @num2 int)
returns @t table(nums int)
	begin
		declare @x int = @num1
		while @x < @num2
			begin
				insert into @t
				select @x
				select @x +=1
			end
		return
	end
select * from getnum(3,8)
--3
create function stInfo(@num int)
returns table
	return(
		   select s.St_Fname+' '+s.St_Lname as fullname, d.Dept_Name 
		   from Student s inner join Department d
		   on d.Dept_Id = s.Dept_Id and s.St_Id = @num
		   )
select * from stInfo(3)
--4
alter function namecheck(@num int)
returns varchar(30)
	begin
		declare @name varchar(30)
		select @name = case
							when St_Fname is null and St_Lname is null then 'First name and Last name are null'
							when St_Fname is null then 'First name is null'
							when St_Lname is null then 'Last name is null'
							else 'First name and Last name are not null'
						end
		from Student
		where St_Id = @num
		return @name
	end
select dbo.namecheck(13)
--5
create function deptInfo(@num int)
returns table
	return(
			select d.Dept_Name, i.Ins_Name, d.Manager_hiredate
			from Department d inner join Instructor i
			on i.Ins_Id = d.Dept_Manager and d.Dept_Manager = @num
			)
select * from deptInfo(2)
--6
create or alter function getstuds(@format varchar(20))
returns @t table(id int,name varchar(20))
as
	begin
		if @format='first'
			insert into @t
			select st_id,isnull(st_fname, 'first name') from Student
		else if @format='last'
			insert into @t
			select st_id,isnull(st_lname, 'last name') from Student
		else if @format='fullname'
			insert into @t
			select st_id,concat(isnull(st_fname, 'first name'),' ',isnull(st_lname, 'last name')) from Student
		return 
	end
select * from getstuds('first')
--7
select s.St_Id ,substring(s.st_fname,1,len(s.st_fname)-1)
from Student s
--8
delete c
from Stud_Course c inner join Student s
on s.St_Id = c.St_Id
inner join Department d
on d.Dept_Id = s.Dept_Id and d.Dept_Name = 'SD'
--9
merge dbo.lastTransaction as t
using dbo.DailyTransaction as s
on t.UserId = s.UserId
when matched then
	update set t.TransactionAmount = s.TransactionAmount
when not matched then
	insert (UserId, TransactionAmount) values (s.UserId, s.TransactionAmount);
--10 
select * from Student
delete from Student
select * from Department