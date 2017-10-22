SELECT f.ProductId, f.Rate, f.[Description], f.CustomerId,c.Age,c.Gender
 FROM Feedbacks  AS f
 join Customers as c
   on c.Id=f.CustomerId
where f.Rate<5
order by f.ProductId desc, f.Rate