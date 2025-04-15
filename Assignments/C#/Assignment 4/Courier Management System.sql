
CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY(1,1),  
    Name VARCHAR(255) NOT NULL,
    Email VARCHAR(255) UNIQUE NOT NULL,
    Password VARCHAR(255) NOT NULL,
    ContactNumber VARCHAR(20) NOT NULL,
    Address VARCHAR(MAX) NOT NULL  
);


CREATE TABLE Courier (
    CourierID INT PRIMARY KEY IDENTITY(1,1),
    SenderName VARCHAR(255) NOT NULL,
    SenderAddress VARCHAR(MAX) NOT NULL,  
    ReceiverName VARCHAR(255) NOT NULL,
    ReceiverAddress VARCHAR(MAX) NOT NULL,  
    Weight DECIMAL(5,2) NOT NULL,
    Status VARCHAR(50) NOT NULL CHECK (Status IN ('Pending', 'In Transit', 'Delivered', 'Cancelled')), 
    TrackingNumber VARCHAR(20) UNIQUE NOT NULL,
    DeliveryDate DATE
);


CREATE TABLE CourierServices (
    ServiceID INT PRIMARY KEY IDENTITY(1,1),
    ServiceName VARCHAR(100) NOT NULL,
    Cost DECIMAL(8,2) NOT NULL
);


CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(255) NOT NULL,
    Email VARCHAR(255) UNIQUE NOT NULL,
    ContactNumber VARCHAR(20) NOT NULL,
    Role VARCHAR(50) NOT NULL,
    Salary DECIMAL(10,2) NOT NULL
);


CREATE TABLE Location (
    LocationID INT PRIMARY KEY IDENTITY(1,1),
    LocationName VARCHAR(100) NOT NULL,
    Address VARCHAR(MAX) NOT NULL  
);


CREATE TABLE Payment (
    PaymentID INT PRIMARY KEY IDENTITY(1,1),
    CourierID INT NOT NULL,
    LocationID INT NOT NULL,
    Amount DECIMAL(10,2) NOT NULL,
    PaymentDate DATE NOT NULL,
    FOREIGN KEY (CourierID) REFERENCES Courier(CourierID) ON DELETE CASCADE,
    FOREIGN KEY (LocationID) REFERENCES Location(LocationID) ON DELETE CASCADE
);
select * from Payment

INSERT INTO Users (Name, Email, Password, ContactNumber, Address) VALUES
('John Doe', 'john.doe@example.com', 'password123', '9876543210', '123 Main St, NY'),
('Alice Smith', 'alice.smith@example.com', 'alice@123', '8765432109', '456 Oak St, CA'),
('Bob Johnson', 'bob.johnson@example.com', 'bob@456', '7654321098', '789 Pine St, TX'),
('Charlie Brown', 'charlie.brown@example.com', 'charlie789', '6543210987', '321 Maple St, FL'),
('David Williams', 'david.williams@example.com', 'david123', '5432109876', '555 Cedar St, IL'),
('Emma Davis', 'emma.davis@example.com', 'emma@789', '4321098765', '777 Elm St, WA'),
('Frank White', 'frank.white@example.com', 'frank@456', '3210987654', '888 Spruce St, CO'),
('Grace Miller', 'grace.miller@example.com', 'grace@234', '2109876543', '999 Birch St, MA'),
('Henry Taylor', 'henry.taylor@example.com', 'henry@567', '1098765432', '111 Walnut St, AZ'),
('Ivy Anderson', 'ivy.anderson@example.com', 'ivy@890', '0987654321', '222 Poplar St, NV');

INSERT INTO Courier (SenderName, SenderAddress, ReceiverName, ReceiverAddress, Weight, Status, TrackingNumber, DeliveryDate) VALUES
('John Doe', '123 Main St, NY', 'Alice Smith', '456 Oak St, CA', 2.5, 'Pending', 'TRK1001', '2025-03-28'),
('Alice Smith', '456 Oak St, CA', 'Bob Johnson', '789 Pine St, TX', 1.2, 'In Transit', 'TRK1002', '2025-03-29'),
('Bob Johnson', '789 Pine St, TX', 'Charlie Brown', '321 Maple St, FL', 3.0, 'Delivered', 'TRK1003', '2025-03-26'),
('Charlie Brown', '321 Maple St, FL', 'David Williams', '555 Cedar St, IL', 2.0, 'Pending', 'TRK1004', '2025-04-01'),
('David Williams', '555 Cedar St, IL', 'Emma Davis', '777 Elm St, WA', 4.5, 'In Transit', 'TRK1005', '2025-03-30'),
('Emma Davis', '777 Elm St, WA', 'Frank White', '888 Spruce St, CO', 1.8, 'Cancelled', 'TRK1006', NULL),
('Frank White', '888 Spruce St, CO', 'Grace Miller', '999 Birch St, MA', 2.2, 'Delivered', 'TRK1007', '2025-03-25'),
('Grace Miller', '999 Birch St, MA', 'Henry Taylor', '111 Walnut St, AZ', 3.1, 'Pending', 'TRK1008', '2025-04-02'),
('Henry Taylor', '111 Walnut St, AZ', 'Ivy Anderson', '222 Poplar St, NV', 5.0, 'In Transit', 'TRK1009', '2025-03-31'),
('Ivy Anderson', '222 Poplar St, NV', 'John Doe', '123 Main St, NY', 2.3, 'Delivered', 'TRK1010', '2025-03-27');


