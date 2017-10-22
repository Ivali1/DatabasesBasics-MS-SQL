USE ReportService

select group2.[Department Name], group2.[Average Duration]

 from (

SELECT [group].[Department Name],
     case

		when  cast([Average Duration] as nvarchar(20)) ='0'  then 'no info'
		else  cast([Average Duration] as nvarchar(20))
	 end as  [Average Duration]
FROM
(
SELECT d.Name as [Department Name], 
       r.OpenDate as  OpenDate,
	   r.CloseDate as CloseDate,
       isnull(AVG(DATEDIFF(Day,r.OpenDate,r.CloseDate)),'0') 
	   as [Average Duration]
 FROM Departments AS d
 JOIN Categories AS c
   ON c.DepartmentId=d.Id
 JOIN Reports AS r
   ON r.CategoryId=c.Id
 group by d.Name,r.OpenDate,r.CloseDate
 ) AS [group]
 ) as group2
order by group2.[Department Name]

