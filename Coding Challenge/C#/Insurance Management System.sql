-- 1. User Table
CREATE TABLE Users (
    UserId INT PRIMARY KEY,
    Username VARCHAR(50) NOT NULL,
    Password VARCHAR(50) NOT NULL,
    Role VARCHAR(30) NOT NULL);

-- 2. Policy Table
CREATE TABLE Policy (
    PolicyId INT PRIMARY KEY,
    PolicyName VARCHAR(100) NOT NULL,
    PolicyType VARCHAR(50),
    PremiumAmount DECIMAL(10,2),
    CoverageDetails VARCHAR(255));

-- 3. Client Table
CREATE TABLE Client (
    ClientId INT PRIMARY KEY,
    ClientName VARCHAR(100) NOT NULL,
    ContactInfo VARCHAR(100),
    PolicyId INT FOREIGN KEY REFERENCES Policy(PolicyId));

-- 4. Claim Table
CREATE TABLE Claim (
    ClaimId INT PRIMARY KEY,
    ClaimNumber VARCHAR(50) NOT NULL,
    DateFiled DATE,
    ClaimAmount DECIMAL(10,2),
    Status VARCHAR(30),
    PolicyId INT FOREIGN KEY REFERENCES Policy(PolicyId),
    ClientId INT FOREIGN KEY REFERENCES Client(ClientId));

-- 5. Payment Table
CREATE TABLE Payment (
    PaymentId INT PRIMARY KEY,
    PaymentDate DATE,
    PaymentAmount DECIMAL(10,2),
    ClientId INT FOREIGN KEY REFERENCES Client(ClientId));



INSERT INTO Users VALUES
(1, 'riya123', 'passRiya', 'Admin'),
(2, 'madhu88', 'madhuPwd', 'Client'),
(3, 'ganesh12', 'ganeshPwd', 'Client'),
(4, 'melvin34', 'melvinPwd', 'Client'),
(5, 'agnes99', 'agnesPwd', 'Admin'),
(6, 'priya56', 'priyaPwd', 'Client'),
(7, 'pavi22', 'paviPwd', 'Client'),
(8, 'suriya77', 'suriyaPwd', 'Client'),
(9, 'nancy101', 'nancyPwd', 'Client'),
(10, 'akif09', 'akifPwd', 'Client');

INSERT INTO Policy VALUES
(101, 'Health Secure', 'Health', 5000.00, 'Covers hospitalization and emergency services'),
(102, 'Life Shield', 'Life', 8000.00, 'Covers death and disability'),
(103, 'Travel Easy', 'Travel', 3000.00, 'Covers travel-related emergencies'),
(104, 'Home Safe', 'Property', 6000.00, 'Covers home damage due to disasters'),
(105, 'Vehicle Protect', 'Auto', 4500.00, 'Covers vehicle damage and theft'),
(106, 'Health Pro', 'Health', 5200.00, 'Premium coverage with added benefits'),
(107, 'Senior Life', 'Life', 7500.00, 'Life coverage for seniors'),
(108, 'Trip Guard', 'Travel', 3200.00, 'Flight and luggage protection'),
(109, 'Smart Home', 'Property', 6800.00, 'Advanced home insurance'),
(110, 'Auto Plus', 'Auto', 4700.00, 'Extended auto insurance');

INSERT INTO Client VALUES
(1, 'Riya', 'riya@mail.com', 101),
(2, 'Madhu', 'madhu@mail.com', 102),
(3, 'Ganesh', 'ganesh@mail.com', 103),
(4, 'Melvin', 'melvin@mail.com', 104),
(5, 'Agnes', 'agnes@mail.com', 105),
(6, 'Priya', 'priya@mail.com', 106),
(7, 'Pavi', 'pavi@mail.com', 107),
(8, 'Suriya', 'suriya@mail.com', 108),
(9, 'Nancy', 'nancy@mail.com', 109),
(10, 'Akif', 'akif@mail.com', 110);

INSERT INTO Claim VALUES
(201, 'CLM1001', '2023-01-15', 20000.00, 'Approved', 101, 1),
(202, 'CLM1002', '2023-02-18', 15000.00, 'Pending', 102, 2),
(203, 'CLM1003', '2023-03-10', 5000.00, 'Rejected', 103, 3),
(204, 'CLM1004', '2023-04-05', 10000.00, 'Approved', 104, 4),
(205, 'CLM1005', '2023-05-20', 25000.00, 'Pending', 105, 5),
(206, 'CLM1006', '2023-06-15', 8000.00, 'Approved', 106, 6),
(207, 'CLM1007', '2023-07-22', 12000.00, 'Rejected', 107, 7),
(208, 'CLM1008', '2023-08-30', 3000.00, 'Approved', 108, 8),
(209, 'CLM1009', '2023-09-12', 17000.00, 'Pending', 109, 9),
(210, 'CLM1010', '2023-10-01', 14000.00, 'Approved', 110, 10);

INSERT INTO Payment VALUES
(301, '2023-01-10', 5000.00, 1),
(302, '2023-02-12', 8000.00, 2),
(303, '2023-03-08', 3000.00, 3),
(304, '2023-04-01', 6000.00, 4),
(305, '2023-05-18', 4500.00, 5),
(306, '2023-06-10', 5200.00, 6),
(307, '2023-07-05', 7500.00, 7),
(308, '2023-08-25', 3200.00, 8),
(309, '2023-09-10', 6800.00, 9),
(310, '2023-10-05', 4700.00, 10);

select * from Users;
select * from Policy;
select * from Client;
select * from Claim;
select * from Payment;

