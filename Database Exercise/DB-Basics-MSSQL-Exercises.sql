/** 1.Create Database **/

CREATE DATABASE Minions;

GO

USE Minions;

/** 2. Create Tables **/

CREATE TABLE Minions 
(
	Id INT NOT NULL PRIMARY KEY,
	Name VARCHAR (100),
	Age INT
)
CREATE TABLE Towns 
(
	Id INT NOT NULL PRIMARY KEY,
	Name VARCHAR (100)
)

/** 3. Alter Minions Table **/

ALTER TABLE Minions
	ADD TownId INT FOREIGN KEY REFERENCES Towns(Id) NOT NULL

-- ALTER TABLE Minions
	--ADD TownId INT NOT NULL

--ALTER TABLE Minions
--ADD FOREIGN KEY (TownId) REFERENCES Towns(Id)



/** 4. Insert Records in Both Tables **/

INSERT INTO Towns (Id, Name) 
VALUES
(1, 'Sofia'),
(2, 'Peter'),
(3, 'Victoria')

INSERT INTO Minions (Id, Name, Age,TownId) 
VALUES 
(1, 'Kavin', 22, 1),
(2, 'Bob', 15, 3),
(3, 'Steward', NULL, 2)



/** 5. Truncate Table Minions **/

TRUNCATE TABLE Minions;  

/** 6. Drop All Tables **/

DROP TABLE Minions;
DROP TABLE Towns;

/** 7. Create Table People **/

CREATE TABLE People
(
	Id INT UNIQUE IDENTITY,
	Name NVARCHAR (200) NOT NULL,
	Picture VARBINARY (MAX) CHECK (DATALENGTH(Picture) > 1024 *1024 * 2),
	Height NUMERIC (3, 2),
	Weight NUMERIC (5, 2),
	Gender CHAR(1) CHECK ( Gender = 'm' OR Gender = 'f') NOT NULL,
	Birthdate DATE NOT NULL,
	Biography NVARCHAR (MAX)
);

ALTER TABLE People
ADD PRIMARY KEY (Id)

INSERT INTO People (Name, Picture, Height, Weight, Gender, Birthdate, Biography)
VALUES
('Jamil Uddin', NULL, 1.78, 72.34, 'm', '1982-10-01', 'Developer'),
('Arisha Jamil', NULL, 1.10, 30.14, 'f', '2014-01-28', NULL),
('Atia Pervin', NULL, 1.58, 55.10, 'f', '1998-12-23', 'Student'),
('Ashik Alam', NULL, 1.68, 59.44, 'm', '1980-01-10', 'Engineer'),
('Sunny Hossen', NULL, 1.80, 82.30, 'm', '1972-10-10', 'Manager')


/** 8.Create Table Users **/

CREATE TABLE Users
(
	Id BIGINT UNIQUE IDENTITY NOT NULL,
	Username VARCHAR(30) UNIQUE NOT NULL,
	Password VARCHAR(26) NOT NULL,
	ProfilePicture VARBINARY(MAX) CHECK (DATALENGTH(ProfilePicture) >= 900 * 1024),
	LastLoginTime DATETIME,
	IsDeleted BIT NOT NULL DEFAULT(0)
	)
ALTER TABLE Users
ADD CONSTRAINT PK_Users PRIMARY KEY (Id)

INSERT INTO Users (UserName, Password, ProfilePicture, LastLoginTime, IsDeleted)
VALUES
('Jamil', 'j1234', NULL, NULL, 1),
('Arisha', 'a1234', NULL, NULL, 0),
('Atia', 'A1234', NULL, NULL, 0),
('Ashik', 'K1234', NULL, NULL, 1),
('Sunny', 'S1234', NULL, NULL, 1)


/** 9.Change Primary Key User Tables**/

ALTER TABLE Users
DROP CONSTRAINT PK_Users;

ALTER TABLE Users
ADD CONSTRAINT PK_Users PRIMARY KEY (Id, Username);


/** 10.	Add Check Constraint **/

ALTER TABLE Users
ADD CONSTRAINT Password CHECK (LEN(Password) >= 5);


/** 11.	Set Default Value of a Field **/

ALTER TABLE Users
ADD CONSTRAINT DF_Users DEFAULT GETDATE() FOR LastLoginTime;


/** 12.	Set Unique Field (Grade = Pass!) **/

ALTER TABLE Users
DROP CONSTRAINT PK_Users;

