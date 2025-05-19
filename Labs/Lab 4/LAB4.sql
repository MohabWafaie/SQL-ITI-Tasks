use Company_SD
--1
select Dependent_name, d.Sex
from Dependent d inner join Employee e
on SSN = ESSN and e.Sex = 'F' and d.Sex = 'F'
union all
select Dependent_name, d.Sex
from Dependent d inner join Employee e
on SSN = ESSN and e.Sex = 'M' and d.Sex = 'M'
--2
select Pname, SUM(w.Hours)
from Project p inner join Works_for w
on Pnumber = Pno
group by Pname
--3
select d.*
from Departments d inner join Employee e
on d.Dnum = e.Dno and SSN = (select MIN(SSN) from Employee)
--4
select Dname, MAX(Salary) as max, MIN(salary) as min, AVG(salary) as avg
from Employee inner join Departments
on Dnum = Dno and Dno is not null
group by Dname
--5
Select e.Fname+' '+e.Lname as fullname
from Employee e
where SSN not in (select ESSN from Dependent)
--6
select Dnum, Dname, AVG(Salary) as average, COUNT(SSn) as number
from Employee inner join Departments
on Dnum = Dno and Dno is not null
group by Dname, Dnum
having AVG(salary) < (select AVG(salary) from Employee)
--7
select e.Fname, e.Lname, p.Pname, e.Dno
from Employee e inner join Works_for w
on e.SSN = w.ESSn
inner join Project p
on p.Pnumber = w.Pno
order by e.Dno, e.Lname, e.Fname
--8
select MAX(salary) as maxi
from Employee
union
select MAX(salary)
from Employee
where Salary != (select MAX(salary) from Employee)
--9
select e.Fname+' '+e.Lname as fullname
from Employee e inner join Dependent d
on e.Fname + ' ' + e.Lname = d.Dependent_name
--10
SELECT E.Fname, E.Lname
FROM Employee E
WHERE EXISTS (
    SELECT 1
    FROM Dependent D
    WHERE D.ESSN = E.SSN)
--11
insert into Departments
values ('DEPT IT', 100, 112233, '1-11-2006')
--12
update Departments
set MGRSSN = 968574
where Dnum = 100
update Departments
set MGRSSN = 102672
where Dnum = 20
update Employee
set Superssn = 102672
where SSN = 102660 
--13
delete from Dependent
where ESSN = 223344
update Works_for
set ESSn = 102672
where ESSn = 223344
update Departments
set MGRSSN = 102672
where MGRSSN = 223344
update Employee
set Superssn = 102672
where Superssn = 223344
delete from Employee
where SSN = 223344
--14
update Employee
set Salary = Salary*1.3
where SSN in (select SSN 
			  from Employee e inner join Works_for w
			  on e.SSN = w.ESSn
			  inner join Project p
			  on p.Pnumber = w.Pno and Pname = 'Al Rabwah')


				
select * from Departments
select * from Works_for
select * from Project
select * from Employee
select * from Dependent