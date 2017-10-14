Use SoftUni

SELECT*
 FROM Employees

 SELECT*
 FROM EmployeesProjects
 
SELECT* 
 FROM Addresses

 SELECT*
 FROM Projects

 SELECT*
  FROM Towns

 --ZAD 1 Employee Address
 SELECT TOP(5) e.EmployeeID,e.JobTitle, a.AddressID,a.AddressText
 FROM Employees AS e
 JOIN Addresses as a ON
 a.AddressID=e.AddressID 
 ORDER BY a.AddressID	ASC

 --zad 2 Addresses with Towns
 SELECT top (50) e.FirstName, 
		e.LastName,
		t.Name as [Town],
		a.AddressText
  FROM  Employees AS e 
  JOIN	Addresses AS a 
    ON  a.AddressID=e.AddressID
  JOIN Towns AS t
   ON T.TownID=A.TownID
ORDER BY e.FirstName,e.LastName

--zad3 Sales Employee
SELECT e.EmployeeID,
	   e.FirstName,
	   e.LastName,
	   d.Name as DepartmentName
 FROM  Employees AS e
 JOIN Departments AS d
   ON  d.DepartmentID=e.DepartmentID
WHERE d.Name='Sales'
ORDER BY e.EmployeeID

--zad4 Employee Departments
  SELECT TOP(5)
         e.EmployeeID,
		 e.FirstName,
		 e.Salary,
		 d.Name as DepartmentName
    FROM Employees AS e
	JOIN Departments AS d
	  ON D.DepartmentID=e.DepartmentID
   WHERE Salary> 15000
ORDER BY e.DepartmentID

--ZAD 5 Employees Without Project
SELECT TOP(3)
        e.EmployeeID, 
		e.FirstName
 FROM Employees AS e
Left JOIN EmployeesProjects AS	ep
   ON ep.EmployeeID=e.EmployeeID
 where ep.EmployeeID is NULL
ORDER BY e.EmployeeID

--zad 6 Employees Hired After

  SELECT e.FirstName,
         e.LastName,
		 e.HireDate,
		 d.Name as DeptName
    FROM Employees AS e
	JOIN Departments AS d
	  ON d.DepartmentID=e.DepartmentID
	WHERE d.Name IN ('Sales','Finance') 
	AND   e.HireDate>'1.1.1999'
ORDER BY e.HireDate

--zad7  Employees With Project
SELECT TOP(5) e.EmployeeID,e.FirstName,p.Name AS [ProjectName]
 FROM Employees AS e
 JOIN EmployeesProjects AS ep
   ON ep.EmployeeID=e.EmployeeID 
 JOIN Projects as p
   ON p.ProjectID=ep.ProjectID
WHERE p.StartDate>'08/13/2002' AND p.EndDate IS  NULL
ORDER BY e.EmployeeID

--zad8 Employee 24

  SELECT e.EmployeeID,e.FirstName, IIF(p.StartDate >'2005-01-01',NULL,
p.Name) as ProjectName
   FROM Employees AS e
  JOIN EmployeesProjects AS ep
   ON ep.EmployeeID=e.EmployeeID 
   JOIN Projects as p
   ON p.ProjectID=ep.ProjectID
   WHERE ep.EmployeeID=24 
--zad9  Employee Manager
SELECT e.EmployeeID, e.FirstName,e.ManagerID,m.FirstName as ManagerName
 FROM Employees AS e
  JOIN Employees AS m
   ON m.EmployeeID=e.ManagerID
   WHERE e.ManagerID IN (3,7)
 ORDER BY e.EmployeeID

 --zad 10  Employees Summary
 use SoftUni
 SELECT  top(50) e.EmployeeID, e.FirstName+ ' '+ e.LastName as EmployeeName , m.FirstName +' '+m.LastName
 as ManagerName, d.Name as DepartmentName
 FROM Employees AS e
  JOIN Employees AS m
   ON m.EmployeeID=e.ManagerID
  JOIN Departments AS d
   ON   d.DepartmentID=e.DepartmentID
  Order by e.EmployeeID

  --zad 11 Min Average Salary
  SELECT MIN(avgSalary) AS MinAverageSalary  FROM
  (
  SELECT DepartmentID,
		 AVG(Salary) as avgSalary
   FROM Employees
   GROUP BY DepartmentID
   ) AS emp

   --ZAD 12 Highest Peaks in Bulgaria
   Use Geography


 SELECT c.CountryCode,
        m.MountainRange,
		p.PeakName,
		p.Elevation
 FROM Countries AS c 
 JOIN MountainsCountries AS mc
   ON mc.CountryCode=c.CountryCode
 JOIN Mountains AS m
   ON m.Id=mc.MountainId
 JOIN Peaks AS p
   ON p.MountainId=m.Id
 WHERE mc.CountryCode='BG' and p.Elevation>2835