ALTER TABLE Users
ADD CONSTRAINT PK_Users PRIMARY KEY (Id);

ALTER TABLE Users
ADD CONSTRAINT UC_Users UNIQUE (Username);

ALTER TABLE Users
ADD CONSTRAINT Username CHECK (LEN(Password) >=3);


/** 13.	Movies Databases **/

CREATE DATABASE Movies;

GO
USE Movies;


CREATE TABLE Directors
(
	Id INT PRIMARY KEY IDENTITY,
	DirectorName NVARCHAR (60) NOT NULL,
	Notes NVARCHAR (MAX)
);


CREATE TABLE Genres
(
	Id INT PRIMARY KEY IDENTITY,
	GenreName NVARCHAR(50) NOT NULL,
	Notes NVARCHAR(MAX)
);

CREATE TABLE Categories
(
	Id INT PRIMARY KEY IDENTITY,
	CategoryName NVARCHAR (50) NOT NULL,
	Notes NVARCHAR (MAX)
);

CREATE TABLE Movies
(
	Id INT PRIMARY KEY IDENTITY,
	Title NVARCHAR(150) NOT NULL, 
	DirectorId INT FOREIGN KEY REFERENCES Directors(Id),
	CopyrightYear INT NOT NULL,
	Length TIME,
	GenreId INT FOREIGN KEY REFERENCES Genres(Id),
	CategoryId INT FOREIGN KEY REFERENCES Categories(Id),
	Rating NUMERIC (2,1), 
	Notes NVARCHAR (MAX)
);
	
INSERT INTO Directors (DirectorName, Notes)
VALUES 
('Richard Berry', 'Action thriller'),
('Jon M. Chu', 'Comedy Romance'),
('Reed Morano', 'Thriller'),
('Cameron Crowe', 'Drama Romance'),
('Steve McQueen', 'Drama History');

INSERT INTO Categories(CategoryName, Notes)
VALUES
('Action', 'Action thrille'),
('Comedy', 'Comedy Romance'),
('Crime', 'Thriller'),
('Romantic', 'Drama Romance'),
('Historical', 'Drama History');


INSERT INTO Genres (GenreName, Notes)
VALUES
('Action', 'Very thrille'),
('Comedy', 'Best comedy'),
('Crime', ' Nice Thriller'),
('Romantic', 'Love Romance'),
('Historical', 'Best History');


INSERT INTO Movies (Title, DirectorId, CopyrightYear, Length, GenreId, CategoryId, Rating, Notes)
VALUES
('22 Bullets', '1', '2010', '1:55:00', '1', '1', '8.9', 'Thriller'),
('Crazy Rich Asians', '2', '2018', '2:00:00', '2', '2', '7.8', 'Comedy'),
('The Rhythm Section', '3', '2020', '1:49:00', '3', '3', '8.8', 'Crime'),
('SAY ANYTHING', '4', '2002', '1:40:00', '4', '4', '8.6', 'Romance'),
('12 Years A Slave', '5', '2013', '2:14:00', '5', '5', '9.8', 'Histiry');



/** 14.	Car Rental Database **/

CREATE DATABASE CarRental 

GO
USE CarRental;


CREATE TABLE Categories 
(
	Id INT PRIMARY KEY IDENTITY,
	CategoryName NVARCHAR (60) NOT NULL,
	DailyRate DECIMAL (10,2) NOT NULL,
	WeeklyRate DECIMAL (10,2) NOT NULL,
	MonthlyRate DECIMAL (10,2) NOT NULL,
	WeekendRate DECIMAL (10,2) NOT NULL
);


CREATE TABLE Cars 
(
	Id INT PRIMARY KEY IDENTITY,
	PlateNumber NVARCHAR(50) NOT NULL UNIQUE, 
	Manufacturer NVARCHAR (40) NOT NULL, 
	Model NVARCHAR (20) NOT NULL, 
	CarYear INT NOT NULL, 
	CategoryId INT FOREIGN KEY REFERENCES Categories(Id), 
	Doors INT NOT NULL, 
	Picture VARBINARY (MAX), 
	Condition NVARCHAR(500), 
	Available BIT NOT NULL
);


CREATE TABLE Employees 
(
	Id INT PRIMARY KEY IDENTITY,
	FirstName NVARCHAR (50) NOT NULL, 
	LastName NVARCHAR (50) NOT NULL, 
	Title NVARCHAR (40), 
	Notes NVARCHAR(200)
);

