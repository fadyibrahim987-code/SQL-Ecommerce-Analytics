-- VIEW CREATION

-- Sales Team View

CREATE VIEW customer_sales AS
SELECT
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
GROUP BY c.customer_id, customer_name;

SELECT * FROM customer_sales;

-- Inventory/Merchandising Team

CREATE VIEW product_performance_summary AS
SELECT 
    p.product_id,
    p.product_name,
    SUM(od.quantity) AS total_units_sold,
    SUM(p.price * od.quantity) AS total_revenue
FROM products p
JOIN order_details od 
    ON p.product_id = od.product_id
GROUP BY p.product_id, p.product_name;

SELECT *
 FROM product_performance_summary
 ORDER BY total_units_sold DESC LIMIT 5;
 
 -- Operations/Shipping Team
 
 CREATE VIEW order_fulfillment_log AS
SELECT 
    o.order_id,
    o.order_date,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    c.city
FROM orders o
JOIN customers c 
    ON o.customer_id = c.customer_id;
    
    select *
    from order_fulfillment_log;
