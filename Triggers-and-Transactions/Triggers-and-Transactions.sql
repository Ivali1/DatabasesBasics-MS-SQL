Use Bank
--Problem 1. Create Table Logs

CREATE TABLE Logs(
LoginId INT PRIMARY KEY IDENTITY,
AccountId INT FOREIGN KEY REFERENCES Accounts(Id) NOT NULL, 
OldSum money NOT NULL,
NewSum money NOT NULL
)
GO

CREATE TRIGGER tr_AccountBalanceChange ON Accounts AFTER UPDATE
AS
BEGIN
	DECLARE @AccountId INT=(SELECT Id FROM inserted);
	DECLARE @OldSum money =(SELECT Balance FROM deleted);
	DECLARE @NewSum money=(SELECT Balance  FROM inserted);

	IF( @NewSum <> @OldSum )
	BEGIN
      INSERT INTO Logs VALUES(@AccountId,@OldSum,@NewSum);
	END
END

UPDATE Accounts
SET Balance+=980
WHERE Id=2



SELECT* FROM Logs

--Problem 2.	Create Table Emails

CREATE TABLE NotificationEmails(
Id INT PRIMARY KEY IDENTITY,
Recipient INT FOREIGN KEY REFERENCES Accounts(Id) NOT NULL,
Subject VARCHAR(100) NOT NULL,
Body VARCHAR(100) 
)
GO

CREATE TRIGGER tr_LogInsert ON Logs AFTER INSERT 
AS
BEGIN
		DECLARE @Recipient INT = (SELECT AccountId  FROM inserted);
		DECLARE @Subject VARCHAR(100) = (SELECT CONCAT('Balance change for account: ',AccountId) AS [Subject] FROM inserted);
		DECLARE @Body VARCHAR(100)= (SELECT CONCAT('On ',GETDATE(),'your balance was changed from',d.OldSum,' to ',i.NewSum) FROM inserted as i join deleted as d on d.AccountId=i.AccountId);
        

		INSERT INTO NotificationEmails VALUES (@Recipient,@Subject,@Body)


END

SELECT* FROM NotificationEmails

--Problem 3.	Deposit Money
GO
CREATE PROC usp_DepositMoney @AccountId INT, @MoneyAmount NUMERIC(10,4)
as
BEGIN  
	BEGIN TRANSACTION 
	BEGIN
	UPDATE Accounts
	SET Balance+=@MoneyAmount
	WHERE Id=@AccountId
    
	IF(@@ROWCOUNT<>1)
		BEGIN
		 ROLLBACK;
		 RAISERROR('Invalide account!',16,1);
		 return;
		END
	COMMIT
	END
END
GO
EXEC usp_DepositMoney 1, 10

SELECT* FROM Accounts
GO
--Problem 4.	Withdraw Money

CREATE PROC usp_WithdrawMoney @AccountId INT, @MoneyAmount NUMERIC(10,4)
as
BEGIN
	BEGIN TRANSACTION
		IF(@MoneyAmount <0)
		BEGIN 
		 ROLLBACK;
		 RAISERROR ('Money is nevative',16,1);
		 RETURN;
		END

		UPDATE Accounts
		SET Balance-=@MoneyAmount
		WHERE Id=@AccountId

		IF(@@ROWCOUNT<>1)
		BEGIN
			ROLLBACK;
			RAISERROR ('Invalid account',16,2);
			RETURN;
		END

		COMMIT
END
GO
EXEC usp_WithdrawMoney 5,25

SELECT* FROM Accounts

--Problem 5.	Money Transfer
GO



CREATE PROC usp_TransferMoney @SenderId INT, @ReceiverId INT, @Amount NUMERIC(10,4)
as
BEGIN
	BEGIN TRANSACTION 
	
		DECLARE @FinalResult NUMERIC(10,4);
		
		EXEC usp_WithdrawMoney @SenderId, @Amount

		SET @FinalResult= ( SELECT  Balance from Accounts where id=@SenderId)

		IF( @FinalResult <0 )
		BEGIN 
         ROLLBACK;
		 RAISERROR ('No enough money',16,3)
		 return;
         end
		 EXEC usp_DepositMoney @ReceiverId,@Amount
		 COMMIT