CREATE TABLE Customers 
(
	Id INT PRIMARY KEY IDENTITY, 
	DriverLicenceNumber NVARCHAR(30) NOT NULL UNIQUE, 
	FullName NVARCHAR(150) NOT NULL, 
	Address NVARCHAR(250) NOT NULL, 
	City NVARCHAR(50) NOT NULL, 
	ZIPCode NVARCHAR(50) NOT NULL, 
	Notes NVARCHAR(200)
);


CREATE TABLE RentalOrders 
(
	Id INT PRIMARY KEY IDENTITY, 
	EmployeeId INT FOREIGN KEY REFERENCES Employees(Id), 
	CustomerId INT FOREIGN KEY REFERENCES Customers(Id), 
	CarId INT FOREIGN KEY REFERENCES Cars(Id), 
	TankLevel INT NOT NULL, 
	KilometrageStart INT NOT NULL, 
	KilometrageEnd INT NOT NULL, 
	TotalKilometrage AS KilometrageEnd - KilometrageStart,
	StartDate DATE NOT NULL, 
	EndDate DATE NOT NULL, 
	TotalDays AS DATEDIFF (DAY,StartDate, EndDate), 
	RateApplied INT NOT NULL, 
	TaxRate AS RateApplied * 0.2, 
	OrderStatus BIT NOT NULL , 
	Notes NVARCHAR(500)
);



INSERT INTO Categories (CategoryName, DailyRate, WeeklyRate, MonthlyRate, WeekendRate)
VALUES
('sports saloon', 75, 400, 1200, 120 ),
('Limousine', 100, 600, 2000, 180 ),
('Crossover', 65, 350, 800, 100 );

INSERT INTO Cars (PlateNumber, Manufacturer, Model, CarYear, CategoryId, Doors, Picture, Condition, Available)
VALUES
('ABE072', 'VW', 'Sidan', 2014, 1,4, NULL, 'Good', 1  ),
('HTO762', 'Audi','A6', 2009, 2, 5, NULL, 'Best', 0 ), 
('HHT254', 'Valvo', 'CX60', 2010, 3, 4, NULL, 'Very Good', 1 );



INSERT INTO Employees (FirstName, LastName, Title, Notes)
VALUES
('Jamil', 'Uddin', 'Manager',NULL),
('Ashik', 'Alam', 'Engineer',NULL),
('Sunny', 'Hossen', 'Support',NULL);



INSERT INTO Customers (DriverLicenceNumber, FullName, Address, City, ZIPCode, Notes)
VALUES
('ACD234567', 'Martin Lorsson','Rontengatan 5', 'Stockholm', 14343,	NULL),
('ACD654321', 'Mimi Kalsson','Varagatan 25', 'Uppsala', 12765, NULL),
('ACD654789', 'Anna Lorsson','Mogårdvagen 21', 'Malmo', 13452, NULL);

INSERT INTO RentalOrders (EmployeeId, CustomerId, CarId, TankLevel, KilometrageStart, KilometrageEnd, StartDate, EndDate, RateApplied, OrderStatus, Notes)
VALUES
(1, 2, 1, 50, 16000, 16743, '2019-12-10', '2019-12-13', 350, 1, NULL),
(2, 2, 1, 40, 36000, 36743, '2019-12-19', '2019-12-24', 550, 0, NULL ),
(3, 2, 3, 25, 26000, 26743, '2020-01-10', '2020-01-14', 500, 0, NULL);



/** 15.	Hotel Database (Grade = Great!) **/
 CREATE DATABASE Hotel;

 GO

 USE Hotel;


CREATE TABLE Employees 
(
	Id INT PRIMARY KEY IDENTITY, 
	FirstName NVARCHAR (50) NOT NULL, 
	LastName NVARCHAR (50) NOT NULL, 
	Title NVARCHAR (20) NOT NULL, 
	Notes NVARCHAR (350)
);


CREATE TABLE Customers 
(
	AccountNumber INT PRIMARY KEY IDENTITY, 
	FirstName NVARCHAR (50) NOT NULL, 
	LastName NVARCHAR (50) NOT NULL, 
	PhoneNumber NVARCHAR (35) NOT NULL, 
	EmergencyName NVARCHAR (35), 
	EmergencyNumber NVARCHAR (35), 
	Notes NVARCHAR (350)
);


CREATE TABLE RoomStatus 
(
	RoomStatus NVARCHAR (50) PRIMARY KEY NOT NULL,
	Notes NVARCHAR (350)
);


