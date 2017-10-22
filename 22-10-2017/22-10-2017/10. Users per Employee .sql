use ReportService

select  DISTINCT CONCAT(FirstName,' ', LastName) as [Name],
                  count(r.UserId )  as [Users Number]         
 from Employees as e
left join Reports as r
   on r.EmployeeId=e.Id
group by CONCAT(FirstName,' ', LastName)
 order by [Users Number] desc,[Name]

 select* from Reports