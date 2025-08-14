
ACTIVITY 1 DATTA LOADING 

Create database Customers;
Use Customers;
Select * from Customers;


Create database Products;
Use Products;
Select * from Products;


Create database Sales;
Use Sales;
Select * from Sales

Create database City;
Use City
Select * from City;

ACTIVITY 2: DATTA Cleaning & Preprocessing

SELECT COUNT(*) FROM customers WHERE customer_id IS NULL OR customer_name IS NULL OR city_id IS NULL; 
SELECT COUNT(*) FROM products WHERE product_id IS NULL OR product_name IS NULL OR price IS NULL;
SELECT COUNT(*) FROM sales WHERE quantity IS NULL OR total_amount IS NULL OR sale_date IS NULL;

How can you check for duplicate entries in the customers table?

SELECT customer_id, COUNT(*) FROM customers GROUP BY customer_id HAVING COUNT(*) > 1;


    
How to check for Mismatch total_amount and the Calculated value price * quantity

SELECT s.sale_id, p.price, s.quantity, s.total_amount
FROM sales s
JOIN products p ON s.product_id = p.product_id
WHERE ROUND(s.total_amount, 2) <> ROUND(p.price * s.quantity, 2);

ACTIVITY 3: DATTA TRANSFORMATION & INTEGRATION
How do you create a comprehensive sales report with customer and product details?

SELECT 
    s.sale_id,
    s.sale_date,
    c.customer_id,
    c.customer_name,
    c.city,
    p.product_id,
    p.product_name,
    p.price,
    s.quantity,
    s.total_amount,
    p.rating
FROM sales s
JOIN customers c ON s.customer_id = c.customer_id
JOIN products p ON s.product_id = p.product_id;


Activity 4: DATTS ANALYSIS & AGGREGATION

(a) Total Sales per City 

SELECT c.city, SUM(s.total_amount) AS total_sales
FROM sales s JOIN customers c ON s.customer_id = c.customer_id
GROUP BY c.city ORDER BY total_sales DESC;

(b) Total Transactions per City

SELECT c.city, COUNT(s.sale_id) AS total_transactions
FROM sales s JOIN customers c ON s.customer_id = c.customer_id
GROUP BY c.city ORDER BY total_transactions DESC

(c) Unique Customers per City

SELECT c.city, COUNT(DISTINCT s.customer_id) AS unique_customers
FROM sales s JOIN customers c ON s.customer_id = c.customer_id
GROUP BY c.city ORDER BY unique_customers DESC;

(d) Average Order Value per City

SELECT c.city, AVG(s.total_amount) AS avg_order_value
FROM sales s
JOIN customers c ON s.customer_id = c.customer_id
GROUP BY c.city
ORDER BY avg_order_value DESC;

(e) Product Demand per City

SELECT c.city, p.product_name, SUM(s.quantity) AS total_quantity
FROM sales s
JOIN customers c ON s.customer_id = c.customer_id
JOIN products p ON s.product_id = p.product_id
GROUP BY c.city, p.product_name
ORDER BY c.city, total_quantity DESC;

(f) Monthly Sales Trend

SELECT DATE_FORMAT(s.sale_date, '%Y-%m') AS month, SUM(s.total_amount) AS monthly_sales
FROM sales s GROUP BY month ORDER BY month;

g) Customer Rating Analysis

SELECT c.city, AVG(p.rating) AS avg_rating
FROM sales s
JOIN customers c ON s.customer_id = c.customer_id
JOIN products p ON s.product_id = p.product_id
GROUP BY c.city ORDER BY avg_rating DESC;


ACTIVITY 5: DECISION -MAKING & RECOMMENDATIONS 

(a) Top Cities Selection

SELECT c.city,
SUM(s.total_amount) AS total_sales,
COUNT(DISTINCT s.customer_id) AS unique_customers,
COUNT(s.sale_id) AS order_count
FROM sales s JOIN customers c ON s.customer_id = c.customer_id
GROUP BY c.city ORDER BY total_sales DESC, unique_customers DESC, order_count DESC 
LIMIT 3;


(b) Final Recommendations are :

   1. Significant sales volume

   2. large number of distinct customers

   3. Elevated transaction counts

   4. Consistently high ratings

   5  Favorable monthly trends