CREATE TABLE RoomTypes 
(
	RoomType NVARCHAR (50) PRIMARY KEY NOT NULL, 
	Notes NVARCHAR (350)
);


CREATE TABLE BedTypes 
(
	BedType  NVARCHAR (50) PRIMARY KEY NOT NULL, 
	Notes NVARCHAR (350)
);


CREATE TABLE Rooms 
(
	RoomNumber INT PRIMARY KEY IDENTITY, 
	RoomType NVARCHAR (50) FOREIGN KEY REFERENCES RoomTypes (RoomType) NOT NULL, 
	BedType NVARCHAR (50) FOREIGN KEY REFERENCES BedTypes (BedType) NOT NULL, 
	Rate decimal (6,2) NOT NULL, 
	RoomStatus NVARCHAR (50) FOREIGN KEY REFERENCES RoomStatus (RoomStatus)NOT NULL, 
	Notes NVARCHAR (350)
);


CREATE TABLE Payments 
(
	Id INT PRIMARY KEY IDENTITY, 
	EmployeeId INT FOREIGN KEY REFERENCES Employees(Id) NOT NULL,
	PaymentDate DATETIME NOT NULL, 
	AccountNumber INT FOREIGN KEY REFERENCES Customers(AccountNumber) NOT NULL, 
	FirstDateOccupied DATE NOT NULL, 
	LastDateOccupied DATE NOT NULL, 
	TotalDays AS DATEDIFF (DAY,FirstDateOccupied,LastDateOccupied), 
	AmountCharged DECIMAL (7,2) NOT NULL,
	TaxRate DECIMAL (6,2) NOT NULL,
	TaxAmount AS AmountCharged * TaxRate , 
	PaymentTotal AS AmountCharged + AmountCharged * TaxRate,
	Notes NVARCHAR (500)
);


CREATE TABLE Occupancies 
(
	Id INT PRIMARY KEY IDENTITY, 
	EmployeeId INT FOREIGN KEY REFERENCES Employees(Id) NOT NULL,
	DateOccupied DATE NOT NULL, 
	AccountNumber INT FOREIGN KEY REFERENCES Customers(AccountNumber) NOT NULL,
	RoomNumber INT FOREIGN KEY REFERENCES Rooms(RoomNumber) NOT NULL,
	RateApplied DECIMAL (7, 2) NOT NULL, 
	PhoneCharge DECIMAL (8, 2) NOT NULL , 
	Notes NVARCHAR (500)
);



INSERT INTO Employees (FirstName, LastName, Title, Notes)
VALUES
('Jamil', 'Uddin', 'Manager', NULL),
('Ashik', 'Alam', 'Support', NULL),
('Sunny', 'Hossen', 'Helpdesk', NULL);


INSERT INTO Customers (FirstName, LastName, PhoneNumber, EmergencyName, EmergencyNumber, Notes)
VALUES
('Adam', 'Kalsson', '+46700786587', null, null, null),
('Tomy', ' Lorsson', '+46700700584', null, null, null),
('Anna', 'Johnsson', '+46700706512', null, null, null);


INSERT INTO RoomStatus(RoomStatus, Notes)
VALUES
('Non Occupied', NULL),
('Occupide', NULL),
('Occupide', NULL);


INSERT INTO RoomTypes (RoomType, Notes)
VALUES
('single', NULL),
('double', NULL ),
('appartment', NULL);

INSERT INTO BedTypes (BedType, Notes)
VALUES
('single', NULL),
('double', NULL ),
('couch', NULL);


INSERT INTO Rooms (RoomNumber, RoomType, BedType, Rate, RoomStatus, Notes)
VALUES
(201, 'single', 'single', 45.0, 1, 'Good'),
(204, 'double', 'double', 80.0, 0, NULL),
(210, 'appartment', 'double', 150.0, 1, 'Nice');


INSERT INTO Payments (EmployeeId, PaymentDate, AccountNumber, FirstDateOccupied, LastDateOccupied, AmountCharged, TaxRate, Notes)
VALUES
(1, '2019-11-25', 2, '2019-11-30', '2019-12-04', 250.0, 0.2, NULL),
(3, '2020-05-03', 3, '2204-05-06', '2020-05-09', 340.0, 0.2, NULL),
(3, '2020-02-25', 2, '2020-02-27', '2020-03-04', 500.0, 0.2, NULL);

