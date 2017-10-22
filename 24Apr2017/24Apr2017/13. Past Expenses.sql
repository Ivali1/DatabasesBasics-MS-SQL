SELECT j.JobId,ISNULL(SUM(p.Price*op.Quantity),0) as Total FROM Parts as p
JOIN OrderParts AS op on op.PartId=p.PartId
join Orders as o on o.OrderId=op.OrderId
RIGHT join Jobs as j on j.JobId=o.JobId
WHERE j.Status='Finished'
GROUP BY j.JobId
Order by Total desc, j.JobId
