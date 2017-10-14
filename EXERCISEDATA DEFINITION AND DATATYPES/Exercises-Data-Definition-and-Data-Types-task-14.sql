
CREATE DATABASE CarRental

Use CarRental

CREATE TABLE Categories(
Id INT PRIMARY KEY IDENTITY,
CategoryName VARCHAR(50) NOT NULL,
DailyRate NUMERIC(10,2) NOT NULL,
WeeklyRate  NUMERIC(10,2) NOT NULL,
MonthlyRate  NUMERIC(10,2) NOT NULL,
WeekendRate  NUMERIC(10,2) NOT NULL
)
CREATE TABLE Cars(
Id INT PRIMARY KEY IDENTITY,
PlateNumber VARCHAR(20) NOT NULL,
Manufacturer VARCHAR(50) NOT NULL,
Model VARCHAR(50) NOT NULL,
CarYear DATE NOT NULL,
CategoryId INT FOREIGN KEY REFERENCES Categories(Id),
Doors INT NOT NULL,
Picture VARBINARY(MAX) CHECK(DATALENGTH(Picture) <=2097152),
Condition VARCHAR(50) NOT NULL

)
CREATE TABLE Employees(
Id INT PRIMARY KEY IDENTITY,
FirstName NVARCHAR(50) NOT NULL,
LastName NVARCHAR(50) NOT NULL,
Title VARCHAR(50) NOT NULL,
Notes VARCHAR(MAX),
)

CREATE TABLE Customers(
Id INT PRIMARY KEY IDENTITY,
DriverLicenceNumber VARCHAR(20),
FullName NVARCHAR(50) NOT NULL,
Address NVARCHAR(50) NOT NULL,
City NVARCHAR(50) NOT NULL,
ZIPCode INT NOT NULL,
Notes NVARCHAR(MAX) NOT NULL,
)
CREATE TABLE RentalOrders(
Id INT PRIMARY KEY IDENTITY,
EmployeeId INT FOREIGN KEY REFERENCES Employees(Id),
CustomerId INT FOREIGN KEY REFERENCES Customers(Id),
CarId INT FOREIGN KEY REFERENCES Cars(Id) NOT NULL,
TankLevel NUMERIC(5,1) NOT NULL,
KilometrageStart INT NOT NULL,
KilometrageEnd INT NOT NULL,
TotalKilometrage INT NOT NULL,
StartDate DATE NOT NULL,
EndDate DATE NOT NULL,
TotalDays INT NOT NULL,
RateApplied  NVARCHAR(MAX),
TaxRate  NVARCHAR(MAX),
OrderStatus  NVARCHAR(50) NOT NULL,
Notes NVARCHAR(MAX),
)

INSERT INTO Categories VALUES
('Category1',10,200,300,15),
('Category1',10,200,300,15),
('Category1',10,200,300,15)

INSERT INTO Cars VALUES
('fff','fff','ffff','2016-06-20',1,4,NULL,'ddd'),
('fff','fff','ffff','2016-06-20',2,4,NULL,'ddd'),
('fff','fff','ffff','2016-06-20',3,4,NULL,'ddd')

INSERT INTO Employees VALUES
('ivan', 'Nikolov', 'fff',NULL),
('ivan', 'Nikolov', 'fff',NULL),
('ivan', 'Nikolov', 'fff',NULL)

INSERT INTO Customers VALUES
('VVV','VVV','VVVV','VVV',4959,'FFF'),
('VVV','VVV','VVVV','VVV',4959,'FFF'),
('VVV','VVV','VVVV','VVV',4959,'FFF')

INSERT INTO RentalOrders VALUES
(1,1,1,39.4,120,300,80, '2017-09-01','2017-09-03',3,'FFF', NULL,'FFF',NULL),
(2,2,2,39.4,120,300,80, '2017-09-01','2017-09-03',3,'FFF', NULL,'FFF',NULL),
(3,3,3,39.4,120,300,80, '2017-09-01','2017-09-03',3,'FFF', NULL,'FFF',NULL)



