SELECT top(2) C.Mechanic,c.Jobs
 FROM (
SELECT CONCAT(m.FirstName, ' ',m.LastName) as Mechanic,
       m.MechanicId,
       COUNT(j.Status) AS Jobs
  FROM Mechanics AS m 
  JOIN Jobs AS j
    ON j.MechanicId=m.MechanicId
WHERE j.Status<> 'Finished'
GROUP BY CONCAT(m.FirstName, ' ',m.LastName), m.MechanicId
) AS c
ORDER BY c.Jobs dESC, c.MechanicId