SELECT f.ProductId ,
       CONCAT(c.FirstName,' ',c.LastName) AS CustomerName,
	   f.[Description] AS [FeedbackDescription]	   
 FROM Customers AS c
 JOIN Feedbacks AS f
   ON f.CustomerId=c.Id
WHERE f.CustomerId IN (SELECT CustomerId 
                        FROM Feedbacks
						GROUP BY CustomerId
						HAVING COUNT(Rate)>=3)
ORDER BY f.ProductId,CustomerName,f.Id
 
 
