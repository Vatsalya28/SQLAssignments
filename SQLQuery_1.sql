CREATE TABLE Students (
student_id INT PRIMARY KEY,
first_name VARCHAR(50),
last_name VARCHAR(50),
date_of_birth DATE,
email VARCHAR(100),
phone_number VARCHAR(20)
)

CREATE TABLE Courses (course_id INT PRIMARY KEY,
course_name VARCHAR(100),credits INT,teacher_id INT,FOREIGN KEY (teacher_id) REFERENCES Teacher(teacher_id))


CREATE TABLE Enrollments (enrollment_id INT PRIMARY KEY,student_id INT,course_id INT,enrollment_date DATE,FOREIGN KEY (student_id) REFERENCES Students(student_id),
FOREIGN KEY (course_id) REFERENCES Courses(course_id))


CREATE TABLE Teacher (
teacher_id INT PRIMARY KEY,
first_name VARCHAR(50),
last_name VARCHAR(50),
email VARCHAR(100)
)

CREATE TABLE Payments (
payment_id INT PRIMARY KEY,student_id INT,amount DECIMAL(10, 2),payment_date DATE,FOREIGN KEY (student_id) REFERENCES Students(student_id))



----Insert Values

INSERT INTO Students (student_id, first_name, last_name, date_of_birth, email, phone_number)
VALUES(1, 'Vatsalya', 'Baghel', '2000-10-28', 'vsbdoon@yahoo.com', '12345'),(2, 'Lionel', 'Messi', '1998-07-2', 'messi@gmail.com', '98210'),
(3, 'Neymar', 'Jr', '2000-11-28', 'neymar@yahoo.com', '45345'),(4, 'Cris', 'Ronaldo', '1998-04-26', 'ronaldo@gmail.com', '982170'),
(5, 'Kylian', 'Mbappe', '2001-09-2', 'mbappe@yahoo.com', '1267345'),(6, 'Erling', 'Halland', '1956-07-11', 'halland@gmail.com', '12210'),
(7, 'Diego', 'Maradona', '1981-09-1', 'mara@yahoo.com', '123495'),(8, 'Karim', 'Benzema', '1998-07-2', 'benzema@gmail.com', '18210'),
(9, 'Marcus', 'Rashford', '1999-09-15', 'marcus@yahoo.com', '93495'),(10, 'Angel', 'Dimaria', '2000-07-2', 'dimaria@gmail.com', '18210')

INSERT INTO Courses (course_id, course_name, credits, teacher_id) VALUES
(101, 'Introduction to Computer Science', 3, 1),(102, 'Data Structures', 4, 2),(103, 'Database Management', 3, 3),(104, 'Algorithm Design', 4, 1),
(105, 'Web Development', 3, 2),(106, 'Operating Systems', 4, 3)

INSERT INTO Enrollments (enrollment_id, student_id, course_id, enrollment_date) VALUES
(1, 1, 101, '2023-01-05'),(2, 2, 102, '2023-02-10'),(3, 3, 103, '2023-03-15'),(4, 4, 104, '2023-04-20'),(5, 5, 105, '2023-05-25'),
(6, 6, 101, '2023-06-30'),(7, 7, 102, '2023-07-05'),(8, 8, 103, '2023-08-10'),(9, 9, 105, '2023-09-15'),(10, 10, 106, '2023-10-20')

INSERT INTO Teacher (teacher_id, first_name, last_name, email) VALUES
(1, 'Rohit', 'Sharma', 'rohit@gmail.com'),(2, 'Virat', 'Kohli', 'virat@gmail.com'),(3, 'MS', 'Dhoni', 'dhoni@gmail.com'),
(4, 'Glen', 'Maxwell', 'maxwell@gmail.com'),(5, 'Steve', 'Smith', 'smith@gmail.com'),(6, 'H', 'Smith', 'smith@email.com'),
(7, 'shubhman', 'gill', 'gill@email.com'),(8, 'Lautaro', 'Martinez', 'martinez@email.com'),(9, 'Captain', 'Miller', 'miller@email.com'),
(10, 'Ross', 'Taylor', 'taylor@email.com')