INSERT INTO CourierServices (ServiceName, Cost) VALUES
('Standard Delivery', 50.00),
('Express Delivery', 100.00),
('Overnight Delivery', 150.00),
('Same Day Delivery', 200.00),
('International Shipping', 500.00),
('Heavy Goods Shipping', 300.00),
('Fragile Items Shipping', 250.00),
('Bulk Shipping', 400.00),
('Document Courier', 30.00),
('Cash On Delivery Service', 20.00);


INSERT INTO Employee (Name, Email, ContactNumber, Role, Salary) VALUES
('Michael Scott', 'michael.scott@example.com', '1234567890', 'Manager', 60000.00),
('Jim Halpert', 'jim.halpert@example.com', '2345678901', 'Delivery Executive', 40000.00),
('Pam Beesly', 'pam.beesly@example.com', '3456789012', 'Customer Support', 35000.00),
('Dwight Schrute', 'dwight.schrute@example.com', '4567890123', 'Warehouse Supervisor', 50000.00),
('Stanley Hudson', 'stanley.hudson@example.com', '5678901234', 'Accountant', 55000.00),
('Kevin Malone', 'kevin.malone@example.com', '6789012345', 'Cashier', 30000.00),
('Angela Martin', 'angela.martin@example.com', '7890123456', 'HR Manager', 70000.00),
('Oscar Martinez', 'oscar.martinez@example.com', '8901234567', 'Finance Manager', 75000.00),
('Meredith Palmer', 'meredith.palmer@example.com', '9012345678', 'Sales Executive', 45000.00),
('Creed Bratton', 'creed.bratton@example.com', '0123456789', 'Logistics Coordinator', 50000.00);


INSERT INTO Location (LocationName, Address) VALUES
('New York Hub', '100 Main St, NY'),
('Los Angeles Hub', '200 Sunset Blvd, CA'),
('Chicago Hub', '300 Windy Ave, IL'),
('Houston Hub', '400 Space Rd, TX'),
('Miami Hub', '500 Beach Dr, FL'),
('Seattle Hub', '600 Rainy St, WA'),
('Denver Hub', '700 Mountain Ave, CO'),
('Boston Hub', '800 Freedom Rd, MA'),
('Phoenix Hub', '900 Desert Blvd, AZ'),
('Las Vegas Hub', '1000 Strip St, NV');


INSERT INTO Payment (CourierID, LocationID, Amount, PaymentDate) VALUES
(1, 1, 50.00, '2025-03-24'),
(2, 2, 100.00, '2025-03-25'),
(3, 3, 150.00, '2025-03-26'),
(4, 4, 200.00, '2025-03-27'),
(5, 5, 500.00, '2025-03-28'),
(6, 6, 300.00, '2025-03-29'),
(7, 7, 250.00, '2025-03-30'),
(8, 8, 400.00, '2025-03-31'),
(9, 9, 30.00, '2025-04-01'),
(10, 10, 20.00, '2025-04-02');

--TASK 2--
 
--1. List all customers
SELECT * FROM Users;

--2. List all orders for a specific customer  
SELECT * FROM Courier WHERE SenderName = (SELECT Name FROM Users WHERE UserID = 2);

--3. List all couriers
SELECT * FROM Courier;

--4. List all packages for a specific order
SELECT * FROM Courier WHERE CourierID = 4;

--5. List all deliveries for a specific courier
SELECT * FROM Courier WHERE CourierID = 7 AND Status = 'Delivered';

--6. List all undelivered packages
SELECT * FROM Courier WHERE Status IN ('Pending', 'In Transit');

--7. List all packages that are scheduled for delivery today
SELECT * FROM Courier WHERE DeliveryDate = CAST(GETDATE() AS DATE);

--8. List all packages with a specific status
SELECT * FROM Courier WHERE Status = 'In Transit';

--9. Calculate the total number of packages for each courier
SELECT SenderName, COUNT(*) AS TotalPackages 
FROM Courier 
GROUP BY SenderName;

--10. Find the average delivery time for each courier  
SELECT SenderName, AVG(DATEDIFF(DAY, DeliveryDate, GETDATE())) AS AvgDeliveryTime 
FROM Courier 
WHERE Status = 'Delivered'
GROUP BY SenderName;

