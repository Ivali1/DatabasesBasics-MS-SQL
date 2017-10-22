SELECT TOP(10) p.[Name], 
               p.[Description],
			     AVG(f.Rate) as [AverageRate],
				 isnull(COUNT(f.Id),0) as [FeedbacksAmount]
 FROM Products AS p
 join Feedbacks as f
   on f.ProductId=p.Id
group by  p.[Name], p.[Description]
order by [AverageRate] desc, [FeedbacksAmount] desc