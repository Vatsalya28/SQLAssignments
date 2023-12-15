--Venu Table
CREATE TABLE Venue (
venue_id INT PRIMARY KEY,
venue_name VARCHAR(255),
address VARCHAR(255)
)

--Event Table
CREATE TABLE Event (
event_id INT PRIMARY KEY,
event_name VARCHAR(255),
event_date DATE,
event_time TIME,
venue_id INT,
total_seats INT,
available_seats INT,
ticket_price DECIMAL,
event_type VARCHAR(50),
booking_id INT
)

--Customer Table
CREATE TABLE Customer (
customer_id INT PRIMARY KEY,
customer_name VARCHAR(255),
email VARCHAR(255),
phone_number VARCHAR(20),
booking_id INT
)

--Booking Table
CREATE TABLE Booking (
booking_id INT PRIMARY KEY,
customer_id INT,
event_id INT,
num_tickets INT,
total_cost DECIMAL,
booking_date DATE
)


ALTER TABLE Event
ADD FOREIGN KEY (booking_id) REFERENCES Booking(booking_id)

ALTER TABLE Customer
ADD FOREIGN KEY (booking_id) REFERENCES Booking(booking_id)

ALTER TABLE Booking
ADD FOREIGN KEY (event_id) REFERENCES Event(event_id)
---

--
INSERT INTO Venue (venue_id, venue_name, address)
VALUES (2, 'Example Venue', '123 Main Street')


INSERT INTO Event (event_id, event_name, event_date, event_time, venue_id, total_seats, available_seats, ticket_price, event_type, booking_id)
VALUES (1, 'Example Event', '2023-12-06', '18:00:00', 1, 100, 100, 20.00, 'Concert', NULL)


INSERT INTO Customer (customer_id, customer_name, email, phone_number, booking_id)
VALUES (1, 'John Doe', 'john@example.com', '123-456-7890', NULL)


INSERT INTO Booking (booking_id, customer_id, event_id, num_tickets, total_cost, booking_date)
VALUES (1, 1, 1, 2, 40.00, '2023-12-06')



INSERT INTO Venue (venue_id, venue_name, address)
VALUES(3, 'Conference Hall', '789 Maple Avenue'),
(4, 'Outdoor Stadium', '101 Pine Lane'),
(5, 'Theater Complex', '202 Cedar Road'),
(6, 'Community Center', '303 Elm Boulevard'),
(7, 'Rooftop Lounge', '404 Birch Street')


INSERT INTO Event (event_id, event_name, event_date, event_time, venue_id, total_seats, available_seats, ticket_price, event_type, booking_id)
VALUES 
(2, 'Another Event', '2023-12-10', '19:30:00', 2, 150, 150, 25.00, 'Conference', NULL),
(3, 'Outdoor Concert', '2023-12-15', '20:00:00', 4, 200, 200, 30.00, 'Concert', NULL),
(4, 'Play Premiere', '2023-12-20', '18:30:00', 5, 80, 80, 15.00, 'Theater', NULL),
(5, 'Community Workshop', '2023-12-25', '10:00:00', 6, 50, 50, 10.00, 'Workshop', NULL)
   


INSERT INTO Customer (customer_id, customer_name, email, phone_number, booking_id)
VALUES 
(2, 'Jane Smith', 'jane@example.com', '987-654-3210', NULL),
(3, 'Bob Johnson', 'bob@example.com', '555-123-4567', NULL),
(4, 'Alice Brown', 'alice@example.com', '111-222-3333', NULL),
(5, 'Charlie Wilson', 'charlie@example.com', '999-888-7777', NULL),
(6, 'Eva White', 'eva@example.com', '777-666-5555', NULL)


INSERT INTO Booking (booking_id, customer_id, event_id, num_tickets, total_cost, booking_date)
VALUES 
(2, 2, 2, 3, 75.00, '2023-12-08'),
(3, 3, 3, 1, 30.00, '2023-12-12'),
(4, 4, 4, 2, 30.00, '2023-12-18'),
(5, 5, 5, 5, 250.00, '2023-12-22')

