use ITI
--1
select count(s.St_Id)
from Student s
--2
select distinct i.Ins_Name
from Instructor i
--3
select s.St_Id as 'student id', isnull(s.St_Fname, '')+' '+isnull(s.St_Lname, '') as 'student full name', s.Dept_Id as 'department id'

from Student s
--4
select i.Ins_Name, d.Dept_Name
from Instructor i left join Department d
on d.Dept_Id = i.Dept_Id
--5
select s.ST_Fname+' '+s.ST_Lname as fullname, c.Crs_Name
from Student s inner join Stud_Course t
on s.St_Id = t.St_Id and t.Grade is not null
inner join Course c
on c.Crs_Id = t.Crs_Id
--6
select c.Crs_Name, COUNT(s.Crs_Id)
from Course c inner join Stud_Course s
on c.Crs_Id = s.Crs_Id
group by c.Crs_Name
--7
select max(Salary), min(Salary)
from Instructor
--8
select *
from Instructor
where Salary < (select avg(Salary) from Instructor)
---9
select top(1) d.Dept_Name
from Department d inner join Instructor i
on d.Dept_Id = i.Dept_Id
order by i.Salary
--10
select top(2) Salary
from Instructor
order by Salary desc
--11
select Ins_Name, coalesce(convert(varchar, salary), 'instructor bonus') as 'instructor salary'
from Instructor
--12
select AVG(salary)
from Instructor
--13
select st.St_Fname, su.*
from Student st inner join  Student su
on su.St_Id = st.St_super
--14
select *
from (select salary, Dept_Id, dense_rank() over(partition by dept_id order by salary desc) as rn
from Instructor where salary is not null) as t
where rn <=2
--15
select *
from (select *, ROW_NUMBER() over(partition by dept_id order by newid()) as rn
	  from Student) as t
where rn = 1

select * from Student
select * from Instructor
select * from Course
select * from Stud_Course

use AdventureWorks2012
--1
select SalesOrderID, ShipDate
from Sales.SalesOrderHeader
where ShipDate between '7/28/2002' and '7/29/2014'
--2
select ProductID, Name
from Production.Product
where StandardCost < 110
--3
select ProductID, Name
from Production.Product
where Weight is null
--4
select *
from Production.Product
where Color in ('Silver', 'Black', 'Red')
--5
select *
from Production.Product
where Name like 'B%'
--6
UPDATE Production.ProductDescription
SET Description = 'Chromoly steel_High of defects'
WHERE ProductDescriptionID = 3

select Description
from Production.ProductDescription
where Description like '%\_%' escape '\'
--7
select sum(TotalDue), OrderDate
from Sales.SalesOrderHeader
where OrderDate between '7/1/2001' and '7/31/2014'
group by OrderDate
--8
select distinct HireDate
from HumanResources.Employee
--9
select avg(distinct ListPrice)
from Production.Product
--10
select 'The '+Name+' is only! '+convert(varchar, ListPrice) as'product'
from Production.Product
where ListPrice between 100 and 120
order by ListPrice
--11
select rowguid, Name, SalesPersonID, Demographics into store_Archive
 from Sales.Store

 drop table store_Archive

select rowguid, Name, SalesPersonID, Demographics into store_Archive
 from Sales.Store
 where 1=2
 --12
SELECT CONVERT(VARCHAR, GETDATE(), 101) AS TodayDateStyle 
UNION
SELECT CONVERT(VARCHAR, GETDATE(), 103)                    
UNION
SELECT CONVERT(VARCHAR, GETDATE(), 104)                    
UNION
SELECT FORMAT(GETDATE(), 'dddd, MMMM dd, yyyy')            
UNION
SELECT FORMAT(GETDATE(), 'yyyy-MM-dd')                     
UNION
SELECT FORMAT(GETDATE(), 'MM/dd/yyyy hh:mm tt');        

select FORMAT(getDate(), 'MMMM')
