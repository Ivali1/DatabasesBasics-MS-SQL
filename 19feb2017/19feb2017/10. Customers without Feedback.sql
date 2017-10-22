SELECT CONCAT(FirstName,' ',LastName) AS CustomerName,
        PhoneNumber,
		Gender
 FROM Customers 
 WHERE Id NOT in ( SELECT CustomerId FROM Feedbacks WHERE Rate IS NOT NULL)
 ORDER BY Id