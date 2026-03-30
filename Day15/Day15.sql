create database student;
USE student;
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50),
    gender VARCHAR(10),
    city VARCHAR(50),
    join_year INT
);
CREATE TABLE courses (
    course_id INT PRIMARY KEY, 
    course_name VARCHAR(100), 
    department VARCHAR(50) 
);
CREATE TABLE marks (
    mark_id INT PRIMARY KEY,
    student_id INT, 
    course_id INT, 
    marks INT, 
    FOREIGN KEY (student_id) REFERENCES students(student_id), 
    FOREIGN KEY (course_id) REFERENCES courses(course_id) 
);
INSERT INTO students (student_id, student_name, gender, city, join_year) VALUES
(1, 'Anu', 'F', 'Tumakuru', 2024),
(2, 'Ravi', 'M', 'Bengaluru', 2023),
(3, 'Kiran', 'M', 'Tumakuru', 2024),
(4, 'Sneha', 'F', 'Mysuru', 2023),
(5, 'Manu', 'M', 'Tumakuru', 2022); 

select*from students;
INSERT INTO courses (course_id, course_name, department) VALUES
(101, 'SQL Basics', 'Computer Science'),
(102, 'Excel for Analysts', 'Commerce'),
(103, 'Statistics', 'Mathematics'); 

select*from courses;

INSERT INTO marks (mark_id, student_id, course_id, marks) VALUES
(1, 1, 101, 85), (2, 2, 101, 72), (3, 3, 101, 90),
(4, 4, 102, 88), (5, 5, 103, 67), (6, 1, 103, 79),
(7, 2, 102, 81);

SELECT * FROM students;

SELECT student_name, city FROM students;

SELECT * FROM courses;

SELECT * FROM students WHERE city = 'Tumakuru';

SELECT * FROM students WHERE join_year = 2024;

SELECT * FROM students WHERE gender = 'F';

SELECT * FROM marks WHERE marks > 80;

SELECT course_name FROM courses WHERE department = 'Commerce';

SELECT * FROM students WHERE city <> 'Bengaluru';

SELECT * FROM marks WHERE marks BETWEEN 70 AND 90;

SELECT * FROM marks ORDER BY marks DESC;

SELECT * FROM students ORDER BY student_name ASC;

SELECT * FROM students ORDER BY join_year DESC;

SELECT COUNT(*) FROM students;

SELECT AVG(marks) FROM marks;

SELECT MAX(marks) FROM marks;

SELECT MIN(marks) FROM marks;

SELECT SUM(marks) FROM marks;


