--Problem 1. Employees with Salary Above 35000

Use SoftUni

GO
CREATE PROC usp_GetEmployeesSalaryAbove35000
AS
BEGIN
		SELECT FirstName,LastName
		 FROM Employees
		 WHERE Salary>35000
END
GO
EXEC usp_GetEmployeesSalaryAbove35000

--Problem 2. Employees with Salary Above Number
go

cREATE PROC usp_GetEmployeesSalaryAboveNumber @Number DECIMAL(18,4)
AS
BEGIN
	SELECT FirstName, LastName
	 FROM Employees
		WHERE Salary>=@Number
END
GO
EXEC usp_GetEmployeesSalaryAboveNumber 48100
GO

--Problem 3. Town Names Starting With
go
CREATE PROC usp_GetTownsStartingWith @PartOFTown VARCHAR(5)
as
BEGIN
	SELECT Name AS Town
	 FROM Towns
	WHERE LEFT(Name,Len(@PartOFTown))=@PartOFTown
END
GO
EXEC usp_GetTownsStartingWith b
GO
--zadProblem 4. Employees from Town

CREATE PROC usp_GetEmployeesFromTown @Town VARCHAR(30)
AS
BEGIN
	SELECT FirstName, LastName
	 FROM Employees as e
	 JOIN Addresses as a
	  ON a.AddressID=e.AddressID
	 JOIN Towns as t
	  ON t.TownID=a.TownID
	  WHERE t.Name=@Town
END
GO 
EXEC usp_GetEmployeesFromTown Sofia

--Problem 5. Salary Level Function
GO

CREATE FUNCTION ufn_GetSalaryLevel (@Salary DECIMAL(18,4))
RETURNS VARCHAR (10)
AS
BEGIN
	DECLARE @SalaryLevel VARCHAR(10);
	SET @SalaryLevel=
	Case
		WHEN @Salary<30000 THEN 'Low'
		WHEN @Salary BETWEEN 30000 AND 50000 THEN 'Average'
		ELSE 'High'
	END
RETURN @SalaryLevel
END
SELECT Salary, dbo.ufn_GetSalaryLevel(Salary) AS [Salary Level] FROM Employees
go
--Problem 6. Employees by Salary Level
CREATE PROCEDURE usp_EmployeesBySalaryLevel @SalaryLevel VARCHAR(10)
as
BEGIN
 SELECT FirstName,LastName
  FROM Employees
  WHERE dbo.ufn_GetSalaryLevel(Salary)=@SalaryLevel
END
go
EXEC usp_EmployeesBySalaryLevel "Low"
go
 --Problem 7. Define Function
 CREATE FUNCTION ufn_IsWordComprised(@setOfLetters VARCHAR(50), @word VARCHAR(50))
 RETURNS BIT
 AS
BEGIN
    DECLARE @IsComprised BIT=0;
	DECLARE @CurrentIndex  INT=1;
	DECLARE @CurrentChar VARCHAR;

	WHILE (@CurrentIndex<=LEN(@word))
	BEGIN
		SET @CurrentChar=SUBSTRING(@word,@currentIndex,1)
		IF(cHARINdeX(@CurrentChar,@setOfLetters )=0)
		BEGIN
			RETURN @IsComprised
		END
		SET @CurrentIndex+=1;
	END
	RETURN @IsComprised + 1;
END
go
uSE SoftUni
go
-- Problem 8. * Delete Employees and Departments
CREATE PROC usp_DeleteEmployeesFromDepartment @departmentId INT
AS
BEGIN
 ALTER TABLE Departments
 ALTER COLUMN ManagerID INT NULL
        
	DELETE FROM  EmployeesProjects
	where  EmployeeID IN ( SELECT EmployeeID FROM Employees WHERE DepartmentID=@departmentId)
     UPDATE Departments
	SET ManagerID =null
	WHERE ManagerID in ( SELECT EmployeeID FROM Employees WHERE DepartmentID=@departmentId)

	UPDATE Employees
	SET ManagerID =null
	WHERE ManagerID in ( SELECT EmployeeID FROM Employees WHERE DepartmentID=@departmentId)



	DELETE FROM Employees
	WHERE   EmployeeID IN ( SELECT EmployeeID FROM Employees WHERE DepartmentID=@departmentId)

	DELETE FROM Departments
	WHERE DepartmentID= @departmentId

	SELECT count(*) as[Employees Count]
	FROM Employees as e
	join Departments as d
	  on d.DepartmentID=e.DepartmentID
	WHERE e.DepartmentID=@departmentId
END
GO
--Problem 9. Find Full Name
usE Bank
go
CREATE PROC usp_GetHoldersFullName
AS
BEGIN
 SELECT CONCAT(FirstName,' ',LastName) AS [Full Name]
   FROM AccountHolders
END
GO
--Problem 10. P]eople with Balance Higher Than
CREATE PROC usp_GetHoldersWithBalanceHigherThan @Salary NUMERIC(10,2)
AS
BEGIN
	SELECT FirstName,
	       LastName
     from(
	SELECT ah.FirstName,ah.LastName, SUM(a.Balance) as TotalSum
	FROM AccountHolders as ah
	JOIN Accounts as a
	 ON a.AccountHolderId=ah.Id
	 GROUP BY ah.FirstName,ah.LastName
	 HAVING SUM(a.Balance)> @Salary
	 ) as [group]


END

EXEC usp_GetHoldersWithBalanceHigherThan 3400
--Problem 11. Future Value Function
go

CREATE FUNCTION ufn_CalculateFutureValue ( @SumMoney MONEY,@annualIntRate FLOAT,@years INT)
RETURNS MONEY
AS
BEGIN
	RETURN @SumMoney * POWER(1+@annualIntRate,@years);
END
go
select dbo.ufn_CalculateFutureValue(1000, 0.10, 5) AS F
--Problem 12. Calculating Interest
uSE Bank
GO
CREATE PROC usp_CalculateFutureValueForAccount @AccountId INT, @InterestRate float
AS
BEGIN
	DECLARE @Years INT;
	SET @Years=5;

	SELECT a.Id as [Account Id],
	       ah.FirstName as [First Name],
		   ah.LastName as [Last Name],
		   a.Balance as [Current Balance],
		   dbo.ufn_CalculateFutureValue(a.Balance,@InterestRate,5) as[Balance in 5 years]
	 FROM AccountHolders as ah 
	 JOIN Accounts AS a
	  ON a.AccountHolderId=ah.Id
	  WHERE a.Id=@AccountId
END
go
exec usp_CalculateFutureValueForAccount 1 , 0.1
GO
--Problem 13. *Scalar Function: Cash in User Games Odd Rows
use Diablo
go
create FUNCTION ufn_CashInUsersGames( @game VARCHAR(50)) 
 returns table
 AS
 return (

 SELECT SUM(Cash) AS SumCash
 FROM(
   SELECT g.Name as Name, 
        ug.Cash as Cash,
		  ROW_NUMBER() OVER(ORDER BY ug.Cash DESC) as NumberRow
     FROM Games AS g
     JOIN UsersGames AS ug
       ON ug.GameId=g.Id
	 WHERE (g.Name=@game )
	 ) AS c
	 WHERE NumberRow%2=1
 )


