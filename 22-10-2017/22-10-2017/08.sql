SELECT c.Name as CategoryName,
       count(r.Id) as ReportsNumber
  FROM Categories AS c
  join Reports AS r
    ON r.CategoryId=c.Id
group by c.Name
order by ReportsNumber desc, c.Name

  select* from Reports