end
exec usp_TransferMoney 1,2,5

SELECT* from Accounts
go
--Problem 7. *Massive Shopping
Use Diablo

declare @StamatId INT= (select Id 
                       from Users
					   where FirstName='Stamat')

declare @SafflowerId INT =(SELECT Id
                         FROM Games
						 WHERE Name='Safflower')	   

declare @UserGameId int = (select Id
                           from UsersGames 
						   where  UserId=@StamatId and 
						           GameID= @SafflowerId)


begin try
begin transaction 
	UPDATE UsersGames
	SET Cash-=(select sum(Price) 
                    from Items
			       where MinLevel IN (11,12))
	WHERE Id=@UserGameId

	DECLARE @cashResult DECIMAL(15,4)= (SELECT Cash 
	                             from UsersGames
								WHERE Id=@UserGameId)
   IF(@cashResult<0)
   BEGIN
		ROLLBACK;
		RETURN;
   END

   INSERT INTO UserGameItems
     SELECT Id,
	        @UserGameId 
      from Items 
      WHERE MinLevel IN(11,12)
COMMIT
end try
BEGIN CATCH
	ROLLBACK;
	RETURN;
END CATCH


begin try
BEGIN transaction 

	UPDATE UsersGames
	SET Cash-=(select sum(Price) 
                    from Items
			       where MinLevel BETWEEN 19 AND 21)
	WHERE Id=@UserGameId

 SET  @cashResult = (SELECT Cash 
	                   from UsersGames
					   WHERE Id=@UserGameId)
   IF(@cashResult<0)
   BEGIN
		ROLLBACK;
	
   END

   INSERT INTO UserGameItems 
   SELECT Id,@UserGameId 
   from Items 
   WHERE MinLevel BETWEEN 19 AND 21

   COMMIT
end try
BEGIN CATCH
	ROLLBACK;
END CATCH
SELECT i.Name as [Item Name]
 FROM Items AS i
 JOIN UserGameItems AS u
   on u.ItemId=i.Id
  WHERE u.UserGameId=@UserGameId
  ORDER BY [Item Name]

--Problem 8. Employees with Three Projects
Use SoftUni


GO
CREATE PROC usp_AssignProject(@employeeId INT, @projectID INT)
AS
BEGIN
 DECLARE @MaxProjectForEmployees INT=3;
 DECLARE @ProjectOnEmployees INT;

	BEGIN TRANSACTION
	BEGIN 
		 INSERT INTO EmployeesProjects(EmployeeID,ProjectID)
		      VALUES(@employeeId,@projectID)

	   SET @ProjectOnEmployees =(SELECT COUNT(*) 
		  FROM EmployeesProjects
		  WHERE EmployeeID=@employeeId)
	
	IF(@ProjectOnEmployees > @MaxProjectForEmployees)
		BEGIN
			ROLLBACK;
			RAISERROR('The employee has too many projects!',16,1);
			RETURN;
		END
	 ELSE
		COMMIT
	END	

END
go
Use SoftUni

SELECT* FROM Departments
exec usp_AssignProject 2, 4


--zad 9 Delete Employees


CREATE TABLE Deleted_Employees(
 EmployeeId INT PRIMARY KEY IDENTITY,
 FirstName VARCHAR(50) NOT NULL,
 LastName VARCHAR(50) NOT NULL,
 MiddleName VARCHAR(50) NOT NULL,
 JobTitle     VARCHAR(50) NOT NULL,
 DepartmentId INT FOREIGN KEY REFERENCES 
 Departments(DepartmentID) NOT NULL,
 Salary NUMERIC(10,4)

 )
 GO
CREATE TRIGGER tr_SaveDeleteEmployees ON Employees 
 AFTER DELETE
 as
 BEGIN
		INSERT INTO Deleted_Employees
			SELECT        d.FirstName,
						  d.LastName,
						  d.MiddleName,
						  d.JobTitle,
						  d.DepartmentID,
						  d.Salary
			              FROM deleted as d

 END
 