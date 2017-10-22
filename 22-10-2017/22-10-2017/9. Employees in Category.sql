
select c.[Name] as CategoryName,
       count(e.Id) as [Employees Number]
 from Departments as d
 join Categories as c
   on c.DepartmentId=d.Id
 join Employees as e
   on e.DepartmentId=d.Id
group by c.[Name] 
order by c.[Name]