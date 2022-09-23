--Machine Test

CREATE TABLE Employees(
	EmployeeID INT PRIMARY KEY,
	EmpName NVARCHAR(30),
	Phone NUMERIC(10),
	Email NVARCHAR(40)
)

CREATE TABLE Manufacturer(
	MfName NVARCHAR(30) PRIMARY KEY,
	City NVARCHAR(20),
	State NVARCHAR(20)
)

CREATE TABLE Computer(
	SerialNumber INT PRIMARY KEY,
	MfName NVARCHAR(30)
		CONSTRAINT fk_Cmptr_Mfg FOREIGN KEY(MfName) REFERENCES Manufacturer(MfName),
	Model NVARCHAR(30),
	Weight NUMERIC(3,2),
	EmployeeID INT
		CONSTRAINT fk_Cmptr_Emplys FOREIGN KEY(EmployeeID) REFERENCES Employees(EmployeeID)
)

INSERT INTO Manufacturer VALUES('Lenovo','Charity','South Dakota'),
							('IBM','Seattle','Washington'),
							('Acer','Pierre','South Dakota'),
							('Apple','Buffalo','New York'),
							('Dell','Dallas','Texas')

INSERT INTO Employees VALUES(101,'Mark',9876543210,'mark101@gmail.com'),
							(102,'Shah',8672382912,'shah102@gmail.com'),
							(103,'Naresh',9083719843,'naresh103@gmail.com'),
							(104,'Tyagi',7386238401,'tyagi104@gmail.com'),
							(105,'Akash',7916319374,'akash105@gmail.com')

INSERT INTO Computer VALUES(9918,'IBM','Powerbook',2.21,102),
						(7520,'Lenovo','Ideapad',1.76,105),
						(1109,'Acer','Notebook',1.53,101),
						(4970,'Dell','XPS',1.45,103),
						(8331,'Acer','Nitro',2.45,104)
--Q1
SELECT MfName AS Manufacturer,State AS Location
FROM Manufacturer
WHERE State LIKE 'South Dakota'

--Q2
SELECT AVG(Weight) AS AvgWeight FROM Computer

--Q3
SELECT EmpName AS Employee,Phone
FROM Employees
WHERE Phone LIKE '7%'

--Q4
SELECT SerialNumber,Weight
FROM Computer
WHERE Weight<(SELECT AVG(Weight) FROM Computer)

--Q5
SELECT MfName AS Manufacturer
FROM Manufacturer
WHERE MfName=(SELECT MfName FROM Manufacturer
			EXCEPT SELECT MfName FROM Computer)

--Q6
SELECT e.EmpName AS Employee, c.SerialNumber,m.City
FROM Employees e
JOIN Computer c
ON e.EmployeeID=c.EmployeeID
JOIN Manufacturer m
On c.MfName=m.MfName

--Q7
CREATE PROCEDURE sp_ListSerialMfgNameModelWeight
@EmployeeID INT
AS
BEGIN
	SELECT SerialNumber,MfName AS Manufacturer,Model,Weight
	FROM Computer
	WHERE EmployeeID=@EmployeeID
END

EXEC sp_ListSerialMfgNameModelWeight 101