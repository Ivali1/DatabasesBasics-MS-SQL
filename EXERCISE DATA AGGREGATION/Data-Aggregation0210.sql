Use Gringotts

--ZAD 1 Records’ Count
SELECT  COUNT(*) as	Count
FROM WizzardDeposits

--ZAD 2 Longest Magic Wand
SELECT MAX(MagicWandSize) AS [LongestMagicWand]
FROM WizzardDeposits

--ZAD 3 Longest Magic Wand per Deposit Groups
SELECT DepositGroup, MAX(MagicWandSize) AS [LongestMagicWand]
FROM WizzardDeposits
GROUP BY DepositGroup

--ZAD4 * Smallest Deposit Group per Magic Wand Size
SELECT TOP(2) DepositGroup
FROM WizzardDeposits
GROUP BY DepositGroup
order by avg(MagicWandSize) asc

--zad 5 Deposits Sum
SELECT DepositGroup,  SUM(DepositAmount) AS [TotalSum]
FROM WizzardDeposits
GROUP BY  DepositGroup

--ZAD 6 Deposits Sum for Ollivander Family
SELECT DepositGroup,  SUM(DepositAmount) AS [TotalSum]
FROM WizzardDeposits
where MagicWandCreator='Ollivander family'
GROUP BY  DepositGroup

--zad 7 Deposits Filter
SELECT DepositGroup,  SUM(DepositAmount) AS [TotalSum]
FROM WizzardDeposits
where MagicWandCreator='Ollivander family'
GROUP BY  DepositGroup
HAVING SUM(DepositAmount)<150000
ORDER BY [TotalSum] DESC

--ZAD 8 Deposit Charge
SELECT DepositGroup,MagicWandCreator, MIN(DepositCharge) AS [MinDepositCharge] 
FROM WizzardDeposits
GROUP BY DepositGroup,MagicWandCreator
ORDER BY MagicWandCreator,DepositGroup

--ZAD 9 Age Groups

SELECT 
CASE 
	WHEN Age between 0  AND 10 then '[0-10]'
	WHEN Age between 11 AND 20 then '[11-20]'
	WHEN Age between 21 AND 30 then '[21-30]'
	WHEN Age between 31 AND 40 then '[31-40]'
	WHEN Age between 41 AND 50 then '[41-50]'
	WHEN Age between 51 AND 60 then '[51-60]'
	WHEN Age>=61               then '[61+]'

 END AS  AgeGroup, COUNT(*) AS WizardCount
 FROM WizzardDeposits

GROUP BY 
  CASE 
	WHEN Age between 0  AND 10 then '[0-10]'
	WHEN Age between 11 AND 20 then '[11-20]'
	WHEN Age between 21 AND 30 then '[21-30]'
	WHEN Age between 31 AND 40 then '[31-40]'
	WHEN Age between 41 AND 50 then '[41-50]'
	WHEN Age between 51 AND 60 then '[51-60]'
	WHEN Age>=61               then '[61+]'
 END
 --9 Age Groups
 SELECT groups.AgeGroup, COUNT(*) AS [WizardCount] 
FROM (
	SELECT 
		CASE
			WHEN Age BETWEEN 0 AND 10 THEN '[0-10]'
			WHEN Age BETWEEN 11 AND 20 THEN '[11-20]'
			WHEN Age BETWEEN 21 AND 30 THEN '[21-30]'
			WHEN Age BETWEEN 31 AND 40 THEN '[31-40]'
			WHEN Age BETWEEN 41 AND 50 THEN '[41-50]'
			WHEN Age BETWEEN 51 AND 60 THEN '[51-60]'
			WHEN AGE >= 61 THEN '[61+]'
		END AS [AgeGroup]
	FROM WizzardDeposits
	) AS [groups]
GROUP BY AgeGroup
 --zad 10
 SELECT DISTINCT LEFT(FirstName,1)
 FROM WizzardDeposits
 WHERE DepositGroup ='Troll Chest' 
 ORDER BY LEFT(FirstName,1)

 --ZAD 10 First Letter
  SELECT LEFT(FirstName,1)
 FROM WizzardDeposits
 WHERE DepositGroup ='Troll Chest' 
 GROUP BY  LEFT(FirstName,1)
 ORDER BY LEFT(FirstName,1)

 --ZAD 11 Average Interest

 SELECT DepositGroup, IsDepositExpired, AVG(DepositInterest)
  FROM WizzardDeposits
  WHERE DepositStartDate>'01/01/1985'
  GROUP BY DepositGroup,IsDepositExpired
  ORDER BY DepositGroup DESC,IsDepositExpired

  --zad 12 Rich Wizard, Poor Wizard

 SELECT  Id,
         FirstName as [Host Name],
		 DepositAmount as [Host Amount],
		 LEAD(FirstName)OVER(ORDER BY ID) AS [Guest Name],
		 LEAD(DepositAmount)OVER(ORDER BY ID) AS [Guest Amount],
		 (DepositAmount-LEAD(DepositAmount)OVER(ORDER BY ID)) as [difference]

  FROM WizzardDeposits

  SELECT SUM([difference]) as SumDifference
   FROM 
   (
  sELECT (DepositAmount - LEAD(DepositAmount)OVER(ORDER BY ID)) as [difference]
    FROM WizzardDeposits
   ) AS [Diff]

 --zad 13 Departments Total Salaries
 Use SoftUni
 SELECT DepartmentID, SUM(Salary) AS [TotalSalary]
 FROM Employees
 GROUP BY DepartmentID
 ORDER BY DepartmentID

 --zad 14 Employees Minimum Salaries
  SELECT DepartmentID, MIN(Salary) AS[MinimumSalary]
 FROM Employees
 WHERE DepartmentID IN (2,5,7) and HireDate>'01/01/2000'
 GROUP BY DepartmentID

 --zad 15 Employees Average Salaries
 SELECT* INTO NewTable 
 FROM Employees
 WHERE Salary>30000 

 DELETE FROM NewTable
 WHERE ManagerID=42

 UPDATE NewTable
 SET Salary+=5000
 WHERE DepartmentID=1

SELECT DepartmentID, AVG(Salary)
from NewTable
group by DepartmentID

select * from NewTable
 --ZAD 16 Employees Maximum Salaries

 SELECT DepartmentID,MAX(Salary)
  FROM Employees
  GROUP BY DepartmentID
  HAVING MAX(Salary) NOT Between 30000 and 70000

  --ZAD 17 Employees Count Salaries
  SELECT COUNT(Salary) as [Count]
  FROM Employees
  WHERE ManagerID IS NULL
  
 --zad 18 *3rd Highest Salary
 
 
 SELECT DepartmentID, Salary
 FROM
 (
SELECT DepartmentID, 
		Salary,
		dense_rank()over(partition by DepartmentID order by Salary DESC) AS Rank
FROM Employees 
GROUP BY DepartmentID,Salary
) AS [group]
WHERE Rank=3


--zad 19 **Salary Challenge
SELECT TOP(10) FirstName, LastName, DepartmentID
FROM Employees AS emp1
WHERE Salary>( SELECT AVG(Salary) FROM Employees as empl2
WHERE emp1.DepartmentID=empl2.DepartmentID 
)
order by emp1.DepartmentID
