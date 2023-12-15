CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    Phone VARCHAR(20),

    Address VARCHAR(255)
)

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Description TEXT,
    Price DECIMAL(10, 2)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

CREATE TABLE Inventory (
    InventoryID INT PRIMARY KEY,
    ProductID INT,
    QuantityInStock INT,
    LastStockUpdate DATE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
--insert

INSERT INTO Customers (CustomerID, FirstName, LastName, Email, Phone, Address)
VALUES
    (11, 'John', 'Doe', 'johndoe@gmail.com', '1234567890', '365 Main St'),
    (22, 'Ram', 'Anand', 'ramanand@gmail.com', '9876543210', '367 Jalsa Roorkee'),
    (24, 'Alice', 'Hao', 'alicehao@gmail.com', '4587543210', '020 Oak St'),
    (25, 'Aman', 'Das', 'amandas@gmail.com', '9894576310', '100 Surat'),
    (33, 'Raj', 'Sharma', 'rajsharma@gmail.com', '6005842365', '978 Ram Nagar'),
    (48, 'Krishan', 'Raaj', 'krishanraaj@gmail.com', '7005213658', '634 Delhi'),
    (65, 'Michael', 'Johnson', 'michaelj@gmail.com', '9778542697', '789 Elm St'),
    (78, 'Kriti', 'Kapoor', 'kritikapoor@gmail.com', '6448751236', '200 Bhopal'),
    (86, 'Pooja', 'Bhatt', 'poojabhatt@gmail.com', '9797856321', '256 Dehradun'),
    (94, 'Smith', 'Lace', 'smithlace@gmail.com', '8546975216', '444 Gopalganj');
     
INSERT INTO Products (ProductID, ProductName, Description, Price)
VALUES
    (1, 'Smartphone', 'High-end smartphone with advanced features', 999.99),
    (2, 'Laptop', 'Thin and lightweight laptop with powerful performance', 1299.99),
    (3, 'Tablet', 'Portable tablet with a high-resolution display', 599.99),
    (4, 'Headphones', 'Wireless noise-cancelling headphones', 249.99),
    (5, 'Smartwatch', 'Fitness tracking smartwatch with heart rate monitor', 199.99),
    (6, 'Gaming Console', 'Next-generation gaming console', 499.99),
    (7, 'Wireless Earbuds', 'True wireless earbuds with long battery life', 149.99),
    (8, 'Camera', 'High-resolution digital camera with advanced features', 799.99),
    (9, 'Drone', 'Quadcopter drone with 4K camera', 1299.99),
    (10, 'Smart Home Hub', 'Central control for smart home devices', 199.99);
   
INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount)
VALUES
    (1, 11, '2023-11-01', 899.99),
    (2, 22, '2023-11-02', 749.99),
    (3, 24, '2023-11-03', 1599.99),
    (4, 25, '2023-11-04', 499.99),
    (5, 33, '2023-11-05', 299.99),
    (6, 48, '2023-11-06', 1149.99),
    (7, 65, '2023-11-07', 699.99),
    (8, 78, '2023-11-08', 899.99),
    (9, 86, '2023-11-09', 349.99),
    (10, 94, '2023-11-10', 1899.99);
       
INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity)
VALUES
    (1, 1, 1, 2),
    (2, 1, 3, 1),
    (3, 2, 2, 1),
    (4, 2, 4, 3),
    (5, 3, 5, 2),
    (6, 3, 6, 1),
    (7, 4, 1, 1),
    (8, 4, 3, 2),
    (9, 5, 2, 1),
    (10, 5, 5, 3);
      
INSERT INTO Inventory (InventoryID, ProductID, QuantityInStock, LastStockUpdate)
VALUES
    (1, 1, 50, '2023-11-01'),
    (2, 2, 75, '2023-11-02'),
    (3, 3, 100, '2023-11-03'),
    (4, 4, 30, '2023-11-04'),
    (5, 5, 60, '2023-11-05'),
    (6, 6, 25, '2023-11-06'),
    (7, 7, 80, '2023-11-07'),
    (8, 8, 40, '2023-11-08'),
    (9, 9, 20, '2023-11-09'),
    (10, 10, 55, '2023-11-10');


 ---- dml
 --1Write an SQL query to retrieve the names and emails of all customers.
 select c.FirstName,c.LastName,c.Email from Customers c

-----2Write an SQL query to list all orders with their order dates and corresponding customer names.
select o.OrderID,c.FirstName,c.LastName from Orders o 
join Customers c on o.CustomerID=c.CustomerID

---3 Write an SQL query to insert a new customer record into the "Customers" table. Include customer information such as name, email, and address.
INSERT INTO Customers(CustomerID, FirstName, LastName, Email, Address)
VALUES (51,'Salman', 'Khan', 'sk@gmail.com', '48 Jannat');

---4 Write an SQL query to update the prices of all electronic gadgets in the "Products" table by 
--increasing them by 10%.
select Price from Products
UPDATE Products
set price=price*1.10

--- 5 Write an SQL query to delete a specific order and its associated order details from the 
---"Orders" and "OrderDetails" tables. Allow users to input the order ID as a parameter.

DECLARE @od INT
set @od =2
BEGIN TRANSACTION
DELETE from OrderDetails
WHERE OrderID=@od;
DELETE from Orders where OrderID=@od
COMMIT

---Write an SQL query to insert a new order into the "Orders" table. Include the customer ID, 
--order date, and any other necessary information.
INSERT INTO Customers(CustomerID)
VALUES (34);
INSERT INTO Orders(OrderID,CustomerID, OrderDate)
VALUES (11,34,'2022-12-16');

