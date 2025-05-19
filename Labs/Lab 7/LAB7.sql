use ITI
--1
create view sdata(fullname, coursename)
as
	select s.St_Fname+' '+s.St_Lname, c.Crs_Name
	from Student s inner join Stud_Course k
	on s.St_Id = k.St_Id and k.Grade > 50
	inner join Course c
	on c.Crs_Id = k.Crs_Id
select * from sdata
--2
create view managetopics(managername, topics)
with encryption
as
	select i.Ins_Name, t.Top_Name
	from Department d inner join Instructor i
	on d.Dept_Manager = i.Ins_Id
	inner join Ins_Course ic
	on ic.Ins_Id = i.Ins_Id
	inner join Course c
	on c.Crs_Id = ic.Crs_Id
	inner join Topic t
	on t.Top_Id = c.Top_Id
select * from managetopics
--3
create view insdata(insname, deptname)
as
	select I.Ins_Name, D.Dept_Name
	from Instructor i inner join Department d
	on d.Dept_Id = i.Dept_Id  and d.Dept_Name in ('Java','SD')
select * from insdata
--4
create view v1
as
	select *
	from Student
	where St_Address in ('cairo', 'alex')
with check option
Update V1 set st_address='tanta'
Where st_address='alex';
--5
use Company_SD
create view projectInfo(projectName, noOfWorkers)
as
	select p.Pname, COUNT(w.essn)
	from Project p inner join Works_for w
	on p.Pnumber = w.Pno
	group by p.Pname
select * from projectInfo
--6
create schema Company
alter schema Company transfer Departments
create schema HumanResources
alter schema HumanResources transfer Employee
--7
use ITI
create clustered index i1
on Department(manager_Hiredate)
--Cannot create more than one clustered index on table 'Department'. Drop the existing clustered index 'PK_Department' before creating another.
--8
create unique index i8 
on student(st_age)
--The CREATE UNIQUE INDEX statement terminated because a duplicate key was found for the object name 'dbo.Student' and the index name 'i8'. The duplicate key value is (21).
--9
use Company_SD
declare c1 cursor
for select salary from HumanResources.Employee
for update --Modify
declare @sal int
open c1
fetch c1 into @sal
while @@FETCH_STATUS=0
	begin
		if @sal>=3000
			update HumanResources.Employee
				set Salary=@sal*1.20
			where current of c1
		else if @sal<3000
			update HumanResources.Employee
				set Salary=@sal*1.10
			where current of c1
		fetch c1 into @sal
	end
close c1
deallocate c1
--10
use ITI
declare c1 cursor
for select d.Dept_Name, i.Ins_Name from Department d inner join Instructor i on d.Dept_Manager = i.Ins_Id
for read only   
declare @dname varchar(20),@name varchar(20)
open c1
fetch c1 into @dname,@name
while @@FETCH_STATUS=0
	begin
		select @dname,@name
		fetch c1 into @dname,@name
	end
close c1
deallocate c1
--11
declare c1 cursor
for select i.Ins_Name from Instructor i
for read only
declare @name varchar(20), @allnames varchar(500)
open c1
fetch c1 into @name
while @@FETCH_STATUS=0
	begin
		select @allnames = concat(@allnames, ',',@name)
		fetch c1 into @name
	end
select @allnames
close c1
deallocate c1
--12

select * from Department
select * from Instructor
select * from Ins_Course
select * from Course
select * from Topic
select * from Student
select * from Stud_Course
select * from Course