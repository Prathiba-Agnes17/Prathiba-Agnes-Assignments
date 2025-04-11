--TASK 1--
--CUSTOMERS TABLE--
CREATE TABLE Customers
(
CustomerID int identity Primary Key,
FirstName varchar(100) not null,
LastName varchar(100),
Email varchar(100) unique not null,
Phone bigint unique not null,
Address varchar(400) not null
)

select * from Customers

insert into Customers values('Priya','Ragavan','abc@gmail.com','9087654321','13 Gandhi nagar Vellore'),
('Riya','Karthik','def@gmail.com','9807654321','1 Indira nagar Trichy'),
('Arya','Pandey','ghi@gmail.com','9870654321','9 Sakthi nagar Chennai'),
('Pavithra','Bala','jkl@gmail.com','9876054321','1 Maraimalai nagar Thoothukudi'),
('Sugirtha','Parthiban','mno@gmail.com','9876504321','12 Sumithra nagar chennai'),
('Nancy','Joseph','pqr@gmail.com','9876540321','26 Wallajabad Thenneri'),
('Shivangi','Barath','stu@gmail.com','9876543021','98 Lakshmi nagar Thoothukudi'),
('Melvin','Nickolas','vwx@gmail.com','9876543201','18 Ramamoorthy avenue Coimbatore'),
('Madhu','Gautham','cba@gmail.com','9876543210','7 palaniyapa nagar pudukottai'),
('Swathi','Murugan','rqp@gmail.com','9876534021','3 demontee colony chennai')

--PRODUCTS TABLE--

CREATE TABLE Products
(
ProductID int identity Primary Key,
ProductName varchar(100) not null,
Description varchar(500) not null,
Price decimal(10,2) not null
)

select * from Products

insert into Products values('iPhone 15 Pro','128GB,A17 Pro Chip,Dynamic Island Display',134900.00),
('Samsung galaxy S23','128GB,A17 Pro Chip Dynamic,Island Display',79999.00),
('MacBook Air M2','13.6-inch Retina,8GB RAM,256GB SSD',114900.00),
('Dell XPs 13','Intel Core i7, 16GB RAM, 512GB SSD',129999.00),
('Sony WH-1000XM5','Noise cancelling wireless headphones',29999.00),
('Apple iPad Air','10.9-inch retina,A14 bionic,Wifi',54900.00),
('OnePlus Nord Buds 2','True wireless Earbuds,Dolby Atmos',2999.00),
('HP Pavilion Gaming Laptop','Ryzen 7,RTX 3050,16GB RAM,512 GB SSD',85000.00),
('Logitech MX MAster 3','Wireless Bluetooth mouse',8499.00),
('Samsung 32-inch 4K monitor','UHD',27999.00)


--ORDERS TABLE--

CREATE TABLE Orders
(
OrderID int identity Primary Key,
CustomerID int not null,
OrderDate Datetime not null,
TotalAmount decimal(10,2) not null
constraint fk_customerId Foreign Key(CustomerID) references Customers(CustomerID)
)

select * from Orders



INSERT INTO Orders (CustomerID, OrderDate, TotalAmount) VALUES
(1, '2024-03-01 10:30', 137898.00),
(2, '2024-03-02 14:45', 79999.00),
(3, '2024-03-03 09:15', 134900.00),
(4, '2024-03-04 16:20', 59998.00),  
(5, '2024-03-05 12:10', 85000.00),
(6, '2024-03-06 18:55', 25497.00),
(7, '2024-03-07 08:30', 129999.00),
(8, '2024-03-08 20:05', 2999.00),
(9, '2024-03-09 11:40', 109800.00),
(10, '2024-03-10 15:25', 8499.00)


--ORDERDETAILS TABLE--

CREATE TABLE OrderDetails
(
OrderDetailID int identity Primary Key,
OrderID int not null,
ProductID int not null,
Quantity int not null,
constraint fk_OrderId Foreign Key(OrderID) references Orders(OrderID),
constraint fk_ProductId Foreign Key(ProductID) references Products(ProductID)
)

select * from OrderDetails




