CREATE TABLE Customers (
    customer_id INT IDENTITY(1,1) PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    DOB DATE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(15) UNIQUE NOT NULL,
    address VARCHAR(255) NOT NULL
)
CREATE TABLE Accounts (
    account_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT NOT NULL,
    account_type VARCHAR(20) CHECK (account_type IN ('savings', 'current', 'zero_balance')),
    balance DECIMAL(15,2) CHECK (balance >= 0) DEFAULT 0,
    CONSTRAINT FK_Accounts_Customers FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) ON DELETE CASCADE
)
CREATE TABLE Transactions (
    transaction_id INT IDENTITY(1,1) PRIMARY KEY,
    account_id INT NOT NULL,
    transaction_type VARCHAR(20) CHECK (transaction_type IN ('deposit', 'withdrawal', 'transfer')),
    amount DECIMAL(15,2) CHECK (amount > 0),
    transaction_date DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Transactions_Accounts FOREIGN KEY (account_id) REFERENCES Accounts(account_id) ON DELETE CASCADE
)

INSERT INTO Customers (first_name, last_name, DOB, email, phone_number, address) VALUES
('John', 'Doe', '1985-06-15', 'john.doe@example.com', '9876543210', '123 Main St, New York'),
('Jane', 'Smith', '1990-02-20', 'jane.smith@example.com', '9123456789', '456 Elm St, Los Angeles'),
('Robert', 'Brown', '1982-11-30', 'robert.brown@example.com', '9988776655', '789 Oak St, Chicago'),
('Emily', 'Davis', '1995-07-10', 'emily.davis@example.com', '9871234567', '101 Pine St, Houston'),
('Michael', 'Wilson', '1988-09-05', 'michael.wilson@example.com', '9123987654', '222 Cedar St, Phoenix'),
('Emma', 'Taylor', '1993-12-15', 'emma.taylor@example.com', '9898989898', '333 Birch St, Philadelphia'),
('David', 'Anderson', '1980-04-25', 'david.anderson@example.com', '9777888999', '444 Walnut St, Dallas'),
('Sophia', 'Martinez', '1996-01-18', 'sophia.martinez@example.com', '9556677888', '555 Maple St, San Diego'),
('Daniel', 'Hernandez', '1987-03-22', 'daniel.hernandez@example.com', '9445566777', '666 Chestnut St, San Antonio'),
('Olivia', 'Lopez', '1999-08-11', 'olivia.lopez@example.com', '9334455666', '777 Redwood St, San Francisco')
select * from Accounts;

INSERT INTO Accounts (customer_id, account_type, balance) VALUES
(1, 'savings', 5000.00),
(2, 'current', 12000.50),
(3, 'zero_balance', 0.00),
(4, 'savings', 7500.75),
(5, 'current', 20000.00),
(6, 'savings', 6400.60),
(7, 'zero_balance', 0.00),
(8, 'current', 15500.25),
(9, 'savings', 8200.90),
(10, 'zero_balance', 0.00)

INSERT INTO Transactions (account_id, transaction_type, amount, transaction_date) VALUES
(1, 'deposit', 2000.00, '2025-03-01 10:00:00'),
(1, 'withdrawal', 500.00, '2025-03-02 12:30:00'),
(2, 'deposit', 5000.00, '2025-03-03 09:15:00'),
(3, 'deposit', 3000.00, '2025-03-04 14:00:00'),
(4, 'withdrawal', 1200.00, '2025-03-05 16:45:00'),
(5, 'transfer', 2500.00, '2025-03-06 11:20:00'),
(6, 'deposit', 700.00, '2025-03-07 18:10:00'),
(7, 'withdrawal', 300.00, '2025-03-08 13:30:00'),
(8, 'transfer', 900.00, '2025-03-09 15:55:00'),
(9, 'deposit', 4500.00, '2025-03-10 08:20:00'),
(10, 'deposit', 1000.00, '2025-03-11 10:00:00')  

--TASK 2--
 
--1. Write a SQL query to retrieve the name, account type and email of all customers. 
SELECT c.first_name, c.last_name, a.account_type, c.email
FROM Customers c
JOIN Accounts a ON c.customer_id = a.customer_id;

