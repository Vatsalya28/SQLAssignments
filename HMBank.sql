CREATE TABLE Customers (
customer_id INT PRIMARY KEY,
first_name VARCHAR(255),
last_name VARCHAR(255),
DOB DATE,
email VARCHAR(255),
phone_number VARCHAR(20),
address VARCHAR(255)
)


CREATE TABLE Accounts (
account_id INT PRIMARY KEY,
customer_id INT,
account_type VARCHAR(50),
balance DECIMAL(18, 2),
FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
)


CREATE TABLE Transactions (
transaction_id INT PRIMARY KEY,
account_id INT,
transaction_type VARCHAR(50),
amount DECIMAL(18, 2),
transaction_date DATETIME,
FOREIGN KEY (account_id) REFERENCES Accounts(account_id)
)

---inserting data
INSERT INTO Customers (customer_id, first_name, last_name, DOB, email, phone_number, address) VALUES
(1, 'Vatsalya', 'Baghel', '2000-10-28', 'vsb@yahoo.com', '5523567', 'Balawala'),
(2, 'Leo', 'Messi', '1995-07-19', 'messi@yahoo.com', '37777', 'Argentina'),
(3, 'Neymar', 'jr', '1980-02-10', 'ney@gmail.com', '99777', 'Brazil'),
(4, 'Cristiano', 'Ronaldo', '1975-09-25', 'ron@mail.com', '1133', 'Portugal'),
(5, 'Karim', 'Benzema', '1992-04-15', 'benz@gmail.com', '77555', 'France'),
(6, 'Kylian', 'Mbappe', '1983-12-08', 'mbappe@gmail.com', '44999', 'France'),
(7, 'Erling', 'Halland', '1970-06-20', 'halland@gmail.com', '882222', 'Norway'),
(8, 'Vinicius', 'Jr', '1998-03-30', 'vini@gmail.com', '224444', 'Brazil'),
(9, 'Marcus', 'Rashford', '1987-10-05', 'marcus@gmail.com', '66999', 'England'),
(10, 'Christopher', 'Nkuku', '1991-01-18', 'nkuku@gmail.com', '11777', 'France')

INSERT INTO Accounts (account_id, customer_id, account_type, balance)
VALUES
(101, 1, 'current', 1200.00),
(102, 1, 'savings', 2000.00),
(103, 2, 'current', 800.00),
(104, 2, 'savings', 3000.00),
(105, 3, 'current', 500.00),
(106, 3, 'savings', 10000.00),
(107, 4, 'current', 2500.00),
(108, 4, 'savings', 1500.00),
(109, 5, 'current', 300.00),
(110, 6, 'savings', 6000.00),
(111, 7, 'savings', 1500.00),
(112, 8, 'current', 300.00),
(113, 9, 'savings', 6000.00)

INSERT INTO Transactions (transaction_id, account_id, transaction_type, amount, transaction_date)
VALUES
(1001, 101, 'deposit', 500.00, '2023-01-10'),
(1002, 101, 'transfer', 200.00, '2023-01-12'),
(1003, 102, 'deposit', 1000.00, '2023-02-05'),
(1004, 102, 'withdrawal', 300.00, '2023-02-15'),
(1005, 103, 'deposit', 800.00, '2023-03-02'),
(1006, 105, 'withdrawal', 500.00, '2023-03-10'),
(1007, 106, 'transfer', 1200.00, '2023-03-20'),
(1008, 107, 'withdrawal', 1000.00, '2023-04-05'),
(1009, 109, 'deposit', 3000.00, '2023-04-12'),
(1010, 110, 'transfer', 50.00, '2023-04-18'),
(1011, 111, 'deposit', 600.00, '2023-05-02'),
(1012, 112, 'withdrawal', 200.00, '2023-05-10'),
(1013, 113, 'deposit', 1500.00, '2023-05-20 ')

----2. Write SQL queries for the following tasks:

----1. Write a SQL query to retrieve the name, account type and email of all customers.
select c.first_name,c.last_name,c.email,a.account_type from Customers c 
join Accounts a on c.customer_id=a.customer_id

----2. Write a SQL query to list all transaction corresponding customer.
SELECT c.first_name,c.last_name,t.transaction_type,t.amount
from Customers c join Accounts a on c.customer_id=a.customer_id
join Transactions t on a.account_id=t.account_id

----3.Write a SQL query to increase the balance of a specific account by a certain amount.
SELECT * from Accounts

UPDATE Accounts
set balance=balance+500
where account_id=101

---4Write a SQL query to Combine first and last names of customers as a full_name.
 SELECT concat(first_name ,' ',last_name) as full_name from Customers

 --5Write a SQL query to remove accounts with a balance of zero where the account type is savings.
 SELECT * FROM Accounts
 delete accounts
 where balance=0 and account_type='savings'
 alter table transactions add CONSTRAINT fk_transaction_accounts FOREIGN key (account_id) REFERENCES Accounts(account_id) on DELETE
 CASCADE

 --- 6  Write a SQL query to Find customers living in a specific city.
 select c.first_name,c.last_name from customers c where c.address='France' 

 ---7 Write a SQL query to Get the account balance for a specific account.
 select * from Accounts
select balance from accounts where account_id=105

---8. Write a SQL query to List all current accounts with a balance greater than $1,000.
SELECT * from Accounts

select * from Accounts where account_type='current' and balance>1000

----9. Write a SQL query to Retrieve all transactions for a specific account.
select * from TRANSACTIONs
select * from TRANSACTIONs where account_id=101
----10 Write a SQL query to Calculate the interest accrued on savings accounts based on a given interest rate.