INSERT INTO OrderDetails (OrderDetailID,OrderID, ProductID, Quantity) VALUES
(1,1, 3, 1), 
(2,1, 7, 2),  -- OnePlus Nord Buds 2
(3,2, 1, 1),  -- iPhone 15 Pro
(4,3, 5, 1),  -- Sony WH-1000XM5
(5,4, 8, 2),  -- (Ensure ProductID 8 exists)
(6,5, 2, 1),  -- Samsung Galaxy S23
(7,6, 9, 3),  -- Logitech MX Master 3
(8,7, 4, 1),  -- Dell XPS 13
(9,8, 10, 1), -- Bose QuietComfort Earbuds
(10,9, 6, 2);  -- Apple iPad Air (Updated Quantity)


--INVENTORY TABLE--

CREATE TABLE Inventory
(
InventoryID int identity Primary Key,
ProductID int not null,
QuantityInStock int not null,
LastStockUpdate datetime not null,
constraint fk_Inventory_ProductId Foreign Key(ProductID) references Products(ProductID)
)

select * from Inventory

INSERT INTO Inventory (ProductID,QuantityInStock,LastStockUpdate) VALUES
(1, 50, '2024-03-01 10:00'),
(2, 30, '2024-03-02 14:30'),
(3, 20, '2024-03-03 09:15'),
(4, 15, '2024-03-04 12:45'),
(5, 40, '2024-03-05 16:10'),
(6, 25, '2024-03-06 18:00'),
(7, 35, '2024-03-07 08:20'),
(8, 10, '2024-03-08 20:50'),
(9, 60, '2024-03-09 11:10'),
(10, 45, '2024-03-10 15:30')



--TASK 2--

--1.Write an SQL query to retrieve the names and emails of all customers
select FirstName,LastName,Email from Customers

--2.Write an SQL query to list all orders with their order dates and corresponding customer names
SELECT O.OrderID, O.OrderDate, C.FirstName, C.LastName
FROM Orders O
JOIN 
Customers C 
ON O.CustomerID = C.CustomerID;


--3.Write an SQL query to insert a new customer record into the "Customers" table. Include customer information such as name, email, and address. 
INSERT INTO Customers VALUES ('John',' Doe', 'jd@gmail.com', '123 Main Street New York NY');

--4. Write an SQL query to update the prices of all electronic gadgets in the "Products" table by increasing them by 10%. 
Update Products 
Set Price=Price*1.10;

--5. Write an SQL query to delete a specific order and its associated order details from the "Orders" and "OrderDetails" tables. Allow users to input the order ID as a parameter. 
DELETE FROM OrderDetails WHERE OrderID=2
DELETE FROM Orders WHERE OrderID=2

--6. Write an SQL query to insert a new order into the "Orders" table. Include the customer ID, order date, and any other necessary information.--
Insert INTO Orders VALUES (10, '2025-03-18 14:30', 2999.00)


--7. Write an SQL query to update the contact information (e.g., email and address) of a specific customer in the "Customers" table. Allow users to input the customer ID and new contact information. 
DECLARE @CustomerID INT = 5;
DECLARE @NewEmail VARCHAR(100) = 'newemail@example.com';
DECLARE @NewAddress VARCHAR(400) = 'New Address, City';   

UPDATE Customers
SET Email = @NewEmail,
    Address = @NewAddress
WHERE CustomerID = @CustomerID;


--8.Write an SQL query to recalculate and update the total cost of each order in the "Orders" table based on the prices and quantities in the "OrderDetails" table. 
UPDATE Orders
SET TotalAmount = (
    SELECT SUM(od.Quantity * p.Price)
    FROM OrderDetails od
    JOIN 
	Products p 
	ON od.ProductID = p.ProductID
    WHERE od.OrderID = Orders.OrderID
)
--9. Write an SQL query to delete all orders and their associated order details for a specific customer from the "Orders" and "OrderDetails" tables. Allow users to input the customer ID as a parameter. 
DECLARE @CustomerID1 INT = 1;
DELETE FROM OrderDetails
WHERE OrderID IN (SELECT OrderID FROM Orders WHERE CustomerID = @CustomerID);
DELETE FROM Orders
WHERE CustomerID = @CustomerID

--10. Write an SQL query to insert a new electronic gadget product into the "Products" table, including product name, category, price, and any other relevant details. 
INSERT INTO Products (ProductName, Description, Price)
VALUES ('Google Pixel 8 Pro', '128GB, Tensor G3 Chip, 50MP Camera', 99999.00);