---sql queries

---2. Write a SQL query to list all Events.
SELECT event_name from Event

---3 Write a SQL query to select events with available tickets.
select * from event
SELECT event_name from event
where available_seats>=1

---4. Write a SQL query to select events name partial match with ‘cup’.
SELECT event_name from Event where event_name LIKE '%cup%'

--5. Write a SQL query to select events with ticket price range is between 10 to 25.
SELECT * from Event
SELECT event_name from Event WHERE ticket_price>10 and ticket_price<25
--6. Write a SQL query to retrieve events with dates falling within a specific range.
declare @sid date
set @sid ='2023-12-06'
DECLARE @eid date
set @eid='2023-12-15'
select event_name from Event 
where event_date BETWEEN @sid and @eid
---7. Write a SQL query to retrieve events with available tickets that also have "Concert" in theirname.
select * from Event
SELECT * from Event where available_seats>0 and event_name like '%Concert%'

---8. Write a SQL query to retrieve users in batches of 5, starting from the 6th user.
select * from Customer
SELECT * from Customer ORDER by customer_id OFFSET 2 rows FETCH next 3 rows only
---9. Write a SQL query to retrieve bookings details contains booked no of ticket more than 4.
select * from Booking
SELECT * from Booking where num_tickets>4
----10. Write a SQL query to retrieve customer information whose phone number end with ‘000
select * from customer
select customer_name from  customer
where phone_number like '%777'
---11. Write a SQL query to retrieve the events in order whose seat capacity more than 150.
select * from Event
select * from Event where total_seats>150
---12. Write a SQL query to select events name not start with ‘x’, ‘y’, ‘z’
SELECT event_name
FROM Event
WHERE event_name NOT LIKE 'x%' AND event_name NOT LIKE 'y%' AND event_name NOT LIKE 'z%'


--Aggregate functions, GroupBy and Joins:
--1Write a SQL query to List Events and Their Average Ticket Prices.
SELECT* From event
select event_name,Cast(avg(ticket_price)as decimal(10,2)) from Event
Group By event_name;
---2. Write a SQL query to Calculate the Total Revenue Generated by Events.
SELECT * from Event
select*from Booking
select sum(e.ticket_price*b.num_tickets) as total from Event e join Booking b on e.event_id=b.event_id
select sum(total_cost) from Booking
--3. Write a SQL query to select events with available tickets.
SELECT event_name FROM Event where available_seats>0
---4. Write a SQL query to Calculate the Total Number of Tickets Sold for Each Event.
SELECT * from Event
select*from Booking
select e.event_name,sum(b.num_tickets) from Event e join Booking b 
on e.event_id=b.event_id GROUP by e.event_name
---5  Write a SQL query to Find Events with No Ticket Sales.
select e.event_id,e.event_name from Event e 
left join Booking b  on e.event_id=b.event_id
where b.num_tickets=0
GROUP by e.event_id,e.event_name