INSERT INTO Payments (payment_id, student_id, amount, payment_date) VALUES
(1, 1, 500.00, '2023-03-01'),(2, 2, 750.50, '2023-03-05'),(3, 3, 600.25, '2023-03-10'),(4, 4, 900.75, '2023-03-15'),
(5, 5, 400.50, '2023-03-20'),(6, 6, 550.00, '2023-03-25'),(7, 7, 800.25, '2023-03-30'),(8, 8, 350.75, '2023-04-01'),
(9, 9, 700.00, '2023-04-05'),(10, 10, 950.50, '2023-04-10')


----1.Write an SQL query to insert a new student into the "Students" table with the following details:
--a. First Name: John
--b. Last Name: Doe
--c. Date of Birth: 1995-08-15
--d. Email: john.doe@example.com
--e. Phone Number: 1234567890

insert into Students(student_id,first_name,last_name,date_of_birth,email,phone_number)VALUES
(11,'John','Doe','1995-08-15','john.doe@example.com','1234567890')

---2.Write an SQL query to enroll a student in a course. Choose an existing student and course and
---insert a record into the "Enrollments" table with the enrollment date.
select * from Enrollments
INSERT into Enrollments values(11,1,104,'2023-09-17')

--3.Update the email address of a specific teacher in the "Teacher" table. Choose any teacher andmodify their email address.
select * from Teacher

UPDATE Teacher
set email='sharma@yahoo.com'
where teacher_id=1

----

----4.Write an SQL query to delete a specific enrollment record from the "Enrollments" table. Select an enrollment record based on student and course.
SELECT * FROM Enrollments

DELETE Enrollments
where enrollment_id=2

----5.Update the "Courses" table to assign a specific teacher to a course. Choose any course and
--teacher from the respective tables.
SELECT * from Courses
UPDATE Courses
set teacher_id=5
where course_id=106

----6. Delete a specific student from the "Students" table and remove all their enrollment records
--from the "Enrollments" table. Be sure to maintain referential integrity.

select * from Students

alter table Enrollments

add CONSTRAINT fk_enrollments_students  FOREIGN KEY (student_id) REFERENCES Students(student_id) on DELETE
CASCADE

alter table  Payments
ADD CONSTRAINT fk_payments_students FOREIGN KEY (student_id) REFERENCES Students(student_id) on DELETE CASCADE

DELETE Students
where student_id=4
----7. Update the payment amount for a specific payment record in the "Payments" table. Choose any
---payment record and modify the payment amount.
SELECT * from Payments
UPDATE Payments
set amount=400
where payment_id=2
--------1 Write an SQL query to calculate the total payments made by a specific student. You will need to join the "Payments" table with the "Students" table based on the student's ID.

SELECT * FROM Students
Select * from Payments

SELECT s.student_id,s.first_name,s.last_name,sum(p.amount) as total from Students s
 join Payments p on s.student_id=p.student_id group by s.student_id,s.first_name,s.last_name

----2 Write an SQL query to retrieve a list of courses along with the count of students enrolled in eachcourse. 

SELECT * from Courses
SELECT * from Enrollments
SELECT c.course_id,c.course_name,count(e.enrollment_id) as totalStudents from Courses c 
join Enrollments e on c.course_id=e.course_id
GROUP by c.course_id,c.course_name

select c.course_id,c.course_name ,
(select count(e.enrollment_id) from Enrollments e where c.course_id=e.course_id)
from Courses c

----Write an SQL query to find the names of students who have not enrolled in any course.
select * from Students
select * from Enrollments

select s.first_name,s.last_name from Students s 
left join Enrollments e on s.student_id=e.student_id
where e.student_id is NULL

select s.first_name,s.last_name from Students s 
WHERE s.student_id not in(select student_id from Enrollments)

----Write an SQL query to retrieve the first name, last name of students, and the names of the courses they are enrolled in

SELECT s.first_name,s.last_name,c.course_id,c.course_name from Students s 
join Enrollments e on s.student_id=e.student_id
join Courses c on e.course_id=c.course_id

---5 Create a query to list the names of teachers and the courses they are assigned to.
select* from Teacher
SELECT * from Courses
select t.first_name,t.last_name,c.course_name from Teacher t 
join Courses c on t.teacher_id=c.teacher_id