--11. Write an SQL query to update the status of a specific order in the "Orders" table (e.g., from "Pending" to "Shipped"). Allow users to input the order ID and the new status. 
ALTER TABLE Orders
ADD Status VARCHAR(50) DEFAULT 'Pending';
DECLARE @OrderID INT = 3; 
DECLARE @NewStatus VARCHAR(50) = 'Shipped';

UPDATE Orders
SET Status = @NewStatus
WHERE OrderID = @OrderID;

--12. Write an SQL query to calculate and update the number of orders placed by each customer in the "Customers" table based on the data in the "Orders" table.
ALTER TABLE Customers
ADD TotalOrders INT DEFAULT 0;
UPDATE Customers
SET TotalOrders = (
    SELECT COUNT(*)
    FROM Orders
    WHERE Orders.CustomerID = Customers.CustomerID
)

--TASK 3--
--1.Write an SQL query to retrieve a list of all orders along with customer information (e.g., customer name) for each order. 
SELECT O.OrderID, O.OrderDate, O.TotalAmount, C.FirstName, C.LastName
FROM Orders O
JOIN 
Customers C 
ON O.CustomerID = C.CustomerID;

--2. Write an SQL query to find the total revenue generated by each electronic gadget product. Include the product name and the total revenue. 
SELECT P.ProductName, SUM(O.TotalAmount) AS TotalRevenue
FROM Orders O
JOIN 
OrderDetails OD 
ON O.OrderID = OD.OrderID
JOIN Products P ON OD.ProductID = P.ProductID
GROUP BY P.ProductName
ORDER BY TotalRevenue DESC;

--3. Write an SQL query to list all customers who have made at least one purchase. Include their names and contact information. 
SELECT DISTINCT C.FirstName, C.LastName, C.Email, C.Phone, C.Address
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID;

--4. Write an SQL query to find the most popular electronic gadget, which is the one with the highest total quantity ordered. Include the product name and the total quantity ordered. 
SELECT TOP 1 P.ProductName, SUM(OD.Quantity) AS TotalQuantityOrdered
FROM OrderDetails OD
JOIN Products P ON OD.ProductID = P.ProductID
GROUP BY P.ProductName
ORDER BY TotalQuantityOrdered DESC;

--5. Write an SQL query to retrieve a list of electronic gadgets along with their corresponding categories. 
SELECT P.ProductName, P.Description
FROM Products P;

--6. Write an SQL query to calculate the average order value for each customer. Include the customer's name and their average order value. 
SELECT C.FirstName, C.LastName, AVG(O.TotalAmount) AS AverageOrderValue
FROM Orders O
JOIN Customers C ON O.CustomerID = C.CustomerID
GROUP BY C.FirstName, C.LastName;

--7. Write an SQL query to find the order with the highest total revenue. Include the order ID, customer information, and the total revenue. 
SELECT TOP 1 O.OrderID, C.FirstName, C.LastName, O.TotalAmount
FROM Orders O
JOIN Customers C ON O.CustomerID = C.CustomerID
ORDER BY O.TotalAmount DESC;

--8. Write an SQL query to list electronic gadgets and the number of times each product has been ordered. 
SELECT P.ProductName, COUNT(OD.OrderID) AS OrderCount
FROM OrderDetails OD
JOIN Products P ON OD.ProductID = P.ProductID
GROUP BY P.ProductName
ORDER BY OrderCount DESC;

--9. Write an SQL query to find customers who have purchased a specific electronic gadget product. Allow users to input the product name as a parameter. 
DECLARE @ProductName VARCHAR(100) = 'iPhone 15 Pro';
SELECT DISTINCT C.FirstName, C.LastName, C.Email, C.Phone
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN OrderDetails OD ON O.OrderID = OD.OrderID
JOIN Products P ON OD.ProductID = P.ProductID
WHERE P.ProductName = @ProductName;

--10. Write an SQL query to calculate the total revenue generated by all orders placed within a specific time period. Allow users to input the start and end dates as parameters. 
DECLARE @StartDate DATETIME = '2024-03-01';
DECLARE @EndDate DATETIME = '2024-03-10';
SELECT SUM(O.TotalAmount) AS TotalRevenue
FROM Orders O
WHERE O.OrderDate BETWEEN @StartDate AND @EndDate;

