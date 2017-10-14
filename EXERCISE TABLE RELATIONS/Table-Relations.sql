--zad1 One-To- One Relationship
	CREATE TABLE Passports(
	PassportID INT PRIMARY KEY NOT NULL,
	PassportNumber VARCHAR(20) NOT NULL
	)

	CREATE TABLE Persons(
	PersonID INT PRIMARY KEY IDENTITY,
	FirstName VARCHAR(30) NOT NULL,
	Salary NUMERIC(10,2) NOT NULL,
	PassportID INT NOT NULL UNIQUE,
	
	CONSTRAINT FK_Persons_Passports2
	 FOREIGN KEY (PassportID) 
	  REFERENCES  Passports(PassportID)  
	)

	INSERT INTO Passports VALUES
	(101, 'N34FG21B'),
	(102, 'K65LO4R7'),
	(103, 'ZE657QP2')

	INSERT INTO Persons VALUES
	('Roberto',43300.00,102),
	('Tom',56100.00,103),
	('Yana',60200.00,101)

	--ZAD2 One-To- Many Relationship
	
	CREATE TABLE Manufacturers(
	ManufacturerID INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(50) NOT NULL,
	EstablishedOn DATE NOT NULL
	)
	
	CREATE TABLE Models(
	ModelID INT PRIMARY KEY NOT NULL,
	[Name] VARCHAR (50) NOT NULL,
	ManufacturerID INT  FOREIGN KEY  
	REFERENCES Manufacturers(ManufacturerID) NOT NULL
	)

	INSERT INTO Manufacturers VALUES
	('BMW','07/03/1916'),
	('Tesla','01/01/2003'),
	('Lada','01/05/1966')

	INSERT INTO Models VALUES
	(101,'X1',1),
	(102,'i6',1),
	(103,'Model S',2),
	(104,'Model X',2),
	(105,'Model 3',2),
	(106,'Nova',3)

	--ZAD 3 Many-To- Many Relationship
	CREATE TABLE Students(
	StudentID INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(50) NOT NULL
	)

	CREATE TABLE Exams(
	ExamID INT PRIMARY KEY IDENTITY(101,1),
	[Name] VARCHAR(50) NOT NULL
	)
	CREATE TABLE StudentsExams(
	StudentID INT NOT NULL,
	ExamID INT NOT NULL,

	CONSTRAINT PK_StudentsExams
	PRIMARY KEY(StudentID,ExamID),

	CONSTRAINT FK_StudentsExamS_Students
	FOREIGN KEY (StudentID)
	REFERENCES Students(StudentID),

	CONSTRAINT FK_StudentsExams_Exams
	FOREIGN KEY (ExamID)
	REFERENCES Exams(ExamID)
	)

	INSERT INTO Students VALUES
	('Students'),
	('Toni'),
	('Ron')

	INSERT INTO Exams VALUES 
	('SpringMVC'),
	('Neo4j'),
	 ('Oracle 11g')

	TRUNCATE TABLE StudentsExams
     INSERT INTO StudentsExams VALUES
	 (1,101),
	 (1,102),
	 (2,101),
	 (3,103),
	 (2,102),
	 (2,103)


SELECT s.Name,e.Name FROM Students as s
JOIN StudentsExams AS se on
se.StudentID=s.StudentID
JOIN Exams as e on
e.ExamID=se.ExamID

--zad 4 Self-Referencing

CREATE TABLE Teachers(
TeacherID INT PRIMARY KEY IDENTITY(101,1),
[Name] VARCHAR(50) NOT NULL,
ManagerID INT,

CONSTRAINT FK_Teachers_Teachers 
FOREIGN KEY (ManagerID)
REFERENCES Teachers(TeacherID)
)
INSERT INTO Teachers VALUES
('John',NULL),
('Maya',106),
('Silvia',106),
('Ted',105),
('Mark',101),
('Greta',101)


--ZAD 5 Online Store DatabE
uSE OnlineStore
CREATE TABLE Cities(
 CityID INT  PRIMARY KEY IDENTITY,
[Name] VARCHAR(50) NOT NULL
)

CREATE TABLE Customers(
CustomerID INT PRIMARY KEY IDENTITY,
[Name] VARCHAR(50) NOT NULL,
Birthday DATE ,
CityID INT NOT NULL,

CONSTRAINT FK_Customers_Cities
FOREIGN KEY (CityID)
REFERENCES Cities(CityID)
)

CREATE TABLE Orders(
OrderID INT PRIMARY KEY IDENTITY,
CustomerID INT NOT NULL,

CONSTRAINT FK_Orders_Customers
FOREIGN KEY (CustomerID)
REFERENCES Customers(CustomerID )
)
CREATE TABLE ItemTypes(
ItemTypeID INT PRIMARY KEY IDENTITY,
[Name] VARCHAR(50)
)
CREATE TABLE Items(
ItemID INT PRIMARY KEY IDENTITY,
[Name] VARCHAR(50) NOT NULL,
ItemTypeID INT NOT NULL,

CONSTRAINT FK_Items_ItemTypes
FOREIGN KEY (ItemTypeID)
REFERENCES ItemTypes(ItemTypeID)
)

--ZAD 9 *Peaks in Rila
Use Geography

SELECT* 
FROM Mountains

SELECT*
FROM Peaks

SELECT m.MountainRange,p.PeakName,p.Elevation FROM Mountains AS m
JOIN Peaks as p ON
p.MountainId=m.Id
WHERE MountainRange='Rila'
ORDER BY Elevation DESC

CREATE TABLE OrderItems(
OrderID INT NOT NULL,
ItemID INT NOT NULL,

CONSTRAINT PK_OrderItems
PRIMARY KEY (OrderID,ItemID),

CONSTRAINT FK_OrderItems_Orders
FOREIGN KEY(OrderID)
REFERENCES Orders(OrderID),

CONSTRAINT FK_OrderItems_Items
FOREIGN KEY (ItemID)
REFERENCES Items(ItemID)

)
--zad 6 University Database
CREATE DATABASE University
use University
CREATE TABLE Subjects(
SubjectID INT PRIMARY KEY IDENTITY,
SubjectName VARCHAR(50)
)

CREATE TABLE Majors(
MajorID INT PRIMARY KEY IDENTITY,
[Name] VARCHAR(50) NOT NULL
)
CREATE TABLE Students(
StudentID INT PRIMARY KEY IDENTITY,
StudentNumber INT NOT NULL,
StudentName VARCHAR (50) NOT NULL,
MajorID INT FOREIGN KEY REFERENCES Majors(MajorID) NOT NULL
)
CREATE TABLE Payments(
PaymentID INT PRIMARY KEY IDENTITY,
PaymentDate DATE NOT NULL,
PaymentAmount NUMERIC(10,2) NOT NULL,
StudentID INT FOREIGN KEY REFERENCES Students(StudentID) NOT NULL
)
CREATE TABLE Agenda(
StudentID INT NOT NULL,
SubjectID INT NOT NULL,

CONSTRAINT PK_Agenda
PRIMARY KEY (StudentID,SubjectID),

CONSTRAINT FK_Students_Agenda
FOREIGN KEY (StudentID) 
REFERENCES Students(StudentID),

CONSTRAINT FK_Subjects_Agenda
FOREIGN KEY (SubjectID)
REFERENCES Subjects(SubjectID)


)
