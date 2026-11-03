CREATE DATABASE CompanyDB;


USE CompanyDB;
GO

CREATE TABLE Departments
(
    DeptId INT PRIMARY KEY,
    DeptName VARCHAR(50),
    Location VARCHAR(50)
);

CREATE TABLE Employees
(
    EmpId INT PRIMARY KEY,
    EmpName VARCHAR(50),
    Salary DECIMAL(10,2),
    Gender VARCHAR(10),
    City VARCHAR(50),
    DeptId INT,
    ManagerId INT NULL,
    FOREIGN KEY (DeptId) REFERENCES Departments(DeptId)
);
INSERT INTO Departments (DeptId, DeptName, Location)
VALUES
(1, 'IT', 'Pune'),
(2, 'HR', 'Mumbai'),
(3, 'Finance', 'Nashik'),
(4, 'Sales', 'Pune'),
(5, 'Marketing', 'Mumbai'),
(6, 'Support', 'Karad');

INSERT INTO Employees
(EmpId, EmpName, Salary, Gender, City, DeptId, ManagerId)
VALUES
(101, 'Rahul', 45000, 'Male', 'Pune', 1, NULL),
(102, 'Priya', 55000, 'Female', 'Mumbai', 2, NULL),
(103, 'Amit', 35000, 'Male', 'Pune', 1, 101),
(104, 'Sneha', 60000, 'Female', 'Nashik', 3, NULL),
(105, 'Rohit', 30000, 'Male', 'Mumbai', 4, 102),
(106, 'Pooja', 40000, 'Female', 'Pune', 2, 102),
(107, 'Kiran', 70000, 'Male', 'Karad', 3, 104),
(108, 'Neha', 25000, 'Female', 'Pune', 1, 101),
(109, 'Sagar', 50000, 'Male', 'Mumbai', 4, 105),
(110, 'Anjali', 65000, 'Female', 'Nashik', 5, NULL);

SELECT * FROM Departments;

SELECT * FROM Employees;

SELECT EMPNAME,SALARY FROM Employees;

SELECT * FROM Employees WHERE Salary > 40000;

SELECT * FROM Employees WHERE City = 'Pune';

SELECT * FROM Employees WHERE SALARY BETWEEN 30000 AND 60000;

SELECT * FROM Employees WHERE Gender = 'FEMALE';

SELECT * FROM Employees WHERE EmpName LIKE 'A%';

SELECT * FROM Employees ORDER BY Salary DESC;

SELECT COUNT(*) FROM Employees;

SELECT DISTINCT CITY FROM Employees;

SELECT SUM(Salary) FROM Employees;

SELECT AVG(Salary) FROM Employees;

SELECT MAX(Salary) FROM Employees;

SELECT MIN(Salary) FROM Employees;

SELECT DeptId, COUNT(EmpId) AS TotalEmployees FROM Employees GROUP BY DeptId;

SELECT DeptId, AVG(Salary) AS AVGSALARY FROM Employees GROUP BY DeptId;

SELECT DeptId, AVG(Salary) AS AverageSalary FROM Employees GROUP BY DeptId HAVING AVG(Salary) > 40000;

SELECT EmpName,DeptName FROM Departments INNER JOIN Employees ON  Departments.DeptId = Employees.DeptId;

SELECT EmpName,DeptName FROM Departments LEFT JOIN Employees ON  Departments.DeptId = Employees.DeptId;

SELECT EmpName,DeptName FROM Departments RIGHT JOIN Employees ON  Departments.DeptId = Employees.DeptId;

SELECT EmpName,DeptName FROM Departments  FULL OUTER JOIN Employees ON  Departments.DeptId = Employees.DeptId;

SELECT EmpName,DeptName FROM Departments  LEFT JOIN Employees ON  Departments.DeptId = Employees.DeptId  IS NULL;

SELECT  Departments.DeptId, Departments.DeptName FROM Departments LEFT JOIN Employees ON Departments.DeptId = Employees.DeptId WHERE Employees.EmpId IS NULL;

SELECT  Departments.DeptId, Departments.DeptName FROM Departments RIGHT JOIN Employees ON Departments.DeptId = Employees.DeptId WHERE Employees.EmpId IS NULL;

SELECT E.EmpName AS EmployeeName, M.EmpName AS ManagerName
FROM Employees E
LEFT JOIN Employees M
ON E.ManagerId = M.EmpId;

SELECT EmpName FROM Employees WHERE Salary > (SELECT AVG(Salary) FROM Employees) ;

SELECT * FROM Employees WHERE Salary = (SELECT MAX(Salary) FROM Employees);

SELECT * FROM Employees WHERE Salary = (SELECT MIN(Salary) FROM Employees);

SELECT EmPName FROM Employees WHERE DeptId = (SELECT DeptId FROM Departments WHERE DeptName = 'IT');

SELECT EmpName FROM Employees WHERE Salary > (SELECT SALARY FROM Employees WHERE EmpName = 'Rahul');

INSERT INTO Employees(EmpId,EmpName,Salary,Gender,City,DeptId,ManagerId) VALUES(111,'VARUN',38000,'MALE','PUNE',1,101);

UPDATE Employees SET SALARY = 60000 WHERE  EmpName='PRIYA';

UPDATE Employees SET City = 'PUNE' WHERE City='KARAD';

DELETE  FROM Employees WHERE EmpId = 111;

INSERT INTO Departments (DeptId,DeptName,Location) VALUES (7,'DEVALOPMENT','PUNE');

UPDATE Employees SET Salary = Salary + (Salary/10) WHERE Salary < 30000;

SELECT CITY FROM Employees UNION SELECT LOCATION FROM Departments;

SELECT CITY FROM Employees UNION ALL SELECT LOCATION FROM Departments;

SELECT EmpName, Salary,
CASE
    WHEN Salary >= 50000 THEN 'High'
    ELSE 'Low'
END AS SalaryStatus
FROM Employees;

SELECT 
    D.DeptName,
    COUNT(E.EmpId) AS TotalEmployees
FROM Departments D
INNER JOIN Employees E
    ON D.DeptId = E.DeptId
GROUP BY D.DeptId, D.DeptName
HAVING COUNT(E.EmpId) > 2;

SELECT
    EmpName,
    Salary,
    ROW_NUMBER() OVER (ORDER BY Salary DESC) AS Ranking
FROM Employees;

CREATE VIEW EmployeeView AS
SELECT EmpName, Salary,City
FROM Employees;