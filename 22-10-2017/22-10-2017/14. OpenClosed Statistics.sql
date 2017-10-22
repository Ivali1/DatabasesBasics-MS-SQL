use ReportService
select Name, 
       concat(cast([Closed Reparts] as nvarchar(10)),'/',
         cast([Open Reparts] as nvarchar(10)))
from(
select CONCAT(FirstName, ' ', LastName) as Name,
       COUNT(DATEPART(YEAR,r.CloseDate)) as [Closed Reparts] ,
	    COUNT(DATEPART(YEAR,r.OpenDate)) AS [Open Reparts],
	e.Id
 from Employees as e
 join Reports as r
    on r.EmployeeId=e.Id
 where (DATEPART(YEAR,r.OpenDate)=2016 and r.CloseDate is NULL) or(
       DATEPART(YEAR,r.CloseDate)=2016 )
group by CONCAT(FirstName, ' ', LastName),e.Id
) as cv
order by cv.Name,cv.Id