--2. Write a SQL query to list all transaction corresponding customer. 
SELECT c.first_name, c.last_name, t.transaction_type, t.amount, t.transaction_date
FROM Transactions t
JOIN Accounts a ON t.account_id = a.account_id
JOIN Customers c ON a.customer_id = c.customer_id;

--3. Write a SQL query to increase the balance of a specific account by a certain amount. 
UPDATE Accounts
SET balance = balance + 500 
WHERE account_id = 2;  
SELECT * from Accounts

--4. Write a SQL query to Combine first and last names of customers as a full_name. 
SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM Customers;

--5. Write a SQL query to remove accounts with a balance of zero where the account type is savings. 
DELETE FROM Accounts
WHERE balance = 0 AND account_type = 'savings';

--6. Write a SQL query to Find customers living in a specific city. 
SELECT * FROM Customers
WHERE address LIKE '%New York%';

--7. Write a SQL query to Get the account balance for a specific account.
SELECT balance 
FROM Accounts
WHERE account_id = 1;  

--8. Write a SQL query to List all current accounts with a balance greater than $1,000. 
SELECT * FROM Accounts
WHERE account_type = 'current' AND balance > 1000;

--9. Write a SQL query to Retrieve all transactions for a specific account. 
SELECT * FROM Transactions
WHERE account_id = 1;  

--10. Write a SQL query to Calculate the interest accrued on savings accounts based on a given interest rate. 
SELECT account_id, balance, (balance * 0.05) AS interest_accrued  
FROM Accounts
WHERE account_type = 'savings';

--11. Write a SQL query to Identify accounts where the balance is less than a specified overdraft limit. 
SELECT * FROM Accounts
WHERE balance < -500;  

--12. Write a SQL query to Find customers not living in a specific city.
SELECT * FROM Customers
WHERE address NOT LIKE '%New York%';

--TASK3--

--Tasks 3--
--1. Write a SQL query to Find the average account balance for all customers.  
SELECT AVG(balance) AS average_balance
FROM Accounts;

--2. Write a SQL query to Retrieve the top 10 highest account balances.  
SELECT TOP 10 * FROM Accounts
ORDER BY balance DESC;

--3. Write a SQL query to Calculate Total Deposits for All Customers in specific date.
SELECT SUM(amount) AS total_deposits
FROM Transactions
WHERE transaction_type = 'deposit' 
AND CAST(transaction_date AS DATE) = '2025-03-10';  

--4. Write a SQL query to Find the Oldest and Newest Customers. 
select top 1 first_name as oldestCustomer from Customers
order by DOB asc
select top 1 first_name as newestCustomers from Customers
order by DOB desc

--5. Write a SQL query to Retrieve transaction details along with the account type.
SELECT t.transaction_id, t.account_id, t.transaction_type, t.amount, t.transaction_date, a.account_type
FROM Transactions t
JOIN Accounts a ON t.account_id = a.account_id;

--6. Write a SQL query to Get a list of customers along with their account details. 
SELECT c.customer_id, c.first_name, c.last_name, c.email, a.account_id, a.account_type, a.balance
FROM Customers c
JOIN Accounts a ON c.customer_id = a.customer_id;

--7. Write a SQL query to Retrieve transaction details along with customer information for a specific account.
SELECT c.customer_id, c.first_name, c.last_name, t.transaction_id, t.transaction_type, t.amount, t.transaction_date
FROM Transactions t
JOIN Accounts a ON t.account_id = a.account_id
JOIN Customers c ON a.customer_id = c.customer_id
WHERE t.account_id = 2;  

--8. Write a SQL query to Identify customers who have more than one account. 
SELECT customer_id, COUNT(account_id) AS account_count
FROM Accounts
GROUP BY customer_id
HAVING COUNT(account_id) > 1;