---Write an SQL query to update the contact information (e.g., email and address) of a specific 
---customer in the "Customers" table. Allow users to input the customer ID and new contact 
---information.
select * from Customers
DECLARE @cid INT
set @cid=11

DECLARE @email VARCHAR(50)
set @email='vasb@yahoo.com'
UPDATE Customers
set Email=@email where CustomerID=@cid

DECLARE @add VARCHAR(50)
set @add='Doon'
UPDATE Customers
set Address=@add where CustomerID=@cid


---Write an SQL query to update the status of a specific order in the "Orders" table (e.g., from 
---"Pending" to "Shipped"). Allow users to input the order ID and the new status.
alter table Orders add  status VARCHAR(50) 
select* from Orders
DECLARE @stat VARCHAR(50)
set @stat='shipped'
DECLARE @oid INT
set @oid=1
UPDATE Orders
set status=@stat
where OrderID=@oid

---Write an SQL query to calculate and update the number of orders placed by each customer 
--in the "Customers" table based on the data in the "Orders" table.
ALTER table Customers add Number INT
select * from Customers
select * from Orders
UPDATE Customers
set Number=(select count(OrderID) from 
Orders where Customers.CustomerID=Orders.CustomerID)

---Write an SQL query to find out which customers have not placed any orders.
SELECT c.FirstName,c.LastName from Customers c where CustomerID not in(select CustomerID from Orders)

SELECT c.FirstName,c.LastName from Customers c
 left join Orders o on c.CustomerID=o.CustomerID
where o.CustomerID is null







---1. Write an SQL query to retrieve a list of all orders along with customer information (e.g., customer name) for each order.
select c.CustomerID,c.FirstName,c.LastName,o.OrderID,p.ProductName from Customers c 
 join Orders o on c.CustomerID=o.CustomerID
 join OrderDetails od on o.OrderID=od.OrderDetailID
 join Products p on od.ProductID=p.ProductID 

----2.2. Write an SQL query to find the total revenue generated by each electronic gadget product. Include the product name and the total revenue.
select * from Products
select * from OrderDetails
select p.ProductName,p.category,sum(p.Price*od.Quantity) as totals from Products p 
join OrderDetails od on p.ProductID=od.ProductID
where p.category='Electronics'
GROUP by p.ProductName,p.category

----3. Write an SQL query to list all customers who have made at least one purchase. Include their names and contact information.
select c.CustomerID,c.FirstName,c.LastName from Customers c 
join Orders o on c.CustomerID=o.CustomerID
GROUP by c.CustomerID,c.FirstName,c.LastName
HAVING count(o.OrderID) >=1

---4. Write an SQL query to find the most popular electronic gadget, which is the one with the highest total quantity ordered. Include the product name and the total quantity ordered.
select top 1 p.ProductName,od.quantity from Products p 
join OrderDetails od on p.ProductID=od.ProductID
where p.category='Electronics'

----6. Write an SQL query to calculate the average order value for each customer. Include the customer's name and their average order value.

SELECT c.FirstName,c.LastName,avg(p.price*od.quantity) as average_price from customers c 
join Orders o on c.CustomerID=o.CustomerID
join OrderDetails od on o.OrderID=od.OrderID
join Products p on od.ProductID=p.ProductID
group by c.FirstName,c.LastName
----7. Write an SQL query to find the order with the highest total revenue. Include the order ID, customer information, and the total revenue.
select * from Orders
select top 1 c.FirstName,c.LastName,o.OrderID,o.TotalAmount 
from Customers c join Orders o on c.CustomerID=o.CustomerID
ORDER by o.TotalAmount DESC

----8  Write an SQL query to list electronic gadgets and the number of times each product has been ordered.
select p.ProductID, p.ProductName,count(od.ProductID) as nooftimes from Products p 
join OrderDetails od on p.ProductID=od.ProductID
where p.category='Electronics'
GROUP by p.ProductID, p.ProductName


---9  9. Write an SQL query to find customers who have purchased a specific electronic gadget product. Allow users to input the product name as a parameter.
DECLARE @pid VARCHAR(50)
set @pid='Smartphone'
select c.FirstName,c.LastName from Customers c 
join Orders o on c.CustomerID=o.CustomerID
join OrderDetails od on o.OrderID=od.OrderID
join Products p on od.ProductID=p.ProductID
where p.ProductName=@pid

----10. Write an SQL query to calculate the total revenue generated by all orders placed within a specific time period. Allow users to input the start and end dates as parameters.
DECLARE @sid DATE
set @sid='2023-11-01'
DECLARE @eid DATE
set @eid ='2023-11-06'
select sum(TotalAmount) as total from Orders
where OrderDate BETWEEN @sid and @eid


select * from Orders



---------Write an SQL query to find the total number of orders placed by each customer and list their names along with the order count
select c.CustomerID,c.FirstName,c.LastName,count(o.OrderID) as order_count from Customers c 
join Orders o on c.CustomerID=o.CustomerID
group by c.CustomerID,c.FirstName,c.LastName

-----9. Write an SQL query to calculate the average order value (total revenue divided by the number of orders) for all customers.
SELECT SUM(totalAmount) / COUNT(DISTINCT orderID) AS average
FROM Orders;


----8. Write an SQL query to find the customer who has spent the most money (highest total revenue) on electronic gadgets. List their name and total spending.
select top 1 c.customerID,c.FirstName,c.LastName,sum(o.totalAmount) as highest from Customers c 
join Orders o on c.CustomerID=o.CustomerID
join OrderDetails od on o.OrderID=od.OrderID
join Products p  on od.ProductID=p.ProductID
where p.Category='Electronics'
GROUP by c.customerID,c.FirstName,c.LastName
order by sum(o.totalAmount) desc