---6 Write a SQL query to Find the User Who Has Booked the Most Tickets.
select * from Booking
SELECT top 1 c.customer_id,c.customer_name,sum(b.num_tickets) from Customer c 
join booking b on c.customer_id=b.customer_id
GROUP by c.customer_id,c.customer_name
order by sum(b.num_tickets) DESC
---8. Write a SQL query to calculate the average Ticket Price for Events in Each Venue.
select * from event
select v.venue_name,Cast(AVG(e.ticket_price)as decimal(10,2)) as average_TP FROM Venue v join Event e on v.venue_id=e.venue_id
GROUP by v.venue_name
---9 Write a SQL query to calculate the total Number of Tickets Sold for Each Event Type.
select * from Event
select e.event_type,sum(b.num_tickets) from Event e join Booking b 
on e.event_id=b.event_id GROUP by e.event_type
--10 Write a SQL query to calculate the total Revenue Generated by Events in Each Year.
select YEAR(e.event_date) year,sum(b.total_cost) Total from Event e 
join Booking b on e.event_id=b.event_id
GROUP by YEAR(e.event_date)
---11  Write a SQL query to list users who have booked tickets for multiple events.
select * from Booking
SELECT c.customer_id,c.customer_name,count(b.customer_id) from Customer c 
join Booking b on c.customer_id=b.customer_id
GROUP by c.customer_id,c.customer_name
HAVING COUNT(b.customer_id)>1
---12 Write a SQL query to calculate the Total Revenue Generated by Events for Each User.
SELECT c.customer_id,c.customer_name,sum(e.ticket_price*b.num_tickets) from Customer c 
join Booking b on c.customer_id=b.customer_id
join Event e on b.event_id=e.event_id
GROUP by c.customer_id,c.customer_name
--13 Write a SQL query to calculate the Average Ticket Price for Events in Each Category and Venue.
select v.venue_id,v.venue_name,e.event_type,cast(avg(e.ticket_price)as decimal(10,2)) from Venue v 
join Event e on e.venue_id=v.venue_id
GROUP by v.venue_id,v.venue_name,e.event_type
----14 Write a SQL query to list Users and the Total Number of Tickets They've Purchased in the Last 30 Days.
select c.customer_id,c.customer_name,sum(b.num_tickets) from Customer c join  Booking b 
on c.customer_id=b.customer_id
WHERE booking_date >=DATEADD(day,-30,GETDATE())
GROUP by c.customer_id,c.customer_name

---Subquery
---1 Calculate the Average Ticket Price for Events in Each Venue Using a Subquery.
SELECT v.venue_name,e.event_name,cast(avg(e.ticket_price)as decimal(10,2)) as AveragePrice from Venue v 
left join Event e on v.venue_id=e.venue_id
GROUP by v.venue_name,e.event_name

---2. Find Events with More Than 50% of Tickets Sold using subquery.
SELECT event_name from Event where available_seats<total_seats/2
---3 Calculate the Total Number of Tickets Sold for Each Event.
select e.event_name,sum(b.num_tickets) from Event e 
join Booking b on e.event_id=b.event_id
GROUP by e.event_name 
---4 Find Users Who Have Not Booked Any Tickets Using a NOT EXISTS Subquery.
SELECT * from Booking
SELECT c.customer_id,c.customer_name from Customer c where  NOT EXISTS  (select * from Booking b  where b.customer_id=c.customer_id )
--5 List Events with No Ticket Sales Using a NOT IN Subquery.
select e.event_id,e.event_name from Event e where e.event_id not in(select b.event_id from Booking b where b.event_id=e.event_id)

---6 Calculate the Total Number of Tickets Sold for Each Event Type Using a Subquery in the FROM Clause.
select e.event_name,sum(b.num_tickets) from Event e join Booking b 
on e.event_id=b.event_id GROUP by e.event_name

--7 Find Events with Ticket Prices Higher Than the Average Ticket Price Using a Subquery in the WHERE Clause.
SELECT e.event_name,e.ticket_price from Event e where e.ticket_price >(select avg(e.ticket_price) from Event e)

---8 Calculate the Total Revenue Generated by Events for Each User Using a Correlated Subquery.
SELECT c.customer_id,c.customer_name,e.event_name,sum(e.ticket_price*b.num_tickets) as totalRevenue From Event e 
join Booking b on e.event_id=b.event_id
join Customer c on c.customer_id=b.customer_id
GROUP by c.customer_id,c.customer_name,e.event_name
--- 9 List Users Who Have Booked Tickets for Events in a Given Venue Using a Subquery in the WHERE Clause.
select * from  Booking
SELECT * from Event

select c.customer_id,c.customer_name from Customer c 
join Booking b on c.customer_id=b.customer_id
join Event e on b.event_id=e.event_id
where e.venue_id=4