--9. Write a SQL query to Calculate the difference in transaction amounts between deposits and withdrawals. 
SELECT 
    account_id, 
    SUM(CASE WHEN transaction_type = 'deposit' THEN amount ELSE 0 END) AS total_deposits,
    SUM(CASE WHEN transaction_type = 'withdrawal' THEN amount ELSE 0 END) AS total_withdrawals,
    (SUM(CASE WHEN transaction_type = 'deposit' THEN amount ELSE 0 END) -
     SUM(CASE WHEN transaction_type = 'withdrawal' THEN amount ELSE 0 END)) AS difference
FROM Transactions
GROUP BY account_id;

--10. Write a SQL query to Calculate the average daily balance for each account over a specified period.
SELECT account_id, AVG(balance) AS avg_daily_balance
FROM Accounts
WHERE account_id IN (SELECT DISTINCT account_id FROM Transactions)  
AND balance > 0
GROUP BY account_id;

--11. Calculate the total balance for each account type.
SELECT account_type, SUM(balance) AS total_balance
FROM Accounts
GROUP BY account_type;

--12. Identify accounts with the highest number of transactions order by descending order. 
SELECT account_id, COUNT(transaction_id) AS transaction_count
FROM Transactions
GROUP BY account_id
ORDER BY transaction_count DESC;

--13. List customers with high aggregate account balances, along with their account types. 
SELECT c.customer_id, c.first_name, c.last_name, a.account_type, SUM(a.balance) AS total_balance
FROM Customers c
JOIN Accounts a ON c.customer_id = a.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name, a.account_type
HAVING SUM(a.balance) > 5000;  

--14. Identify and list duplicate transactions based on transaction amount, date, and account. 
SELECT account_id, transaction_type, amount, transaction_date, COUNT(*) AS duplicate_count
FROM Transactions
GROUP BY account_id, transaction_type, amount, transaction_date
HAVING COUNT(*) > 1;

--TASKS 4--

--1. Retrieve the customer(s) with the highest account balance. 
SELECT c.customer_id, c.first_name, c.last_name, a.account_id, a.balance
FROM Customers c
JOIN Accounts a ON c.customer_id = a.customer_id
WHERE a.balance = (SELECT MAX(balance) FROM Accounts);

--2. Calculate the average account balance for customers who have more than one account. 
SELECT AVG(balance) AS avg_balance
FROM Accounts
WHERE customer_id IN (
    SELECT customer_id 
    FROM Accounts 
    GROUP BY customer_id 
    HAVING COUNT(account_id) > 1
);

--3. Retrieve accounts with transactions whose amounts exceed the average transaction amount. 
SELECT * FROM Transactions
WHERE amount > (SELECT AVG(amount) FROM Transactions);

--4. Identify customers who have no recorded transactions. 
SELECT * FROM Customers
WHERE customer_id NOT IN (
    SELECT DISTINCT a.customer_id 
    FROM Accounts a 
    JOIN Transactions t ON a.account_id = t.account_id
);

--5. Calculate the total balance of accounts with no recorded transactions. 
SELECT SUM(balance) AS total_balance
FROM Accounts
WHERE account_id NOT IN (SELECT DISTINCT account_id FROM Transactions);

--6. Retrieve transactions for accounts with the lowest balance. 
SELECT * FROM Transactions
WHERE account_id IN (
    SELECT account_id 
    FROM Accounts 
    WHERE balance = (SELECT MIN(balance) FROM Accounts)
);

--7. Identify customers who have accounts of multiple types. 
SELECT customer_id
FROM Accounts
GROUP BY customer_id
HAVING COUNT(DISTINCT account_type) > 1;

--8. Calculate the percentage of each account type out of the total number of accounts. 
SELECT account_type, 
       COUNT(*) AS account_count, 
       (COUNT(*) * 100.0) / (SELECT COUNT(*) FROM Accounts) AS percentage
FROM Accounts
GROUP BY account_type;

--9. Retrieve all transactions for a customer with a given customer_id. 
SELECT t.*
FROM Transactions t
JOIN Accounts a ON t.account_id = a.account_id
WHERE a.customer_id = 1;  

--10. Calculate the total balance for each account type, including a subquery within the SELECT clause.
SELECT account_type, 
       (SELECT SUM(balance) FROM Accounts a2 WHERE a2.account_type = a1.account_type) AS total_balance
FROM Accounts a1
GROUP BY account_type;







