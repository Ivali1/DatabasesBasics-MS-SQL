USE WMS

SELECT TOP(1) with ties   m.Name as Model, 
       COUNT(j.Status) as [Times Serviced],
	   (SELECT  ISNULL(SUM(p.Price*op.Quantity),0)
   FROM Jobs AS j
   JOIN Orders AS o
     ON o.JobId=j.JobId
   JOIN OrderParts AS op
     ON op.OrderId=o.OrderId
  JOIN Parts AS p
    ON p.PartId=op.PartId
WHERE j.ModelId=m.ModelId) as  [Parts Total]
 FROM Models AS m
 JOIN Jobs AS j
   ON j.ModelId=m.ModelId
 GROUP BY m.Name, m.ModelId
 ORDER BY [Times Serviced] DESC


 
