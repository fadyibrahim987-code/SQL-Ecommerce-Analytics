/* =====================================
   ANALYTICAL QUERIES
===================================== */

-- TOTAL_SALES

SELECT 
SUM(p.price * od.quantity) AS total_sales
FROM order_details od
JOIN products p
ON od.product_id = p.product_id;

-- QUANTITY_SOLD_PER_PRODUCT

SELECT
    P.product_name,
    P.product_id,
    SUM(OD.quantity) AS total_quantity_sold
FROM products P
JOIN order_details OD
    ON P.product_id = OD.product_id
GROUP BY
    P.product_name,
    P.product_id
ORDER BY total_quantity_sold DESC;

-- TOP-10 REVENUE QUERY


SELECT
	ROW_NUMBER() OVER (ORDER BY SUM(p.price * od.quantity) DESC) AS row_num,
    c.customer_id,
    CONCAT(c.first_name,' ',c.last_name) AS customer_name,
    SUM(p.price * od.quantity) AS revenue
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN order_details od
ON o.order_id = od.order_id
JOIN products p
ON od.product_id = p.product_id
GROUP BY c.customer_id, customer_name
ORDER BY revenue DESC
LIMIT 10;

-- REVENUE BY CATEGORY

SELECT
    p.category,
    SUM(p.price * od.quantity) AS revenue
FROM products p
JOIN order_details od
ON p.product_id = od.product_id
GROUP BY p.category
ORDER BY revenue DESC;

-- Revenue by city

SELECT
    c.city,
    SUM(p.price * od.quantity) AS revenue
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_details od
    ON o.order_id = od.order_id
JOIN products p
    ON od.product_id = p.product_id
GROUP BY city
ORDER BY revenue DESC;

-- AVERAGE ORDER VALUE

SELECT
    o.order_id,
    SUM(p.price * od.quantity) AS order_value
FROM orders o
JOIN order_details od
    ON o.order_id = od.order_id
JOIN products p
    ON od.product_id = p.product_id
GROUP BY o.order_id;

SELECT
    AVG(order_value) AS avg_order_value
FROM
(
    SELECT
        o.order_id,
        SUM(p.price * od.quantity) AS order_value
    FROM orders o
    JOIN order_details od
        ON o.order_id = od.order_id
    JOIN products p
        ON od.product_id = p.product_id
    GROUP BY o.order_id
) x;

-- Monthly Revenue Trend

SELECT
    YEAR(o.order_date) AS year_,
    MONTH(o.order_date) AS month_,
    SUM(p.price * od.quantity) AS revenue
FROM orders o
JOIN order_details od
ON o.order_id = od.order_id
JOIN products p
ON od.product_id = p.product_id
GROUP BY year_, month_
ORDER BY year_, month_;

-- RFM Scores

WITH RFM_Raw_Data AS (
    SELECT
        c.customer_id,
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        DATEDIFF(NOW(), MAX(o.order_date)) AS recency_days,
        COUNT(DISTINCT o.order_id) AS frequency_count,
        SUM(p.price * od.quantity) AS monetary_value
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN order_details od ON o.order_id = od.order_id
    JOIN products p ON od.product_id = p.product_id
    GROUP BY c.customer_id, c.first_name, c.last_name
)
SELECT 
    customer_id,
    customer_name,
    recency_days,
    frequency_count,
    monetary_value,
    
    NTILE(5) OVER (ORDER BY recency_days ASC) AS r_score,
    
    NTILE(5) OVER (ORDER BY frequency_count DESC) AS f_score,
    NTILE(5) OVER (ORDER BY monetary_value DESC) AS m_score

FROM RFM_Raw_Data;
