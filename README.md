# Supermarket-sales-analysis-SQL

A complete SQL project that explores supermarket transactional data to uncover sales, customer, product, and operational insights.

---

##  Objective
- Query supermarket sales data using SQL  
- Answer key business questions on revenue, profit, customer segments, and product lines  
- Provide actionable recommendations based on data‑driven insights  

---

##  Project Description
The dataset captures **invoice‑level** transactions from multiple branches, including fields such as customer type, gender, product line, payment method, quantity, sales, profit, and ratings.  
We create a relational table, run analytical SQL queries, summarize findings, and suggest strategies to boost performance.

---

## 🗄️ Creating the Table

```sql
CREATE TABLE sales (
  Invoice_id     VARCHAR(50) PRIMARY KEY NOT NULL,
  branch         CHAR(1),
  city           VARCHAR(10),
  Customer_type  VARCHAR(10),
  Gender         VARCHAR(10),
  product_line   VARCHAR(50),
  Unit_price     DECIMAL(10,2),
  Quantity       INT,
  Tax            DECIMAL(10,2),
  Total          DECIMAL(10,2),
  Date           DATE,
  Time           TIME,
  Payment_type   VARCHAR(20),
  COGS           DECIMAL(10,2),
  Gross_margin   DECIMAL(10,2),
  Gross_income   DECIMAL(10,2),
  Ratings        DECIMAL(10,2)
);

```
---
--Which product line generated the highest total sales and gross income?
```
SELECT product_line,
		SUM(Total) AS total_sales,
		SUM(Gross_income) AS total_grossincome
FROM sales 
GROUP BY product_line
ORDER BY total_sales DESC, total_grossincome DESC
LIMIT 1;
```
---

--What is the average sales amount and profit (gross income) per transaction across all branches?
```
SELECT branch,
		ROUND(AVG(Total),2) AS avg_sales,
		ROUND(AVG(Gross_income),2) AS avg_grossincome
FROM sales 
GROUP BY branch;

```
---
--Do members or normal customers spend more on average per transaction?
```
SELECT Customer_type,
		ROUND(AVG(Total),2) AS avg_transaction
FROM sales 
GROUP BY Customer_type;
```
---
--Which gender has a higher average transaction value and quantity purchased?
```
SELECT Gender,
		ROUND(AVG(Total),2) AS avg_sales,
		SUM(Quantity) AS total_quantity
FROM sales 
GROUP BY Gender
ORDER BY avg_sales DESC, total_quantity DESC
LIMIT 1;
```
---
--Which branch recorded the highest total revenue and profit?
```
SELECT branch,
		SUM(Total) AS total_sales,
		SUM(Gross_income) AS total_grossincome
FROM sales
GROUP BY branch
ORDER BY total_sales DESC, total_grossincome DESC
LIMIT 1;
```

---
--How does customer satisfaction (average rating) compare across different branches and cities?
```
SELECT branch,
		city,
		ROUND(AVG(Ratings),2) AS total_sales
FROM sales
GROUP BY branch, city
ORDER BY total_sales DESC;
```

---
--What are the top 3 best-selling product lines by quantity and revenue?
```
SELECT product_line,
		SUM(Total) AS total_sales,
		SUM(Quantity) AS total_quantity
FROM sales
GROUP BY product_line
ORDER BY total_sales DESC, total_quantity DESC
LIMIT 3;
```

---
--Which product lines have the highest average profit margins and customer ratings?
```
SELECT product_line,
		ROUND(AVG(Ratings),2) AS avg_ratings,
		ROUND(AVG(Gross_margin),2) AS avg_profit
FROM sales
GROUP BY product_line
ORDER BY avg_ratings DESC, avg_profit DESC
LIMIT 1;
```

---
--On which days and times are sales and customer traffic the highest?
```
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
```

---
--What are the peak sales hours for each branch throughout the day?
```
SELECT branch,
	TO_CHAR(Time, 'HH24:MI') AS Hours,
	COUNT(Invoice_id) AS no_of_transactions,
	SUM(Total) AS total_sales
FROM sales 
GROUP BY branch, Hours
ORDER BY  no_of_transactions DESC, total_sales DESC;
```

---
--Which payment method is most commonly used, and how does it correlate with total sales and customer type?
```
SELECT Customer_type,
		Payment_type,
		COUNT(Invoice_id) AS total_count,
		SUM(Total) AS total_sales
FROM sales
GROUP BY customer_type, payment_type
ORDER BY total_count DESC, total_sales DESC
LIMIT 1;
```

---
--What is the average transaction value per payment method across branches?
```
SELECT Payment_type,
		branch,
		ROUND(AVG(Total),2) avg_transaction
FROM sales
GROUP BY Payment_type, branch
ORDER BY avg_transaction DESC;
```

---
--What is the average number of items purchased per transaction for each product line?
```
SELECT product_line,
		ROUND(AVG(Quantity),2) avg_no_transactions
FROM sales
GROUP BY product_line
ORDER BY avg_no_transactions DESC;
```
---
--How does profit per transaction vary across different days of the week?
```
SELECT 
	TO_CHAR(Date, 'DAY') week_count,
	ROUND(AVG(Gross_income),2) avg_profit
FROM sales
GROUP BY TO_CHAR(Date, 'DAY')
ORDER BY avg_profit DESC;
```
---
--Is there a relationship between customer ratings and total spending or profit per transaction?
```
SELECT Ratings,
		ROUND(AVG(Total),2) avg_sales,
		ROUND(AVG(Gross_income),2) avg_profit
FROM sales
GROUP BY Ratings
ORDER BY Ratings DESC;
```

---
## Insights
- **Fashion Accessories** leads all product lines in revenue and gross income.
- **Branch B** generates the highest overall sales and profit.
- **Members** spend more per transaction than normal customers.
- **Females** buy higher quantities, but males record slightly larger ticket sizes.
- Sales peak on Fridays, 18:00 – 19:00, across all branches.
- **E‑wallet** is the most commonly used payment method.
- **Branch C** recorded the highest average sales and profit per transaction.
- **Members** spend more on average than normal customers.
- **Females** tend to purchase more quantity, but **males** spend slightly more on average.

 ---
 ## Recommendations
1. Promote **Fashion Accessories** further and bundle them with other low-performing categories.
2. Investigate what makes **Branch C** outperform others and replicate its strategies across other branches.
3. Encourage customer membership programs to boost average order values.
4. Target marketing campaigns based on **gender-based** purchasing patterns.
5. Increase staffing and stock availability during **evening peak hours**.













