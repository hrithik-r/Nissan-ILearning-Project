--DDL Assignment--
--1st Assignment--
CREATE TABLE Department(
	DeptNo NUMERIC(2) PRIMARY KEY,
	DeptName VARCHAR(20) UNIQUE,
	FloorNo NUMERIC(2),
	Location VARCHAR(20)
)

CREATE TABLE Employee(
	EmpNo NUMERIC(2) PRIMARY KEY,
	ManagerID NUMERIC(3),
	FirstName VARCHAR(20) NOT NULL,
	LastName VARCHAR(20),
	UserID VARCHAR(20),
	DeptNo NUMERIC(2)
		CONSTRAINT fk_deptno
		FOREIGN KEY(DeptNo)
		REFERENCES Department(DeptNo)
		ON DELETE CASCADE,
	Salary DECIMAL(8,2),
	Commission NUMERIC(3),
	JoiningDate DATE,
	Designation VARCHAR(25)
)


--2nd Assignment--
CREATE TABLE Customer(
	Custno NUMERIC(3) PRIMARY KEY,
	CustnoName VARCHAR(20),
	[Address] VARCHAR(40)
)

CREATE TABLE Orders(
	OrderNo NUMERIC(3) PRIMARY KEY,
	Custno NUMERIC(3)
		CONSTRAINT fk_custno
		FOREIGN KEY(Custno)
		REFERENCES Customer(Custno)
		ON DELETE CASCADE,
	OrderDate DATE
)

CREATE TABLE OrderItem(
	ItemID NUMERIC(3) PRIMARY KEY,
	OrderNo NUMERIC(3)
		CONSTRAINT fk_orderno
		FOREIGN KEY(OrderNo)
		REFERENCES Orders(OrderNo)
		ON DELETE CASCADE,
	ItemName VARCHAR(20),
	Quantity NUMERIC(20)
)

ALTER TABLE Customer ALTER COLUMN [Address] VARCHAR(100)


--3rd Assignment--
--Without composite key
CREATE TABLE Course(
	CourseID VARCHAR(5) PRIMARY KEY,
	StreamID VARCHAR(20),
	Title VARCHAR(40),
	Description  VARCHAR(200),
	Fees NUMERIC
)

CREATE TABLE Batch(
	BatchID VARCHAR(30) PRIMARY KEY,
	CourseID VARCHAR(5)
		CONSTRAINT fk_CourseID
		FOREIGN KEY(CourseID)
		REFERENCES Course(CourseID),
	BatchName CHAR(1)
)

--With composite key
CREATE TABLE Courses(
	CourseID VARCHAR(5),
	StreamID VARCHAR(20),
	Title VARCHAR(40),
	Description  VARCHAR(200),
	Fees NUMERIC,
		CONSTRAINT pk_CourseIDStreamID
		PRIMARY KEY(CourseID,StreamID)
)

CREATE TABLE Batches(
	BatchID VARCHAR(30) PRIMARY KEY,
	CourseID VARCHAR(5),
	StreamID VARCHAR(20)
		CONSTRAINT fk_CourseIDStreamID
		FOREIGN KEY(CourseID,StreamID)
		REFERENCES Courses(CourseID,StreamID),
	BatchName CHAR(1)
)

CREATE TABLE Student(
	StudID VARCHAR(20) PRIMARY KEY,
	LastName VARCHAR(25),
	MiddleName VARCHAR(30),
	FirstName VARCHAR(20),
	DOB DATE,
	[Address] VARCHAR(50),
	City VARCHAR(20),
	[State] VARCHAR(2),
	Zipcode VARCHAR(9),
	Telephone VARCHAR(10),
	Fax VARCHAR(10),
	Email VARCHAR(30),
	Grade CHAR(1),
		CONSTRAINT chk_Grade
		CHECK(Grade IN('A','A+','A-','B','B+','B-','C','C+','C-','D','D+','D-','F','F+','F-')),
	BatchID VARCHAR(30)
		CONSTRAINT fk_BatchID
		FOREIGN KEY(BatchID)
		REFERENCES BATCH(BatchID)
)

SELECT * FROM Student

ALTER TABLE Student DROP COLUMN MiddleName

EXEC sp_rename 'Student','Participants'

--DML Assignment--
--1a
CREATE TABLE Emp2(
	Id NUMERIC(2) PRIMARY KEY,
	LastName VARCHAR(20),
	DeptId NUMERIC(2)
)

INSERT INTO Emp2 (Id,LastName,DeptId)
SELECT EmpNo,LastName,DeptNo FROM Employee


--2b
INSERT INTO Employee
VALUES(69,105,'John','Doe','john01',10,42893.69,100,'2022-08-23','SWE-1')

--3c
INSERT INTO Department VALUES(10,'Accounts',2,'Trivandrum')

--4d
INSERT INTO Emp2 VALUES(54,'Sanjay',11),(77,'Ram',12),(41,'Mohammed',13)
INSERT INTO Employee
VALUES(10,129,'Jane','Doe','jane29',11,22811.39,200,'2022-01-09','Admin-1'),
(12,134,'Neel','Sharma','neel34',13,32022.33,150,'2021-08-04','SWE-2'),
(12,109,'Kumar','Shankar','kumar55',11,75431.99,600,'2021-02-20','DManager')
INSERT INTO Department VALUES(11,'Admin',1,'Trivandrum'),
(12,'IT',3,'Trivandrum'),(13,'HR',4,'Trivandrum')
INSERT INTO Customer VALUES(111,'Harish','Kazhakoottam'),(112,'Sunil','Technopark'),
(113,'Surya','Infopark')
INSERT INTO Orders VALUES(001,111,GETDATE()),(002,112,GETDATE()),(003,113,GETDATE())
INSERT INTO OrderItem VALUES(204,001,'Keyboard',1),(192,002,'Pendrive',3),(824,003,'CD',50)
INSERT INTO Course VALUES(10201,'D0021','Computer Vision','Computer Vision',59990),(18002,'S0022','ML/AI','ML/AI',45550),
(21051,'L0077','Data Science','Data Science',87590)
INSERT INTO Batch VALUES('CS2022',21051),('CS2021',18002),('CS2018',10201)

--5e
DELETE FROM Customer WHERE Custno=111

--6f
INSERT INTO Employee(EmpNo,FirstName) VALUES(16,'Hrithik')

--7g
UPDATE Customer SET [Address]='New Delhi' WHERE Custno=112

--8h
DELETE FROM Employee WHERE Salary>5000 AND DeptNo=10

--9i
UPDATE Employee SET FirstName='Kishore',DeptNo=11 WHERE EmpNo=16

--10j
UPDATE Students SET Email='NA' WHERE Email IS NULL

--11k
DELETE FROM Students WHERE Age>20

--12l
DELETE FROM Students WHERE Telephone IS NULL AND Email IS NULL

--13m
DELETE FROM Students
WHERE DATEPART(day, DOB) = 05 AND DATEPART(month, DOB) = 06

--14n
UPDATE Students SET FirstName='XXX',DOB=CURRENT_TIMESTAMP WHERE FirstName='___a%'

--15o
DELETE FROM Students WHERE FirstName='%a'

--16p
UPDATE Students SET LastName='Jan' WHERE DATEPART(month, DOB)=01

--17q
DELETE FROM Students WHERE [State]='T%'
