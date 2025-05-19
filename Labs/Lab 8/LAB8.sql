use ITI
--1
create proc NoStud
as
	select d.Dept_Name, count(s.St_Id)
	from Student s inner join Department d
	on d.Dept_Id = s.Dept_Id
	group by d.Dept_Name

NoStud
--2
use Company_SD
create or alter proc NoEmp @Pno int
as
	declare @t table(fullname varchar(20))
	insert into @t
	select e.Fname+' '+e.Lname
		from Employee e inner join Works_for w
		on e.SSN = w.ESSn
		inner join Company.Project p
		on p.Pnumber = w.Pno and p.Pnumber = @Pno;
	if (select COUNT(*) from @t) >= 3
		select concat('the no number of employees in project ',@Pno,' is 3 or more')
	else
		SELECT concat('The following employees work for the project ',@Pno,' ', STRING_AGG(fullname, ', ')) AS Names FROM @t

NoEmp 100
--3
create proc upemp @oid int, @nid int, @pno int
as
	update Works_for
	set ESSn = @nid
	where ESSn = @oid and Pno = @pno

upemp 102672, 512463, 100

select * from Works_for
--4
create trigger audit_trigger
on company.project
after update
as
	if update(budget)
	begin
		insert into audit
		select i.pnumber, SUSER_NAME(), GETDATE(), d.budget, i.budget
		from inserted i inner join deleted d
		on i.Pnumber = d.Pnumber
	end
--5
use ITI
create trigger deptins
on department
instead of insert
as
	select 'you cannot insert a new record in that table'

insert into Department(Dept_Id, Dept_Name)
values(80, 'software')
--6
use Company_SD
create or alter trigger empins
on employee
instead of insert
as
	if  format(getdate(), 'MMMM') = 'March'
		select 'you cannot insert data in march'
	else 
		begin
			insert into employee
			select * from inserted
		end

insert into Employee(SSN, Fname)
values(1234,'mohab')

select * from Employee
--7
use ITI
create or alter trigger auditrigger
on student
after insert
as
	insert into studentAudit
	select SUSER_NAME(), GETDATE(), CONCAT(suser_name(), 'Insert New Row with Key= ',st_id, ' in table Student')
	from inserted

insert into Student(St_Id, St_Fname)
values(15,'mohab')

select * from studentAudit
--8
create trigger stdel
on student
instead of delete
as
	insert into studentAudit
	select SUSER_NAME(), GETDATE(), CONCAT('try to delete Row with Key= ',st_id)
	from deleted

delete from Student
where St_Id = 15

select * from Student

select * from studentAudit