--11. List all packages with a specific weight range
SELECT * FROM Courier WHERE Weight BETWEEN 2.00 AND 4.00;

--12. Retrieve employees whose names contain 'John'  
SELECT * FROM Employee WHERE Name LIKE '%John%';

--13. Retrieve all courier records with payments greater than $50. 
SELECT c.* 
FROM Courier c
JOIN Payment p ON c.CourierID = p.CourierID
WHERE p.Amount > 50;



--Task 3-- 

--14. Find the total number of couriers handled by each employee.  
SELECT e.EmployeeID, e.Name, COUNT(c.CourierID) AS TotalCouriers 
FROM Employee e
JOIN Courier c ON e.EmployeeID = c.CourierID  -- Assuming EmployeeID is related to Courier
GROUP BY e.EmployeeID, e.Name;

--15. Calculate the total revenue generated by each location  
SELECT l.LocationID, l.LocationName, SUM(p.Amount) AS TotalRevenue 
FROM Location l
JOIN Payment p ON l.LocationID = p.LocationID
GROUP BY l.LocationID, l.LocationName;

--16. Find the total number of couriers delivered to each location.
SELECT l.LocationID, l.LocationName, COUNT(c.CourierID) AS TotalDelivered 
FROM Location l
JOIN Courier c ON l.LocationID = c.CourierID  -- Assuming relation exists
WHERE c.Status = 'Delivered'
GROUP BY l.LocationID, l.LocationName;

--17. Find the courier with the highest average delivery time
SELECT TOP 1 SenderName, AVG(DATEDIFF(DAY, DeliveryDate, GETDATE())) AS AvgDeliveryTime 
FROM Courier 
WHERE Status = 'Delivered'
GROUP BY SenderName
ORDER BY AvgDeliveryTime DESC;

--18. Find Locations with Total Payments Less Than a Certain Amount  
SELECT LocationID, SUM(Amount) AS TotalPayments 
FROM Payment 
GROUP BY LocationID
HAVING SUM(Amount) < 500;

--19. Calculate Total Payments per Location
SELECT LocationID, SUM(Amount) AS TotalPayments 
FROM Payment 
GROUP BY LocationID;

--20. Retrieve couriers who have received payments totaling more than $1000 in a specific location (LocationID = X)
SELECT c.CourierID, c.SenderName, SUM(p.Amount) AS TotalPayment 
FROM Courier c
JOIN Payment p ON c.CourierID = p.CourierID
WHERE p.LocationID = 2
GROUP BY c.CourierID, c.SenderName
HAVING SUM(p.Amount) > 1000;

--21. Retrieve couriers who have received payments totaling more than $1000 after a certain date (PaymentDate > 'YYYY-MM-DD')
SELECT c.CourierID, c.SenderName, SUM(p.Amount) AS TotalPayment 
FROM Courier c
JOIN Payment p ON c.CourierID = p.CourierID
WHERE p.PaymentDate > 'YYYY-MM-DD'
GROUP BY c.CourierID, c.SenderName
HAVING SUM(p.Amount) > 1000;

--22. Retrieve locations where the total amount received is more than $5000 before a certain date (PaymentDate > 'YYYY-MM-DD') 
SELECT l.LocationID, l.LocationName, SUM(p.Amount) AS TotalReceived 
FROM Location l
JOIN Payment p ON l.LocationID = p.LocationID
WHERE p.PaymentDate < 'YYYY-MM-DD'
GROUP BY l.LocationID, l.LocationName
HAVING SUM(p.Amount) > 5000;


--Task 4--
--23. Retrieve Payments with Courier Information  
SELECT p.PaymentID, p.Amount, p.PaymentDate, c.CourierID, c.SenderName, c.ReceiverName
FROM Payment p
INNER JOIN Courier c ON p.CourierID = c.CourierID;

--24. Retrieve Payments with Location Information  
SELECT p.PaymentID, p.Amount, p.PaymentDate, l.LocationID, l.LocationName
FROM Payment p
INNER JOIN Location l ON p.LocationID = l.LocationID;

--25. Retrieve Payments with Courier and Location Information  
SELECT p.PaymentID, p.Amount, p.PaymentDate, c.CourierID, c.SenderName, c.ReceiverName, l.LocationID, l.LocationName
FROM Payment p
INNER JOIN Courier c ON p.CourierID = c.CourierID
INNER JOIN Location l ON p.LocationID = l.LocationID;

--26. List all payments with courier details  
SELECT p.*, c.*
FROM Payment p
INNER JOIN Courier c ON p.CourierID = c.CourierID;

--27. Total payments received for each courier  
SELECT c.CourierID, c.SenderName, SUM(p.Amount) AS TotalPayment
FROM Payment p
INNER JOIN Courier c ON p.CourierID = c.CourierID
GROUP BY c.CourierID, c.SenderName;

