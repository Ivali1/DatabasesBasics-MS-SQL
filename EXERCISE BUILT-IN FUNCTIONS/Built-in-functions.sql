Use SoftUni

--Zad 1 Find Names of All Employees by First Name
SELECT FirstName, LastName FROM Employees
WHERE FirstName LIKE 'SA%'

--Zad 2 Find Names of All employees by Last Name
SELECT FirstName, LastName FROM Employees
WHERE LastName LIKE '%ei%'
--Zad 3 Find First Names of All Employees
SELECT FirstName FROM Employees
WHERE (DepartmentID IN(3,10)AND datepart(YEAR,hireDate) between 1995 and 2005)

--Zad 4 Find All Employees Except Engineers
SELECT FirstName, LastName 
FROM Employees
WHERE JobTitle NOT LIKE '%engineer%'

--Zad 5 Find Towns with Name Length
SELECT Name FROM Towns
WHERE LEN(Name) IN (5,6)
ORDER BY Name

--Zad 6 Find Towns Starting With
SELECT TownID, Name
FROM Towns
WHERE Name LIKE  '[MKBE]%'
ORDER BY Name

--Zad 7 Find Towns Not Starting With
SELECT TownID, Name
FROM Towns
WHERE Name NOT LIKE  '[RBD]%'
ORDER BY Name
go
--Zad 8 Create View Employees Hired After 2000 Year
CREATE VIEW V_EmployeesHiredAfter2000 AS
SELECT FirstName, LastName
FROM Employees
WHERE DATEPART(YEAR,HireDate)> 2000
go
--Zad 9 Length of Last Name
SELECT FirstName, LastName
FROM Employees
WHERE LEN(LastName)=5

--Zad 10 Countries Holding ‘A’ 3 or More Times
Use Geography
SELECT CountryName,ISOCode AS [ISO Code]
FROM Countries
WHERE CountryName Like '%a%a%a%'
ORDER BY ISOCode

GO
--Zad 11 Mix of Peak and River Names
Use Geography
SELECT* FROM Peaks
SELECT Right(RiverName,len(RiverName)-1) FROM Rivers

SELECT PeakName ,RiverName, Lower(Concat(PeakName,Right(RiverName,len(RiverName)-1))) as Mix
FROM Peaks, Rivers
WHERE Right(PeakName,1)=Left(RiverName,1) 
ORDER BY Mix

--Zad 12 Games from 2011 and 2012 year
	Use Diablo
	SELECT TOP(50) Name, CONVERT(char(10),Start,126) as Start
FROM Games
WHERE DATEPART(YEAR,Start)=2011 OR DATEPART(YEAR,Start)=2012
ORDER BY Start, Name
--zad 13 User Email Providers
SELECT UserName, Right(Email,(Len(Email)-CHARINDEX('@',Email))) as [Email Provider] 
from  Users
ORDER BY [Email Provider], Username

--Zad 14 Get Users with IPAdress Like Pattern
SELECT Username, IpAddress 
FROM Users 
where IpAddress LIKE '___.1%.%.___'
ORDER BY Username

--Zad 15 Show All Games with Duration and Part of the Day

SELECT Name as Game,
case 
	WHEN(DATEPART(HOUR,Start)>=0 and DATEPART(HOUR,Start)<12) then 'Morning'
	WHEN(DATEPART(HOUR,Start)>=12 and DATEPART(HOUR,Start)<18) then 'Afternoon'
	WHEN(DATEPART(HOUR,Start)>=18 and DATEPART(HOUR,Start)<24) then 'Evening'
end as [Part of the Day], 
case
	when Duration <=3 then 'Extra Short'
	when Duration between 4 and 6 then 'Short'
	when Duration >6 then 'Long'
	else 'Extra Long'
end as Duration
FROM Games
order by Game,Duration, [Part of the Day] 

--ZAD 16 Orders Table
Use Orders
 SELECT ProductName,
        OrderDate,
		 DATEADD(DAY,3,OrderDate) AS [Pay Due],  
		 DATEADD(MONTH,1,OrderDate) AS [Deliver Due]
FROM Orders

--zad 17 People Table
CREATE TABLE People(
Id INT PRIMARY KEY IDENTITY,
Name NVARCHAR(50) NOT NULL,
Birthdate DATETIME NOT NULL
)
INSERT INTO People
     VALUES('Victor','2000-12- 07 00:00:00.000'),
			('Steven', '1992-09- 10 00:00:00.000'),
			('Stephen', '1910-09- 19 00:00:00.000'),
			('John', '2010-01- 06 00:00:00.000')
SELECT Name,
DATEDIFF(YEAR,Birthdate,GETDATE()) AS 'Age in Years',
DATEDIFF(MONTH,Birthdate,GETDATE()) AS 'Age in Months',
DATEDIFF(DAY,Birthdate,GETDATE()) AS 'Age in Days',
DATEDIFF(MINUTE,Birthdate,GETDATE()) AS 'Age in Minutes'
FROM People
