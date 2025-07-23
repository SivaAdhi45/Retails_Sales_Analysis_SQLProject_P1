-- SQL Retail Sales Analysis P1 --

Create database p1_retailsales_db;

-- Create Table

Create table Retail_sales 
             (
              Transactions_Id int,
              Sale_Date	Date,
              Sale_Time Time,
              Customer_Id int,
              Gender varchar(20),
              Age int,
              Category varchar(25),
              Quantity int,
              Price_Per_Unit float,
              Cogs float,
              Total_Sale float
			);
            
Alter table retail_sales
add primary key (Transactions_id);

select count(*) from retail_sales;

-- Data Cleaning

select * from retail_sales
where Transactions_Id is null
      or
      Sale_Date is null
      or
      Sale_Time is null
      or
      Customer_Id is null
      or
      Gender is null
      or
      age is null
      or
      Category is null
      or
      Quantity is null
      or
      Price_Per_Unit is null
      or
      Cogs is null
      or
      Total_Sale is null;

delete from retail_sales
where Transactions_Id is null
      or
      Sale_Date is null
      or
      Sale_Time is null
      or
      Customer_Id is null
      or
      Gender is null
      or
      age is null
      or
      Category is null
      or
      Quantity is null
      or
      Price_Per_Unit is null
      or
      Cogs is null
      or
      Total_Sale is null;
      
-- Data Exploration

-- How many sales records do we have in this table?
Select Count(*) as Total_Sales_Records from retail_sales;

-- How many unique customers do we have?
Select Count(distinct(customer_id)) as No_of_Customers from retail_sales;

-- What are all the categories available?
Select distinct category from retail_sales;

-- In which time periods do we have the sales details for?
select sale_date as Start_Date 
from retail_sales
order by sale_date
limit 1;
select sale_date as End_Date 
from retail_sales
order by sale_date desc
limit 1;

-- Data Analysis

-- Q.1 Query to retrive all the columns for sales made on '11-11-2022'

Select * from retail_sales
where Sale_Date = '2022-11-11'
order by Sale_Time;

-- Q.2 Quuery to retrive all the transactions where the category is 'Clothings' and quantity sold is more than 5 in the month of Nov-22

Select * from retail_sales
where Category = 'Clothing'
      And Quantity > 3
      And Sale_Date between '2022-11-01' and '2022-11-30'
order by quantity desc;

-- Q.3 Query to calculate the total sale for each category

Select Category, sum(total_sale) as Total_Sales, count(*) as Total_orders from retail_sales
group by Category;

-- Q.4 Query to retrive average age of customers who purchased items from burglary category

Select Category, round(Avg(age)) As Average_Age from retail_sales
where Category = 'Beauty'
group by Category;

-- Q.5 Query to find all the transactions where total sales is gerater than 1000

Select * from retail_sales
where Total_Sale > 1000;

-- Q.6 Query to find total number of transactions made by each gender in each category

select 
      Gender, Category, count(*) as Total_Transactions
From retail_sales
group by Gender, Category
order by 3 desc;

-- Q.7 Query to calculate average sales for each month. Find out best selling month in each year

Select year, Month, Average_Sales
from
(
select 
      extract(year from sale_date) as Year,
      Extract(Month from sale_date) as Month,
      round(avg(total_sale),2) as Average_Sales,
      rank() over (partition by extract(year from sale_date) order by avg(total_sale) desc) as ranks
From retail_sales
group by Year,Month
) as Highest_sales
where ranks=1;

-- Q.8 Query to find top 5 customers based on the highest total sales.

Select customer_id,sum(Total_Sale) as Total_Sales
from retail_sales
group by customer_id
order by sum(total_sale) desc
Limit 5;

-- Q.9 Query to find number of unique customers who purchased items in each category.

Select category, count(distinct customer_id) as Customer_Count
from retail_sales
group by category
order by customer_count desc;

-- Q.10 Query to create each shift and number of orders (Example Morning < 12, Afternoon between 12 & 17, Evening > 17)

With shifts as 
(
select *,
case 
     when extract(hour from sale_time) > 17 then 'Evening'
     when extract(hour from sale_time) between 12 and 17 then 'Afternoon'
     Else 'Morning'
End as Shift
from retail_sales
)
select shift, count(Transactions_id) from shifts
group by shift;

-- End of project
