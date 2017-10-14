
--Problem 13.	Movies Database
CREATE DATABASE Movies

Use Movies
CREATE TABLE Directors(
Id INT PRIMARY KEY IDENTITY,
DirectorName NVARCHAR(50) NOT NULL,
Notes NVARCHAR(MAX)
)
CREATE TABLE Genres(
Id INT PRIMARY KEY IDENTITY,
GenreName NVARCHAR(50)  NOT NULL,
Notes NVARCHAR(MAX)
)
CREATE TABLE Categories(
Id INT PRIMARY KEY IDENTITY,
CategoryName NVARCHAR(50) NOT NULL,
Notes NVARChAR(MAX)
)
CREATE TABLE Movies(
Id INT PRIMARY KEY IDENTITY,
Title VARCHAR(50) NOT NULL,
DirectorId INT FOREIGN KEY REFERENCES Directors(Id),
CopyrightYear DATE NOT NULL,
Length INT NOT NULL,
GenreId INT FOREIGN KEY REFERENCES Genres(Id),
CategoryId INT FOREIGN KEY REFERENCES Categories(Id),
Rating INT,
Notes NVARCHAR(MAX)

)
INSERT INTO Directors(DirectorName,Notes) VALUES
('Ivan', 'fffgdrgrgrggrgr'),
('Ivan', 'fffgdrgrgrggrgr'),
('Ivan', 'fffgdrgrgrggrgr'),
('Ivan', 'fffgdrgrgrggrgr'),
('Ivan', 'fffgdrgrgrggrgr')


INSERT INTO Genres (GenreName,Notes) VALUES
('Comedy','ffff'),
('Action',NULL),
('Romantic',NULL),
('History',NULL),
('Family',NULL)

INSERT INTO Categories VALUES
('Category1', NULL),
('Category2', NULL),
('Category3', NULL),
('Category4', NULL),
('Category5', NULL)

INSERT INTO Movies VALUES
('Back to the Future',1,'1985-04-21',120,1,1,NULL,NULL),
('dfff',2,'1985-04-21',120,2,2,NULL,NULL),
('dddd',3,'1985-04-21',120,3,3,NULL,NULL),
('ddddd',4,'1985-04-21',120,4,4,NULL,NULL),
('Back to the Future',5,'1985-04-21',120,5,5,NULL,NULL)