GO
CREATE FUNCTION udf_GetCost(@JobId INT)
RETURNS NUMERIC(10,2)
AS
BEGIN
 DECLARE @Result NUMERIC(10,2)=(select ISNULL(SUM(p.Price*op.Quantity),0) as Result
  from Jobs as j
  join Orders as o
    on o.JobId=j.JobId
  join OrderParts as op
    on op.OrderId=o.OrderId
  join Parts as p
    on p.PartId=op.PartId
  where j.JobId=@JobId)

   RETURN @Result
 
END
