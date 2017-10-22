SELECT Mechanic,[Average Days]
FROM(
SELECT CONCAT(m.FirstName,' ',m.LastName) AS Mechanic, 
       m.MechanicId,
       AVG(DATEDIFF(DAY,j.IssueDate,j.FinishDate)) as [Average Days]
  FROM Mechanics AS m
  JOIN Jobs AS j
    ON j.MechanicId=m.MechanicId
  WHERE Status='Finished'
GROUP BY CONCAT(m.FirstName,' ',m.LastName),m.MechanicId
) AS c
ORDER BY c.MechanicId
