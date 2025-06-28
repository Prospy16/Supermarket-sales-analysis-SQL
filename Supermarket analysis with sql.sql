
CREATE TABLE sales(
Invoice_id VARCHAR(50) PRIMARY KEY NOT NULL,
branch CHAR(1),
city VARCHAR(10),
Customer_type VARCHAR(10),
Gender VARCHAR(10),
product_line VARCHAR(50),
Unit_price DECIMAL(10,2),
Quantity INT,
Tax DECIMAL(10,2),
Total DECIMAL(10,2),
Date DATE,
Time TIME,
Payment_type VARCHAR(20),
COGS DECIMAL(10,2),
Gross_margin DECIMAL(10,2),
Gross_income DECIMAL (10,2),
Ratings DECIMAL(10,2)

);



--Which product line generated the highest total sales and gross income?
SELECT product_line,
		SUM(Total) AS total_sales,
		SUM(Gross_income) AS total_grossincome
FROM sales 
GROUP BY product_line
ORDER BY total_sales DESC, total_grossincome DESC;



--What is the average sales amount and profit (gross income) per transaction across all branches?
SELECT branch,
		ROUND(AVG(Total),2) AS avg_sales,
		ROUND(AVG(Gross_income),2) AS avg_grossincome
FROM sales 
GROUP BY branch;

--Do members or normal customers spend more on average per transaction?
SELECT Customer_type,
		ROUND(AVG(Total),2) AS avg_transaction
FROM sales 
GROUP BY Customer_type;

--Which gender has a higher average transaction value and quantity purchased?
SELECT Gender,
		ROUND(AVG(Total),2) AS avg_sales,
		SUM(Quantity) AS total_quantity
FROM sales 
GROUP BY Gender
ORDER BY avg_sales DESC, total_quantity DESC;


--BRANCH AND LOCATION ANALYSIS
--Which branch recorded the highest total revenue and profit?
SELECT branch,
		SUM(Total) AS total_sales,
		SUM(Gross_income) AS total_grossincome
FROM sales
GROUP BY branch
ORDER BY total_sales DESC, total_grossincome DESC;

--How does customer satisfaction (average rating) compare across different branches and cities?
SELECT branch,
		city,
		ROUND(AVG(Ratings),2) AS total_sales
FROM sales
GROUP BY branch, city
ORDER BY total_sales DESC;


--What are the top 3 best-selling product lines by quantity and revenue?
SELECT product_line,
		SUM(Total) AS total_sales,
		SUM(Quantity) AS total_quantity
FROM sales
GROUP BY product_line
ORDER BY total_sales DESC, total_quantity DESC
LIMIT 3;


--Which product lines have the highest average profit margins and customer ratings?
SELECT product_line,
		ROUND(AVG(Ratings),2) AS avg_ratings,
		ROUND(AVG(Gross_margin),2) AS avg_profit
FROM sales
GROUP BY product_line
ORDER BY avg_ratings DESC, avg_profit DESC;


--On which days and times are sales and customer traffic the highest?
--SELECT * FROM sales
SELECT
	TO_CHAR(Date, 'DAY') AS day_of_week,
	--EXTRACT(HOUR FROM Time) AS Hours,
	TO_CHAR(Time, 'HH24:MI') AS Hours,
	COUNT(Invoice_id) AS no_of_transactions,
	SUM(Total) AS total_sales
FROM sales
GROUP BY day_of_week, Hours
ORDER BY  no_of_transactions DESC, total_sales DESC;


--What are the peak sales hours for each branch throughout the day?
SELECT branch,
	TO_CHAR(Time, 'HH24:MI') AS Hours,
	COUNT(Invoice_id) AS no_of_transactions,
	SUM(Total) AS total_sales
FROM sales 
GROUP BY branch, Hours
ORDER BY  no_of_transactions DESC, total_sales DESC;


--Which payment method is most commonly used, and how does it correlate with total sales and customer type?
SELECT Customer_type,
		Payment_type,
		COUNT(Invoice_id) AS total_count,
		SUM(Total) AS total_sales
FROM sales
GROUP BY customer_type, payment_type
ORDER BY total_count DESC, total_sales DESC;


--What is the average transaction value per payment method across branches?
SELECT Payment_type,
		branch,
		ROUND(AVG(Total),2) avg_transaction
FROM sales
GROUP BY Payment_type, branch
ORDER BY avg_transaction DESC;


--What is the average number of items purchased per transaction for each product line?
SELECT product_line,
		ROUND(AVG(Quantity),2) avg_no_transactions
FROM sales
GROUP BY product_line
ORDER BY avg_no_transactions DESC;

--How does profit per transaction vary across different days of the week?
SELECT 
	TO_CHAR(Date, 'DAY') week_count,
	ROUND(AVG(Gross_income),2) avg_profit
FROM sales
GROUP BY TO_CHAR(Date, 'DAY')
ORDER BY avg_profit DESC;

--Is there a relationship between customer ratings and total spending or profit per transaction?
SELECT Ratings,
		ROUND(AVG(Total),2) avg_sales,
		ROUND(AVG(Gross_income),2) avg_profit
FROM sales
GROUP BY Ratings
ORDER BY Ratings DESC;


SELECT *
FROM sales;












