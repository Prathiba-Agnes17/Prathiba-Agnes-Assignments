CREATE TABLE Students (
    student_id INT IDENTITY(1,1) PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(15) NOT NULL
)


CREATE TABLE Teacher (
    teacher_id INT IDENTITY(1,1) PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
)


CREATE TABLE Courses (
    course_id INT IDENTITY(1,1) PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    credits INT NOT NULL CHECK (credits > 0),
    teacher_id INT,
    FOREIGN KEY (teacher_id) REFERENCES Teacher(teacher_id) ON DELETE SET NULL
)


CREATE TABLE Enrollments (
    enrollment_id INT IDENTITY(1,1) PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    enrollment_date DATE NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (student_id) REFERENCES Students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES Courses(course_id) ON DELETE CASCADE
)
select * from Enrollments


CREATE TABLE Payments (
    payment_id INT IDENTITY(1,1) PRIMARY KEY,
    student_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL CHECK (amount > 0),
    payment_date DATE NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (student_id) REFERENCES Students(student_id) ON DELETE CASCADE
)


INSERT INTO Teacher (first_name, last_name, email)
VALUES 
('Sarah', 'Smith', 'sarah.smith@example.com'),
('Daniel', 'Johnson', 'daniel.johnson@example.com'),
('Kevin', 'Miller', 'kevin.miller@example.com'),
('Lisa', 'Anderson', 'lisa.anderson@example.com'),
('Mark', 'Taylor', 'mark.taylor@example.com'),
('Helen', 'Mary', 'helen.mary@example.com'),
('Joash', 'Melvin', 'joash.melvin@example.com'),
('Riya', 'Kevin', 'riya.kevin@example.com'),
('Jack', 'Rose', 'jack.rose@example.com'),
('Antony', 'Leo', 'antony.leo@example.com')

INSERT INTO Courses (course_name, credits, teacher_id)
VALUES
('Introduction to Programming', 4, 1),
('Mathematics 101', 3, 2),
('Database Management', 3, 3),
('Computer Networks', 4, 4),
('Artificial Intelligence', 3, 5),
('Software Engineering', 4, 6),
('Cybersecurity Basics', 3, 7),
('Cloud Computing', 3, 8),
('Operating Systems', 4, 9),
('Machine Learning', 3, 10)

INSERT INTO Students (first_name, last_name, date_of_birth, email, phone_number)
VALUES
('John', 'Doe', '1995-08-15', 'john.doe@example.com', '1234567890'),
('Jane', 'Smith', '1998-05-20', 'jane.smith@example.com', '9876543210'),
('Michael', 'Brown', '2000-12-10', 'michael.brown@example.com', '1112223333'),
('Emily', 'Davis', '1999-07-25', 'emily.davis@example.com', '4445556666'),
('Robert', 'Wilson', '1997-03-18', 'robert.wilson@example.com', '7778889999'),
('Sarah', 'Johnson', '2001-11-05', 'sarah.johnson@example.com', '2223334444'),
('William', 'Clark', '1996-09-30', 'william.clark@example.com', '5556667777'),
('Olivia', 'White', '1994-04-22', 'olivia.white@example.com', '8889990000'),
('David', 'Martinez', '2002-06-12', 'david.martinez@example.com', '1231231234'),
('Sophia', 'Harris', '2003-02-08', 'sophia.harris@example.com', '9879879876')


INSERT INTO Enrollments (student_id, course_id, enrollment_date) 
VALUES
(1, 1, '2025-03-10'),
(2, 2, '2025-03-11'),
(3, 3, '2025-03-12'),
(4, 4, '2025-03-13'),
(5, 5, '2025-03-14'),
(6, 6, '2025-03-15'),
(7, 7, '2025-03-16'),
(8, 8, '2025-03-17'),
(9, 9, '2025-03-18'),
(10, 10, '2025-03-19')

INSERT INTO Payments (student_id, amount, payment_date) 
VALUES
(1, 500, '2025-03-20'),
(2, 600, '2025-03-21'),
(3, 700, '2025-03-22'),
(4, 800, '2025-03-23'),
(5, 900, '2025-03-24'),
(6, 1000, '2025-03-25'),
(7, 1100, '2025-03-26'),
(8, 1200, '2025-03-27'),
(9, 1300, '2025-03-28'),
(10, 1400, '2025-03-29')



--TASK 2--

--1. Write an SQL query to insert a new student into the "Students" table with the following details:  a. First Name: John b. Last Name: Doe c. Date of Birth: 1995-08-15  d. Email: john.doe@example.com  e. Phone Number: 1234567890 
INSERT INTO Students (first_name, last_name, date_of_birth, email, phone_number)
VALUES ('Leo', 'Dass', '1995-08-27', 'leo.dass@example.com', '1234667890');

select * from Enrollments

