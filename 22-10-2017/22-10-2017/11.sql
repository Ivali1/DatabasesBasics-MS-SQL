select r.OpenDate,r.[Description], u.Email as [Reporter Email]
 from Users as u
 join Reports as r
   on r.UserId=u.Id
 join Categories as c
   on c.Id=r.CategoryId
 join Departments as d
   on d.Id=c.DepartmentId
where r.CloseDate IS NULL AND
       len(r.Description)>20 and 
	   r.[Description] like '%str%' and
	   d.[Name] IN ('Infrastructure','Emergency','Roads Maintenance')
ORDER BY r.OpenDate,[Reporter Email],r.Id
	   


	