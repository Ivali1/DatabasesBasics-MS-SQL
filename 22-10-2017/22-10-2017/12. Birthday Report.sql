
 select DISTINCT c.Name as [Category Name]
   from Users as u
   join Reports as r
      on r.UserId=u.Id
   join Categories as c
     on c.Id=r.CategoryId
	where datepart(DAY,u.BirthDate)=datepart(DAY,r.OpenDate) and
	      datepart(MONTH,u.BirthDate)=datepart(MONTH,r.OpenDate)
order by c.Name