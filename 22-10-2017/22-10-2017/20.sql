use ReportService

select c.Name as [Category Name],
       count(r.Id) AS [Reports Number]
 from Categories as c
 join Reports as r
    on r.CategoryId=c.Id
 join Status as s
   on s.Id=r.StatusId
   where s.Label in ('waiting','in progress')
   GROUP BY c.Name
ORDER BY c.Name,[Reports Number]



 