use Company_SD
--1
select Dno, Dname, SSN, Fname
from Departments, Employee
where SSN = MGRSSN
--2
select Dname, Pname
from Departments d, Project p
where d.Dnum = p.Dnum
--3
select d.*, Fname
from Dependent d, Employee
where SSN = ESSN
--4
select Pnumber, Pname, Plocation
from Project
where City in ('cairo', 'alex')
--5
select *
from Project
where Pname like 'a%'
--6
select *
from Employee
where Dno = 30 and Salary between 1000 and 2000
--7
select *
from Employee inner join Works_for
on SSN = ESSn and Dno = 10 and hours >= 10
inner join Project
on Pnumber = Pno and Pname = 'AL Rabwah'
--8
select e.Fname
from Employee e inner join Employee s
on s.Superssn = e.SSN and s.Fname = 'Kamel' and s.Lname = 'Mohamed'
--9
select e.fname, p.pname
from Employee e inner join Works_for
on SSN = ESSn
inner join Project p
on p.Pnumber = Pno
order by Pname
--10
select p.Pnumber, d.Dname, e.Lname, e.Address, e.Bdate
from Project p inner join Departments d
on d.Dnum = p.Dnum
inner join Employee e
on e.SSN = d.MGRSSN
--11
select e.*
from Employee e inner join Departments d
on e.SSN = d.MGRSSN
--12
select *
from Employee e left outer join Dependent d
on e.SSN = d.ESSN
--13
insert into Employee(Fname, Lname, SSN, Dno, Superssn, Salary)
values ('Mohab', 'Wafaie', 102672, 30, 112233, 3000)
--14
INSERT INTO employee (Fname, Lname, SSN, Dno)
VALUES ('saif', 'elkordy', 102660, 30)
--15
UPDATE employee
SET Salary = Salary * 1.20
WHERE SSN = 102672

select *
from Employee
where SSN = 102672