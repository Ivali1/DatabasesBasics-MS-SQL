
Use Minions

--Problem 7.	Create Table People
CREATE TABLE People(
Id INT UNIQUE IDENTITY,
Name NVARCHAR (200) NOT NULL,
Picture VARBINARY (MAX) CHECK (DATALENGTH(Picture) <= 2097152),
Height NUMERIC(10,2),
Weight NUMERIC(10,2),
Gender CHAR(1) CHECK(Gender='m' or Gender='f') NOT NULL,
BrithDate DATE NOT NULL,
Biography NVARCHAR(MAX)
)
ALTER TABLE People
ADD CONSTRAINT Pk_Id
PRIMARY KEY(Id)

INSERT INTO People(Name,Picture,Height,Weight,Gender,BrithDate)
VALUES ('Iva',170.30,NULL,67.30,'f','1994-05-30'),
('Mila',170.30, NULL,67.30,'f','1991-05-21'),
('Elena',170.30,NULL, 67.30,'f','1996-05-24'),
('Petkan',170.30,NULL, 67.30,'m','1994-05-31'),
('Ivan',170.30,NULL, 67.30,'m','1992-04-11')

DROP TABLE Users
--Problem 8.	Create Table Users
CREATE TABLE Users(
Id BIGINT UNIQUE IDENTITY,
UserName VARCHAR(30) UNIQUE NOT NULL ,
Password VARCHAR(26) NOT NULL,
ProfilePicture  VARBINARY (MAX) CHECK (DATALENGTH(ProfilePicture) <= 921600),
LastLoginTime DaTeTime,
IsDeleted BIT DEFAULT 0
)


ALTER TABLE Users
ADD CONSTRAINT Pk_IdUser
PRIMARY KEY(Id)

INSERT INTO Users Values
('Iva', '12h334', NULL,NULL, 0),
('Petkan', '12h334', NULL,NULL, 1),
('Ilian', '12h334', NULL,NULL, 0),
('Nikolay', '12h334', NULL,NULL, 1),
('Ivalina', '12h334', NULL,NULL, 0)

--Problem 9.	Change Primary Key
ALTER TABLE Users
DROP CONSTRAINT Pk_IdUser
 

ALTER TABLE Users
ADD CONSTRAINT Pk_UserId
PRIMARY KEY(Id,UserName)

--Problem 10.	Add Check Constraint
ALTER TABLE Users
ADD CONSTRAINT CH_Pasword
CHECK (DATALENGTH(Password)>=5)


ALTER TABLE Users
DROP COLUMN UserId

--Problem 11.	Set Default Value of a Field
ALTER TABLE Users
ADD DEFAULT GETDATE()
FOR LastLoginTime

--Problem 12.	Set Unique Field
ALTER TABLE Users
DROP CONSTRAINT Pk_UserId

ALTER TABLE Users
ADD CONSTRAINT Pk_Ids
PRIMARY KEY(Id)

ALTER TABLE Users
ADD CONSTRAINT CH_UserName
CHECK(DATALENGTH(UserName)>=3)

