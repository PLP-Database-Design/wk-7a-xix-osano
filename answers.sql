-- Question 1: Achieving 1NF (First Normal Form)

SELECT OrderID, CustomerName, TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Products, ',', n), ',', -1)) AS Product
FROM ProductDetail
CROSS JOIN (SELECT 1 AS n UNION ALL SELECT 2 UNION ALL SELECT 3) AS numbers
ON LENGTH(Products) - LENGTH(REPLACE(Products, ',', '')) >= numbers.n - 1
ORDER BY OrderID;

-- Question 2: Achieving 2NF (Second Normal Form)

-- Create a new table for Customers
CREATE TABLE Customers AS
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;

-- Create a new table for Order Products
CREATE TABLE OrderProducts AS
SELECT OrderID, Product, Quantity
FROM OrderDetails;

-- Define primary and foreign key constraints:
ALTER TABLE Customers ADD CONSTRAINT PK_Customers PRIMARY KEY (OrderID);
ALTER TABLE OrderProducts ADD CONSTRAINT PK_OrderProducts PRIMARY KEY (OrderID, Product);
ALTER TABLE OrderProducts ADD CONSTRAINT FK_OrderProducts_Customers FOREIGN KEY (OrderID) REFERENCES Customers(OrderID);