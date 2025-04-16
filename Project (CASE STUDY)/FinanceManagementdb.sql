CREATE TABLE Users (
    user_id INT PRIMARY KEY IDENTITY(1,1),
    username VARCHAR(50) NOT NULL,
    password VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL
);
CREATE TABLE ExpenseCategories (
    category_id INT PRIMARY KEY IDENTITY(1,1),
    category_name VARCHAR(50) NOT NULL
);
CREATE TABLE Expenses (
    expense_id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    category_id INT NOT NULL,
    date DATE NOT NULL,
    description VARCHAR(255),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (category_id) REFERENCES ExpenseCategories(category_id)
);

INSERT INTO Users (username, password, email) VALUES
('prathiba', 'pass123', 'prathiba@mail.com'),
('john_doe', 'john2023', 'john_doe@mail.com'),
('alice', 'alice123', 'alice@mail.com'),
('bob', 'bobpass', 'bob@mail.com'),
('susan', 'susan2023', 'susan@mail.com'),
('mike', 'mike123', 'mike@mail.com'),
('emma', 'emma321', 'emma@mail.com'),
('ryan', 'ryan789', 'ryan@mail.com'),
('lara', 'lara999', 'lara@mail.com'),
('james', 'james007', 'james@mail.com');

INSERT INTO ExpenseCategories (category_name) VALUES
('Food'),
('Transportation'),
('Utilities'),
('Entertainment'),
('Healthcare'),
('Education'),
('Shopping'),
('Rent'),
('Travel'),
('Miscellaneous');


INSERT INTO Expenses (user_id, amount, category_id, date, description) VALUES
(1, 500.00, 1, '2023-11-15', 'Groceries at local market'),
(2, 120.00, 2, '2023-11-20', 'Uber ride to office'),
(3, 350.00, 3, '2023-11-22', 'Electricity bill'),
(1, 200.00, 4, '2023-11-25', 'Movie night'),
(5, 1000.00, 5, '2023-11-10', 'Doctor appointment'),
(2, 1500.00, 6, '2023-10-05', 'Course fee'),
(4, 700.00, 7, '2023-10-09', 'Clothes shopping'),
(6, 10000.00, 8, '2023-10-01', 'Monthly rent'),
(1, 2500.00, 9, '2023-09-15', 'Trip to Ooty'),
(7, 300.00, 10, '2023-11-18', 'Birthday gift');


SELECT * FROM Users;
SELECT * FROM ExpenseCategories;
SELECT * FROM Expenses;



SELECT name
FROM sys.foreign_keys
WHERE parent_object_id = OBJECT_ID('Expenses');

ALTER TABLE Expenses DROP CONSTRAINT FK_Expenses_user_i_5535A963;
ALTER TABLE Expenses DROP CONSTRAINT FK_Expenses_catego_5629CD9C;

ALTER TABLE Expenses
ADD CONSTRAINT FK_Expenses_Users
FOREIGN KEY (user_id) REFERENCES Users(user_id)
ON DELETE CASCADE;


ALTER TABLE Expenses
ADD CONSTRAINT FK_Expenses_Categories
FOREIGN KEY (category_id) REFERENCES ExpenseCategories(category_id)
ON DELETE CASCADE;


DBCC CHECKIDENT ('Users', RESEED, 10);
DBCC CHECKIDENT ('Expenses', RESEED, 10);