--2. Write an SQL query to enroll a student in a course. Choose an existing student and course and  insert a record into the "Enrollments" table with the enrollment date. 
INSERT INTO Enrollments (student_id, course_id, enrollment_date)
VALUES (1, 3, GETDATE());

--3. Update the email address of a specific teacher in the "Teacher" table. Choose any teacher and modify their email address. 
UPDATE Teacher 
SET email = 'sarah.smith@updated.com' 
WHERE teacher_id = 1;
select * from Teacher


--4. Write an SQL query to delete a specific enrollment record from the "Enrollments" table. Select an enrollment record based on the student and course. 
DELETE FROM Enrollments 
WHERE student_id = 1 AND course_id = 3;

Select * from Enrollments

--5. Update the "Courses" table to assign a specific teacher to a course. Choose any course and teacher from the respective tables. 
UPDATE Courses 
SET teacher_id = 2 
WHERE course_id = 5;
Select * from Courses


--6. Delete a specific student from the "Students" table and remove all their enrollment records from the "Enrollments" table. Be sure to maintain referential integrity. 
DELETE FROM Students WHERE student_id = 3;

select * from Enrollments

--7. Update the payment amount for a specific payment record in the "Payments" table. Choose any payment record and modify the payment amount. 
UPDATE Payments 
SET amount = 850 
WHERE payment_id = 4;

Select * from Payments

--TASK 3-- 
  
--1. Write an SQL query to calculate the total payments made by a specific student. You will need to join the "Payments" table with the "Students" table based on the student's ID. 
SELECT s.student_id, s.first_name, s.last_name, SUM(p.amount) AS total_payment
FROM Students s
JOIN Payments p ON s.student_id = p.student_id
WHERE s.student_id = 1
GROUP BY s.student_id, s.first_name, s.last_name

--2. Write an SQL query to retrieve a list of courses along with the count of students enrolled in each course. Use a JOIN operation between the "Courses" table and the "Enrollments" table.
SELECT c.course_name, COUNT(e.student_id) AS enrolled_students
FROM Courses c
LEFT JOIN Enrollments e ON c.course_id = e.course_id
GROUP BY c.course_name
ORDER BY enrolled_students DESC

--3. Write an SQL query to find the names of students who have not enrolled in any course. Use a LEFT JOIN between the "Students" table and the "Enrollments" table to identify students without enrollments. 
SELECT s.first_name, s.last_name
FROM Students s
LEFT JOIN Enrollments e ON s.student_id = e.student_id
WHERE e.student_id IS NULL;

--4. Write an SQL query to retrieve the first name, last name of students, and the names of the courses they are enrolled in. Use JOIN operations between the "Students" table and the "Enrollments" and "Courses" tables. 
SELECT s.first_name, s.last_name, c.course_name
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id
ORDER BY s.first_name, s.last_name

--5. Create a query to list the names of teachers and the courses they are assigned to. Join the "Teacher" table with the "Courses" table. 
SELECT t.first_name, t.last_name, c.course_name
FROM Teacher t
LEFT JOIN Courses c ON t.teacher_id = c.teacher_id
ORDER BY t.first_name, t.last_name

--6. Retrieve a list of students and their enrollment dates for a specific course. You'll need to join the "Students" table with the "Enrollments" and "Courses" tables. 
SELECT s.first_name, s.last_name, e.enrollment_date
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id
WHERE c.course_name = 'Database Management'
ORDER BY e.enrollment_date

--7. Find the names of students who have not made any payments. Use a LEFT JOIN between the "Students" table and the "Payments" table and filter for students with NULL payment records. 
SELECT s.first_name, s.last_name
FROM Students s
LEFT JOIN Payments p ON s.student_id = p.student_id
WHERE p.payment_id IS NULL;

--8. Write a query to identify courses that have no enrollments. You'll need to use a LEFT JOIN between the "Courses" table and the "Enrollments" table and filter for courses with NULL enrollment records. 
SELECT c.course_name
FROM Courses c
LEFT JOIN Enrollments e ON c.course_id = e.course_id
WHERE e.course_id IS NULL;
 
--9. Identify students who are enrolled in more than one course. Use a self-join on the "Enrollments" table to find students with multiple enrollment records. 
SELECT s.student_id, s.first_name, s.last_name, COUNT(e.course_id) AS total_courses
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
GROUP BY s.student_id, s.first_name, s.last_name
HAVING COUNT(e.course_id) > 1
ORDER BY total_courses DESC

--10. Find teachers who are not assigned to any courses. Use a LEFT JOIN between the "Teacher" table and the "Courses" table and filter for teachers with NULL course assignments. 
SELECT t.first_name, t.last_name
FROM Teacher t
LEFT JOIN Courses c ON t.teacher_id = c.teacher_id
WHERE c.course_id IS NULL