--28. List payments made on a specific date   
SELECT * FROM Payment 
WHERE PaymentDate BETWEEN '2025-03-25' AND '2025-03-28';


--29. Get Courier Information for Each Payment
SELECT p.PaymentID, c.*
FROM Payment p
INNER JOIN Courier c ON p.CourierID = c.CourierID;

--30. Get Payment Details with Location  
SELECT p.*, l.*
FROM Payment p
INNER JOIN Location l ON p.LocationID = l.LocationID;

--31. Calculating Total Payments for Each Courier  
SELECT CourierID, SUM(Amount) AS TotalPayments
FROM Payment
GROUP BY CourierID;

--32. List Payments Within a Date Range  
SELECT * FROM Payment 
WHERE CONVERT(DATE, PaymentDate) BETWEEN '2025-03-26' AND '2025-03-28';


--33. Retrieve a list of all users and their corresponding courier records, including cases where there are no matches on either side
SELECT u.*, c.*
FROM Users u
FULL OUTER JOIN Courier c ON u.Name = c.SenderName;

--34. Retrieve a list of all couriers and their corresponding services, including cases where there are no matches on either side  
SELECT c.*, cs.*
FROM Courier c
FULL OUTER JOIN CourierServices cs ON c.CourierID = cs.ServiceID;

--35. Retrieve a list of all employees and their corresponding payments, including cases where there are no matches on either side  
SELECT e.*, p.*
FROM Employee e
FULL OUTER JOIN Payment p ON e.EmployeeID = p.CourierID;  

--36. List all users and all courier services, showing all possible combinations. 
SELECT * FROM Users CROSS JOIN CourierServices;

--37. List all employees and all locations, showing all possible combinations
SELECT * FROM Employee CROSS JOIN Location;

--38. Retrieve a list of couriers and their corresponding sender information (if available) 
SELECT c.*, u.*
FROM Courier c
LEFT JOIN Users u ON c.SenderName = u.Name;

--39. Retrieve a list of couriers and their corresponding receiver information (if available)
SELECT c.*, u.*
FROM Courier c
LEFT JOIN Users u ON c.ReceiverName = u.Name;

--40. Retrieve a list of couriers along with the courier service details (if available)
SELECT c.*, cs.*
FROM Courier c
LEFT JOIN CourierServices cs ON c.CourierID = cs.ServiceID;

--41. Retrieve a list of employees and the number of couriers assigned to each employee
SELECT e.EmployeeID, e.Name, COUNT(c.CourierID) AS TotalCouriers
FROM Employee e
LEFT JOIN Courier c ON e.EmployeeID = c.CourierID
GROUP BY e.EmployeeID, e.Name;

--42. Retrieve a list of locations and the total payment amount received at each location
SELECT l.LocationID, l.LocationName, SUM(p.Amount) AS TotalPayments
FROM Location l
LEFT JOIN Payment p ON l.LocationID = p.LocationID
GROUP BY l.LocationID, l.LocationName;

--43. Retrieve all couriers sent by the same sender (based on SenderName)
SELECT a.*, b.*
FROM Courier a
JOIN Courier b ON a.SenderName = b.SenderName AND a.CourierID <> b.CourierID;

--44. List all employees who share the same role
SELECT a.*, b.*
FROM Employee a
JOIN Employee b ON a.Role = b.Role AND a.EmployeeID <> b.EmployeeID;

--45. Retrieve all payments made for couriers sent from the same location
SELECT p.*, c.*
FROM Payment p
INNER JOIN Courier c ON p.CourierID = c.CourierID
WHERE c.SenderAddress IN (SELECT SenderAddress FROM Courier GROUP BY SenderAddress HAVING COUNT(*) > 1);


--46. Retrieve all couriers sent from the same location (based on SenderAddress)
SELECT a.*, b.*
FROM Courier a
JOIN Courier b ON a.SenderAddress = b.SenderAddress AND a.CourierID <> b.CourierID;

--47. List employees and the number of couriers they have delivered
SELECT e.EmployeeID, e.Name, COUNT(c.CourierID) AS TotalDelivered
FROM Employee e
JOIN Courier c ON e.EmployeeID = c.CourierID  -- Assuming EmployeeID relates to Courier
WHERE c.Status = 'Delivered'
GROUP BY e.EmployeeID, e.Name;

--48. Find couriers that were paid an amount greater than the cost of their respective courier services  
SELECT c.CourierID, c.SenderName, cs.Cost, p.Amount
FROM Courier c
INNER JOIN CourierServices cs ON c.CourierID = cs.ServiceID
INNER JOIN Payment p ON c.CourierID = p.CourierID
WHERE p.Amount > cs.Cost;