select * from Accounts
select account_id, balance AS principal,
0.02 AS interest_rate,
balance * 0.02 AS interest_accrued
from Accounts where account_type = 'savings';

---11 Write a SQL query to Identify accounts where the balance is less than a specified overdraft limit.
declare @overdraftLimit INT
set @overdraftLimit=1000
select account_id from Accounts
where balance<@overdraftLimit

---Tasks 3: Aggregate functions, Having, Order By, GroupBy and Joins:

---1. Write a SQL query to Find the average account balance for all customers.
select * from Customers
select * from Accounts

select c.customer_id,c.first_name,c.last_name,avg(a.balance)
from customers c join Accounts a on c.customer_id=a.customer_id
group by c.customer_id,c.first_name,c.last_name

--2. Write a SQL query to Retrieve the top 10 highest account balances.
select top 5 c.first_name,c.last_name,a.balance as maxim
from Customers c join Accounts a on c.customer_id=a.customer_id

order by maxim desc

---3. Write a SQL query to Calculate Total Deposits for All Customers in specific date.
select * from transactions
select sum(t.amount) sumOfAllDeposit from TRANSACTIONs t 
where t.transaction_type='deposit'
and t.transaction_date BETWEEN '2023-05-01' and '2023-12-31'

---- 5. Write a SQL query to Retrieve transaction details along with the account type.
select t.transaction_id,t.transaction_type,t.amount,t.transaction_date,a.account_type from transactions t  join Accounts a 
on t.account_id=a.account_id

---6. Write a SQL query to Get a list of customers along with their account details.
select c.first_name,c.last_name,a.account_id,a.account_type,a.balance from Customers c 
join Accounts a on c.customer_id=a.customer_id

---7. Write a SQL query to Retrieve transaction details along with customer information for a specific account.
declare @aid INT
set @aid=105
select c.first_name,c.last_name,t.transaction_id,t.transaction_type,t.amount,t.transaction_date
from Customers c join Accounts a on c.customer_id=a.customer_id
join Transactions t on a.account_id=t.account_id
WHERE a.account_id=@aid

---8. Write a SQL query to Identify customers who have more than one account.
select c.first_name,c.last_name,count(a.customer_id) as totalAccounts from customers c 
join Accounts a on c.customer_id=a.customer_id
GROUP by c.first_name,c.last_name
having count(a.customer_id)>1

select * from Accounts

---11 Calculate the total balance for each account type.

select * from Accounts
select a.account_type,sum(a.balance) as total_balance from Accounts a 
GROUP by a.account_type


----12. Identify accounts with the highest number of transactions order by descending order.
select * from Transactions

select t.account_id,count(t.transaction_id) Number_of_transaction from Transactions t 
GROUP by t.account_id ORDER by count(t.transaction_id)  desc 

---13 List customers with high aggregate account balances, along with their account types.
select c.first_name,c.last_name,a.account_type,sum(a.balance) as aggregate_balance from Customers c 
join Accounts a on c.customer_id=a.customer_id 
GROUP by c.first_name,c.last_name,a.account_type
ORDER by aggregate_balance desc

----Tasks 4: Subquery and its type:
---1. Retrieve the customer(s) with the highest account balance.


select top 1 c.first_name,c.last_name,(a.balance) from Customers c 
join Accounts a on c.customer_id=a.customer_id
GROUP by c.first_name,c.last_name,a.balance
order by (a.balance) desc

---2 Calculate the average account balance for customers who have more than one account.
SELECT c.first_name,c.last_name,avg(a.balance) as average_balance from Customers c 
join  Accounts a on c.customer_id=a.customer_id
GROUP by c.first_name,c.last_name
having count(a.account_id)>1 
---- 3 Retrieve accounts with transactions whose amounts exceed the average transaction amount.
select t.account_id,avg(t.amount) as averageAmount from Transactions t
GROUP by t.account_id
having max(t.amount)>avg(t.amount)

----4 Identify customers who have no recorded transactions.

select c.customer_id,c.first_name,c.last_name from Customers c join Accounts a on c.customer_id=a.customer_id
left join Transactions t on a.account_id=t.account_id
where t.transaction_id is null 

---Calculate the total balance of accounts with no recorded transactions.
select a.account_id,sum(a.balance) from Accounts a 
left join Transactions t on a.account_id=t.account_id
where t.account_id is NULL
GROUP by a.account_id

----6 Retrieve transactions for accounts with the lowest balance.
SELECT top 1 t.transaction_id,t.account_id,a.balance from Transactions t 
join Accounts a on t.account_id=a.account_id
ORDER by a.balance asc

---7  Identify customers who have accounts of multiple types.
select c.first_name,c.last_name,count(distinct a.account_type) typesOfAccount from Customers c
join Accounts a on c.customer_id=a.customer_id
GROUP by c.first_name,c.last_name
HAVING count(distinct a.account_type)>1

---8 Calculate the percentage of each account type out of the total number of accounts.
select account_type,count(account_id) as total_account,COUNT(account_type) * 100.0 / (SELECT COUNT(*) FROM Accounts) as per
FROM Accounts GROUP BY account_type

---9 Retrieve all transactions for a customer with a given customer_id.
declare @cid INT
set @cid=1
select c.first_name,c.last_name,t.transaction_id,t.transaction_type,t.amount
from Customers c join Accounts a on c.customer_id=a.customer_id
join Transactions t on a.account_id=t.account_id
where c.customer_id=@cid

---10 Calculate the total balance for each account type, including a subquery within the SELECT clause
select account_type,sum(balance) from Accounts
group by account_type
 
