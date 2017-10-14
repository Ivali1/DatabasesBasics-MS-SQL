--Problem 16.	Create SoftUni Database
CREATE DATABASE SoftUni

Use SoftUni

CREATE TABLE Towns(
Id INT PRIMARY KEY IDENTITY(1,1),
Name NVARCHAR(50) NOT NULL
)

CREATE TABLE Addresses(
Id INT PRIMARY KEY IDENTITY(1,1),
AddressesText NVARCHAR(255) NOT NULL,
TownId INT FOREIGN KEY REFERENCES Towns(Id)
)
CREATE TABLE Departments(
Id INT PRIMARY KEY IDENTITY(1,1),
Name NVARCHAR(50) NOT NULL
)
CREATE TABLE Employees(
Id INT PRIMARY KEY IDENTITY(1,1),
FirstName NVARCHAR(50) NOT NULL,
MiddleName NVARCHAR(50) NOT NULL,
LastName NVARCHAR(50) NOT NULL,
JobTitle NVARCHAR(50) NOT NULL,
DepartamentId INT FOREIGN KEY REFERENCES Departments(Id),
HireDate DATE,
Salary NUMERIC(10,2) NOT NULL CHECK (Salary >0),
AddressesId INT FOREIGN KEY REFERENCES Addresses(Id),
)
--Problem 18.	Basic Insert
INSERT INTO Towns VALUES
('Sofia'),
('Plovdiv'),
('Varna'),
('Burgas')

INSERT INTO Departments VALUES
('Engineering'),
('Sales'),
('Marketing'),
('Software Development'),
('Quality Assurance')


INSERT INTO Employees(FirstName,MiddleName,LastName,JobTitle,DepartamentId,HireDate,Salary) VALUES
('Ivan','Ivanov','Ivanov','.NET Developer',4,'2013-02-01',3500.00),
('Petar','Petrov','Petrov','Senior Engineer',1,'2004-03-02',4000.00),
('Maria','Petrova','Ivanova','Inter',5,'2016-08-28',525.25),
('Georgi','Teziev','Ivanov','CEO',2,'2007-12-09',3000.00),
('Pan','Pan','Pan','Inter',3,'2016-08-28',599.88)


--Problem 19.	Basic Select All Fields
SELECT* FROM Towns 
SELECT* FROM Departments
SELECT* FROM Employees

--Problem 20.	Basic Select All Fields and Order Them
SELECT* FROM Towns
ORDER BY Name

SELECT* FROM Departments
ORDER BY Name

SELECT* FROM Employees
ORDER BY Salary DESC

--Problem 21.	Basic Select Some Fields
SELECT Name FROM Towns
ORDER BY Name

SELECT Name FROM Departments
ORDER BY Name

SELECT FirstName, LastName,JobTitle,Salary FROM Employees
ORDER BY Salary DESC

--Problem 22.	Increase Employees Salary
UPDATE Employees
SET Salary+=(Salary*10)/100

SELECT Salary FROM Employees


Use Hotel
--Problem 23.	Decrease Tax Rate
UPDATE Payments
SET TaxRate-=(TaxRate*3)/100

SELECT TaxRate FROM Payments
--Problem 24.	Delete All Records
TRUNCATE TABLE Occupancies
