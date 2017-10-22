USE Bakery
GO
CREATE VIEW v_UserWithCountries  AS
SELECT concat(cus.FirstName,' ',cus.LastName) as CustomerName,
       cus.Age,
	   cus.Gender,
       c.[Name] as CountryName
 FROM Countries AS c
 JOIN Customers AS cus
   ON cus.CountryId=c.Id
