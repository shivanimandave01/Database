CREATE DATABASE ECommerceDB;

USE ECommerceDB;

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    City VARCHAR(50),
    Email VARCHAR(100)
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    Stock INT
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10,2),
    FOREIGN KEY (CustomerID)
    REFERENCES Customers(CustomerID)
);

CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY,
    OrderID INT,
    PaymentMode VARCHAR(30),
    PaymentStatus VARCHAR(30),
    FOREIGN KEY (OrderID)
    REFERENCES Orders(OrderID)
);

INSERT INTO Customers VALUES
(1,'Rahul','Pune','rahul@gmail.com'),
(2,'Priya','Mumbai','priya@gmail.com'),
(3,'Amit','Karad','amit@gmail.com'),
(4,'Sneha','Satara','sneha@gmail.com'),
(5,'Neha','Pune','neha@gmail.com'),
(6,'Akash','Kolhapur','akash@gmail.com');

INSERT INTO Products VALUES
(101,'Laptop','Electronics',55000,10),
(102,'Mobile','Electronics',25000,20),
(103,'Keyboard','Accessories',1500,50),
(104,'Mouse','Accessories',800,40),
(105,'Chair','Furniture',5000,15),
(106,'Table','Furniture',8000,8),
(107,'Headphones','Electronics',3000,25);

INSERT INTO Orders VALUES
(201,1,'2026-01-10',55000),
(202,2,'2026-01-12',25000),
(203,1,'2026-01-15',1500),
(204,3,'2026-02-01',8000),
(205,4,'2026-02-05',3000),
(206,5,'2026-02-10',5000);

INSERT INTO Payments VALUES
(301,201,'UPI','Completed'),
(302,202,'Card','Completed'),
(303,203,'Cash','Pending'),
(304,204,'UPI','Completed'),
(305,205,'Card','Failed'),
(306,206,'Cash','Completed');

SELECT * FROM Customers;

SELECT * FROM Products WHERE Price > 3000;

SELECT ProductName FROM Products WHERE Stock < 15;

SELECT * FROM Products ORDER BY Price DESC;

SELECT CustomerName FROM Customers  WHERE  CustomerName LIKE  'A%';

SELECT COUNT(*) FROM Products;

SELECT MAX(Price) AS MAXIMUM, MIN(Price) AS MINIMUM FROM Products;

SELECT AVG(Price) FROM Products GROUP BY Category;

SELECT CustomerName,COUNT(*) FROM Customers GROUP BY CustomerName;

SELECT Customers.CustomerName,Orders.OrderID FROM Customers INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID;

SELECT Customers.CustomerName,Orders.OrderID FROM Customers LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID;

SELECT Customers.CustomerName,Orders.OrderID FROM Customers RIGHT JOIN Orders ON Customers.CustomerID = Orders.CustomerID;

SELECT * FROM Customers FULL OUTER JOIN Orders ON Customers.CustomerID = Orders.CustomerID;

SELECT Customers.CustomerName FROM Customers INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID;

SELECT Customers.CustomerName,COUNT(Orders.OrderID) FROM Customers LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID GROUP BY Customers.CustomerID,Customers.CustomerName;

SELECT Customers.CustomerName,SUM(Orders.TotalAmount) AS TotalPurchase FROM Customers left JOIN Orders ON Customers.CustomerID = Orders.CustomerID GROUP BY Orders.OrderID,Customers.CustomerName;

SELECT Customers.CustomerName FROM Customers LEFT JOIN Orders ON Customers.CustomerID  = Orders.CustomerID WHERE ISNULL(Orders.TotalAmount,0) = 0;

SELECT Customers.CustomerName,Orders.OrderID FROM Customers INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID WHERE TotalAmount > 10000;

SELECT TOP 1 Customers.CustomerName,COUNT(Orders.CustomerID) AS TOTALORDERS FROM Customers INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID GROUP bY Customers.CustomerName ORDER BY TOTALORDERS DESC;

SELECT TOP 1 Customers.CustomerName,SUM(Orders.TotalAmount) AS TOTALPURCHASE FROM CUSTOMERS LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID GROUP BY Customers.CustomerName ORDER BY TOTALPURCHASE DESC;

SELECT TOP 1 Products.ProductName,Products.Price FROM PRODUCTS WHERE Products.Price < (SELECT MAX(Products.Price) FROM Products );

SELECT Products.ProductName FROM Products WHERE Products.Price = (SELECT MAX(Products.Price) FROM Products) GROUP BY ProductName;

SELECT Orders.CustomerID,MAX(TotalAmount) FROM Orders GROUP BY Orders.CustomerID;

SELECT Customers.CustomerName,AVG(Orders.TotalAmount) FROM Customers LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID GROUP BY Customers.CustomerName;

SELECT Customers.CustomerName FROM Customers INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID GROUP BY Customers.CustomerName HAVING COUNT(Orders.CustomerID) > 1;

SELECT Products.ProductName FROM Products WHERE Products.Price > (SELECT aVG(PRODUCTS.Price)FROM Products ) ;

SELECT TOP 1 PRODUCTS.ProductName,Products.Price FROM Products WHERE Products.Price < (SELECT MAX(Products.Price) FROM Products) ORDER BY PRODUCTS.Price DESC;

UPDATE PRODUCTS SET PRODUCTS.Price = 28000 WHERE Products.ProductName = 'mOBILE';

DELETE Products WHERE Products.ProductName ='mOUSE';

SELECT Customers.CustomerName FROM Customers WHERE Customers.City = 'PUNE' UNION SELECT Customers.CustomerName FROM Customers WHERE Customers.City = 'MUMBAI';

SELECT
    ProductName,
    Price,
    CASE
        WHEN Price >= 10000 THEN 'Expensive'
        WHEN Price >= 3000 THEN 'Medium'
        ELSE 'Cheap'
    END AS PriceCategory
FROM Products;

CREATE VIEW ProductDetails AS
SELECT
    ProductName,
    Category,
    Price
FROM Products;

SELECT * FROM ProductDetails;

SELECT
    Customers.CustomerID,
    Customers.CustomerName,
    COUNT(Orders.OrderID) AS OrderCount,
    ISNULL(SUM(Orders.TotalAmount), 0) AS PurchaseAmount
FROM Customers
LEFT JOIN Orders
ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerID, Customers.CustomerName;