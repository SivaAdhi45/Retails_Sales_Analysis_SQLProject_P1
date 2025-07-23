# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `p1_retailsales_db`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## 📁 Project Structure

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.


## 🧱 Schema Overview

### Table: `Retail_sales`

| Column Name       | Data Type     | Description                              |
|------------------|---------------|------------------------------------------|
| `Transactions_Id` | INT           | Unique identifier for each transaction   |
| `Sale_Date`       | DATE          | Date of the sale                         |
| `Sale_Time`       | TIME          | Time when the sale occurred              |
| `Customer_Id`     | INT           | Unique identifier for each customer      |
| `Gender`          | VARCHAR(20)   | Gender of the customer                   |
| `Age`             | INT           | Age of the customer                      |
| `Category`        | VARCHAR(25)   | Product category                         |
| `Quantity`        | INT           | Number of units sold                     |
| `Price_Per_Unit`  | FLOAT         | Price per unit of the product            |
| `Cogs`            | FLOAT         | Cost of goods sold                       |
| `Total_Sale`      | FLOAT         | Final sale value for the transaction     |


## 📊 Key Features & Analysis Covered

- ✅ Removal of incomplete or NULL records.
- ✅ Total number of sales transactions.
- ✅ Unique customer count.
- ✅ Distinct product categories available.
- ✅ Date range of the sales data.
- ✅ Sales on a specific date.
- ✅ High-quantity sales in the a particular category.
- ✅ Total sales grouped by category.
- ✅ Average age of customers buying **Beauty** products.
- ✅ Transactions with sales above particular value.
- ✅ Gender-based transaction volume by category.
- ✅ Average monthly sales & identification of best-performing months.
- ✅ Top 5 customers based on total sales.
- ✅ Category-wise unique customer count.
- ✅ Time-slot-based (Morning, Afternoon, Evening) order distribution.

## ✨ Sample Queries Highlight

```sql
-- Top 5 Customers by Total Sales
SELECT customer_id, SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;

```
-- Best Selling Month in Each Year
```sql
WITH ranked_months AS (
  SELECT 
    EXTRACT(YEAR FROM sale_date) AS year,
    EXTRACT(MONTH FROM sale_date) AS month,
    ROUND(AVG(total_sale), 2) AS avg_sales,
    RANK() OVER (PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) AS rank
  FROM retail_sales
  GROUP BY year, month
)
SELECT year, month, avg_sales
FROM ranked_months
WHERE rank = 1;
```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.
