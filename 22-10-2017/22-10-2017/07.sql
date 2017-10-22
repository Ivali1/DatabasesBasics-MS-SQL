use ReportService

select e.FirstName as FirstName,
       e.LastName as LastName,
	    r.Description as Description,
		cast(r.OpenDate as date) AS OpenDate
  from Employees as e
 join Reports as r
     ON r.EmployeeId=e.Id
order by r.EmployeeId,OpenDate,r.Id