INSERT INTO Occupancies (EmployeeId, DateOccupied, AccountNumber, RoomNumber, RateApplied, PhoneCharge, Notes)
VALUES
(2, '2019-02-04', 3, 204, 80.0, 12.54, NULL),
(2, '2020-04-09', 1, 201, 45.0, 11.22, NULL),
(3, '2020-05-08', 2, 210, 150.0, 10.05, NULL);



/** 16.	Create Lexicon Database **/

CREATE DATABASE Lexicon;

 GO

 USE Lexicon;


CREATE TABLE Towns 
(
	Id INT PRIMARY KEY IDENTITY NOT NULL, 
	Name NVARCHAR(50) NOT NULL
);


CREATE TABLE Addresses 
(
	Id INT PRIMARY KEY IDENTITY NOT NULL, 
	AddressText NVARCHAR(200) NOT NULL, 
	TownId INT FOREIGN KEY REFERENCES Towns (Id) NOT NULL
);


CREATE TABLE Departments 
(
	Id INT PRIMARY KEY IDENTITY NOT NULL,
	Name NVARCHAR (100) NOT NULL
);


CREATE TABLE Employees 
(
	Id INT PRIMARY KEY IDENTITY NOT NULL, 
	FirstName NVARCHAR (50) NOT NULL, 
	MiddleName NVARCHAR (50), 
	LastName NVARCHAR (50) NOT NULL, 
	JobTitle NVARCHAR (100) NOT NULL, 
	DepartmentId INT FOREIGN KEY REFERENCES Departments (Id) NOT NULL, 
	HireDate DATE, 
	Salary DECIMAL (7,2) NOT NULL, 
	AddressId INT FOREIGN KEY REFERENCES Addresses (Id) NOT NULL
);


/** 17.	Backup Database **/

BACKUP DATABASE Lexicon TO DISK = 'D:\Lexicon.bak';

USE Hotel;

DROP DATABASE Lexicon;

RESTORE DATABASE Lexicon FROM DISK = 'D:\Lexicon.bak';


/** 18.	Basic Insert **/

USE Lexicon;


 INSERT INTO Towns (Name)
 VALUES
 ('Sofia'),
 ('Plovdiv'),
 ('Varna'),
 ('Burgas');

 INSERT INTO Addresses (AddressText, TownId)
 VALUES
 ('Hamngatan 24', 2),
 ('Rontengatan 10', 3),
 ('Mogardsgatan 27', 4),
 ('Vasagatan 30', 1);


INSERT INTO Departments (Name)
VALUES
('Engineering'),
('Sales'),
('Marketing'),
('Software Development'),
('Quality Assurance');


INSERT INTO Employees (FirstName, MiddleName, LastName, JobTitle, DepartmentId, HireDate, Salary, AddressId)
VALUES
('Mel', 'Gibson', 'Gibson', '.NET Developer', 4, CONVERT(DATE, '01/02/2013', 103), 3500.00, 2),
('Chuck', 'Norris', 'Norris', 'Senior Engineer', 1, CONVERT(DATE, '02/03/2004', 103), 4000.00, 5),
('Greta', 'Garbo', 'Garbo', 'Intern', 5, CONVERT(DATE, '28/08/2016', 103), 525.25, 4),
('Meryl', 'Strep', 'Strep', 'CEO', 2, CONVERT(DATE, '09/12/2007', 103), 3000.00, 3),
('Peter', 'Pan', 'Pan', 'Intern', 3, CONVERT(DATE, '28/08/2016', 103), 599.88, 5);



/** 19.	Basic Select All Fields (Grade = Excellent!) **/

SELECT * FROM Towns;

SELECT * FROM Departments;

SELECT * FROM Employees;



/** 20.	Basic Select All Fields and Order Them **/

SELECT * FROM Towns
ORDER BY Name ASC;

SELECT * FROM Departments
ORDER BY Name ASC;


SELECT * FROM Employees
ORDER BY Salary DESC;


/** 21.	Basic Select Some Fields **/
SELECT Name FROM Towns
ORDER BY Name ASC;

SELECT Name FROM Departments
ORDER BY Name ASC;


SELECT FirstName, LastName, JobTitle, Salary FROM Employees
ORDER BY Salary DESC;


/** 22.	Increase Employees Salary (Grade = Expert!) **/

UPDATE Employees
SET Salary = Salary * 1.10;

SELECT Salary FROM Employees;
