Use WMS
select* 
from OrderParts


SELECT ISNULL(SUM(p.Price* op.Quantity),0) as [Parts Total]
 FROM Parts AS p
 JOIN OrderParts AS op
   ON op.PartId=p.PartId
 JOIN Orders AS o
   ON o.OrderId=op.OrderId
 where  DATEDIFF(WEEK,o.IssueDate ,'04-24-2017')<=3