----6 Retrieve a list of students and their enrollment dates for a specific course.
SELECT * from Students
select * from Enrollments

select s.first_name,s.last_name,e.enrollment_date,c.course_name from Students s
join Enrollments e on s.student_id=e.student_id
join Courses c on e.course_id=c.course_id

----Find the names of students who have not made any payments.
SELECT * from Payments

select s.first_name,s.last_name from Students s 
left join Payments p on s.student_id=p.student_id
where p.student_id is null

select s.first_name,s.last_name from Students s where student_id not in (select student_id from Payments)

----8 Write a query to identify courses that have no enrollments. 
select * from Enrollments
SELECT * from Courses


 select c.course_id,c.course_name from Courses c 
 left join Enrollments e on c.course_id=e.course_id
 where e.course_id is  NULL

--- 9 Identify students who are enrolled in more than one course.
select s.first_name,s.last_name ,count(e.student_id)as total from Students s 
join Enrollments e on s.student_id =e.student_id
GROUP BY s.first_name,s.last_name
HAVING COUNT(e.student_id)>1


----Find teachers who are not assigned to any courses.
select * from Teacher
SELECT * from Courses
SELECT t.first_name,t.last_name from Teacher t 
left join Courses c on t.teacher_id=c.teacher_id
where c.teacher_id is null

---Write an SQL query to calculate the average number of students enrolled in each course.

select c.course_id,c.course_name,avg(stu_count) as aver
from Courses c
left join (select e.course_id,count(e.student_id) as stu_count
from Enrollments e group by e.course_id)as stu_counts on c.course_id=c.course_id
GROUP by c.course_id,c.course_name

----Identify the student(s) who made the highest payment.
select * from Payments

SELECT top 1 s.first_name,s.last_name,sum(p.amount) 
from Students s 
join Payments p on p.student_id=s.student_id
GROUP BY s.first_name,s.last_name
ORDER by sum(p.amount) desc

---Retrieve a list of courses with the highest number of enrollments.
select * from  Enrollments

SELECT  top 1 with ties c.course_id,c.course_name,count(e.enrollment_id) totalEnrolls from Courses c
join Enrollments e on c.course_id =e.course_id
GROUP by c.course_id,c.course_name
ORDER by totalEnrolls desc

----4.Calculate the total payments made to courses taught by each teacher.

select * from Enrollments
select* from Payments
select * from Teacher
select * from Courses

select t.teacher_id, t.first_name,t.last_name,c.course_name,sum(p.amount) as totalAmount
from Courses c join Teacher t on t.teacher_id=c.teacher_id
join Enrollments e on c.course_id=e.course_id
join Payments p on e.student_id=p.student_id
GROUP by t.teacher_id,t.first_name,t.last_name,c.course_name

--Identify students who are enrolled in all available courses.
SELECT * from Students
SELECT * from Enrollments

SELECT s.first_name,s.last_name from Students s where  student_id in(select student_id from Enrollments e
where s.student_id=e.student_id)

--Retrieve the names of teachers who have not been assigned to any courses.
SELECT t.first_name,t.last_name from Teacher t where teacher_id not in(select c.teacher_id from Courses c)

---Calculate the average age of all students. 
SELECT * from Students
select avg(DATEDIFF(YEAR,date_of_birth,GETDATE())) from Students

----Identify courses with no enrollments.
select c.course_id,c.course_name from Courses c where course_id not in (select course_id from Enrollments )

---Calculate the total payments made by each student for each course they are enrolled in.
select * from Students
select * from Enrollments
select * from Courses
SELECT * from Payments

select distinct s.student_id,s.first_name,s.last_name,count(p.amount) from Students s 
join Enrollments e on s.student_id=e.student_id

 join Payments p on s.student_id=p.student_id
GROUP by s.student_id,s.first_name,s.last_name

---Identify students who have made more than one payment. 
select s.student_id,s.first_name,s.last_name,count(p.payment_id) from Students s
join Payments p on s.student_id=p.student_id
GROUP by s.student_id,s.first_name,s.last_name
HAVING count(p.payment_id)>1

