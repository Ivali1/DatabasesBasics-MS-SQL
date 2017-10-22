SELECT CONCAT(c.FirstName,' ',c.LastName) as Client,
       DATEDIFF(DAY,j.IssueDate,'2017-04-24') as [Days going],
	   j.Status
 FROM Clients AS c
 JOIN Jobs AS j
   ON j.ClientId=C.ClientId
 WHERE Status<> 'Finished'
ORDER BY [Days going] DESC, c.ClientId
