create database booka;
use booka;
rename table real_books to books;
rename table creal_customers to customers;
rename table creal_order_details to order_details;
rename table creal_orders to orders;

select * from books;
select * from customers;
select * from order_details;
select * from orders;

-- Customers who placed Orders:- Distinct
select distinct customers.CustomerID, customers.Name
from customers
inner join orders on customers.CustomerID=orders.CustomerID;

-- Number of Orders placed by each customer
select customers.CustomerID as CID,customers.Name as Name,count(orders.OrderID) as OrdersPlaced
from customers
inner join orders on customers.CustomerID=orders.OrderID
group by CID,Name 
order by Name;

-- Which customer spent the most overall?
select customers.Name as Name, round(sum(order_details.SalePrice),2) as TotalSpent
from customers
inner join orders on customers.CustomerID=orders.CustomerID
inner join order_details on orders.OrderID=order_details.OrderID
group by Name
order by TotalSpent desc
limit 1;

-- List customer who received more than 10% of discount on any order item
select customers.CustomerID,customers.Name as Name,order_details.Discount as MaxDiscount
from customers
inner join orders on customers.CustomerID=orders.CustomerID
inner join order_details on orders.OrderID=order_details.OrderID
where order_details.Discount>0.10;

-- Show the total amount spent by each customer
select customers.CustomerID as CID,customers.Name as Name,round(sum(order_details.SalePrice),2) as TotalSpent
from customers
inner join orders on customers.CustomerId=orders.CustomerID
inner join order_details on orders.OrderID=order_details.OrderID
group by CID,Name
order by TotalSpent desc;

-- Which age group buys most books?
select customers.AgeGroup as AgeGroup,count(orders.OrderID) as Orders
from customers
inner join orders on customers.CustomerID=orders.CustomerID
group by AgeGroup
order by Orders desc;

-- Which book has sold the most by quantity?
select books.Title as Title,books.Author as Author, sum(order_details.Quantity) as Qty
from books
inner join order_details on books.BookID=order_details.BookID
group by Title,Author
order by Qty desc
limit 3;

-- List Top 5 best selling books by revenue=sum(Saleprice*Quantity)
select books.Title,books.Author,round(sum(order_details.SalePrice*order_details.Quantity),2) as Revenue
from books
inner join order_details on books.BookID=order_details.BookID
group by Title,Author
order by Revenue
limit 5;

-- Which book has the highest discount on any order?
select books.Title,books.Author,max(order_details.Discount) as Discount
from books
inner join order_details on books.BookID=order_details.BookID
group by title,Author
order by Discount
limit 3;

-- Find books that were never sold
select books.Title,books.Author
from books 
left join order_details on books.BookID=order_details.BookID
where order_details.BookID is null;

select count(distinct books.BookID) as BBID,count(distinct order_details.BookID) as ODBID
from books
left join order_details on books.BookID=order_details.BookID;   -- Means all books were sold.

-- Show average discount offer on each book
select books.Title as Title,books.Author as Author,round(avg(order_details.Discount),2) as AvgDiscount
from books
inner join order_details on books.BookID= order_details.BookID
group by Title,Author
order by AvgDiscount;

-- Book Genre that sold the most
select books.Genre as Genre, round(sum(order_details.SalePrice*order_details.Quantity),2) as Total
from  books
inner join order_details on books.BookID=order_details.BookID
group by Genre
order by Total desc
limit 3;

-- What is the total revenue generated? after discount is considered
select round(sum(NetAmount),2) as NetRevenue
from order_details;   

-- What is the gross revenue if no discount was given?
select round(sum(SalePrice*Quantity),2) as GrossRevenue
from order_details;

select round(sum(SalePrice),2) as TotalSalePrice from order_details;
select round(sum(NetAmount),2) as TotalNetAmount from order_details;


-- List all orders with more than 3 items
select order_details.OrderID as OID,customers.CustomerID as CID, round(sum(order_details.Quantity))as TotalItems
from customers
inner join orders on customers.CustomerID=orders.CustomerID
inner join order_details on orders.OrderID=order_details.OrderID
group by OID,CID
having TotalItems>3
order by TotalItems;


-- What's the avg order value? Netamount/ distinct orders?
select round(sum(order_details.NetAmount)/count( distinct order_details.OrderID),2) as AvgOrder
from order_details;

-- Total Discount given 
select round(sum(SalePrice*Quantity*Discount)/sum(SalePrice*Quantity)*100,2)as DiscountGiven from order_details; 


-- Which month had the highest number of orders?
select orders.Month as Month, count(orders.OrderID) as Orders
from orders
group by Month
order by Orders desc;


-- How many orders were placed each month?
select orders.Month as Month,count(orders.OrderID) as Orders
from orders
group by Month
order by Orders desc;

-- Which city has the most orders?
select customers.city as City, count(orders.OrderID) as Orders
from customers
inner join orders on customers.CustomerID=orders.CustomerID
group by City
order by Orders desc;

-- What type of Payment mode was used most?
select orders.PaymentMode as Mode, count(orders.OrderID) as Orders
from orders 
group by Mode
order by Orders;


-- Who is the most popular author based on sales?
select books.Author as Author, sum(order_details.Quantity) as TotalSold
from books
inner join order_details on books.BookID=order_details.BookID
group by Author
order by TotalSold desc;