ORDER BY p.Elevation DESC


SELECT mc.CountryCode,
        m.MountainRange,
		p.PeakName,
		p.Elevation
 FROM MountainsCountries AS mc
 JOIN Mountains AS m
   ON m.Id=mc.MountainId
 JOIN Peaks AS p
   ON p.MountainId=m.Id
 WHERE mc.CountryCode='BG' and p.Elevation>2835
ORDER BY p.Elevation DESC

--zad 13 Count Mountain Ranges

SELECT mc.CountryCode,
	  COUNT( m.MountainRange)
 FROM MountainsCountries AS mc
 JOIN Mountains AS m
   ON m.Id=mc.MountainId
 WHERE mc.CountryCode IN('US' ,'RU','BG')
 GROUP BY mc.CountryCode

 --zad 14 Countries with Rivers

 SELECT top(5) c.CountryName,
		       r.RiverName
  FROM Countries AS c
  LEFT JOIN CountriesRivers AS cr
    ON cr.CountryCode=c.CountryCode
  LEFT  JOIN Rivers AS r
    ON r.Id=cr.RiverId
WHERE c.ContinentCode='AF'
ORDER BY c.CountryName

--zad 15 Continents and Currencies

SELECT ContinentCode,
       CurrencyCode,
	  CurrencyUsage
FROM
(
SELECT ContinentCode, 
        CurrencyCode,
		COUNT(CurrencyCode) as CurrencyUsage,
	   DENSE_rank()OVER(PARTITION BY ContinentCode ORDER BY COUNT(CurrencyCode) DESC)   as [Rank]
 FROM Countries 
 GROUP BY ContinentCode, CurrencyCode
 HAVING COUNT(CurrencyCode)>1
 
 ) AS c
 WHERE Rank=1
 ORDER BY C.ContinentCode


 --zad 16 Countries without any Mountains
SELECT COUNT(c.CountryCode)
 FROM Countries AS c
 LEFT JOIN MountainsCountries AS mc
        ON mc.CountryCode=c.CountryCode
  WHERE mc.CountryCode IS NULL

  --zad 17  Highest Peak and Longest River by Country

  SELECT top(5) c.CountryName, MAX(p.Elevation) as HighestPeakElevation, MAX(r.Length) as LongestRiverLengt
	FROM Countries AS c
	LEFT JOIN MountainsCountries AS mc
	  ON mc.CountryCode=c.CountryCode
    LEFT JOIN Mountains AS m
	  ON m.Id=mc.MountainId 
	LEFT JOIN Peaks AS p
	  ON p.MountainId=m.Id
	LEFT JOIN CountriesRivers AS cr
	  ON cr.CountryCode=c.CountryCode
	LEFT JOIN Rivers as r
	  ON r.Id=cr.RiverId
	GROUP BY c.CountryName
	Order by HighestPeakElevation DESC, LongestRiverLengt DESC, c.CountryName

--zad 18 Highest Peak Name and Elevation by Country

 SELECT TOP(5) c.CountryName AS Country, ISNULL(p.PeakName,'(no highest peak)') as [Highest Peak Name],
      ISNULL( MAX(p.Elevation),0)as [Highest Peak Elevation],
	  ISNULL( m.MountainRange,'(no mountain)') as Mountain
	FROM Countries AS c
	LEFT JOIN MountainsCountries AS mc
	  ON mc.CountryCode=c.CountryCode
    LEFT JOIN Mountains AS m
	  ON m.Id=mc.MountainId 
	LEFT JOIN Peaks AS p
	  ON p.MountainId=m.Id
	LEFT JOIN CountriesRivers AS cr
	  ON cr.CountryCode=c.CountryCode
	GROUP BY c.CountryName, P.PeakName,M.MountainRange
	ORDER BY C.CountryName,[Highest Peak Elevation]