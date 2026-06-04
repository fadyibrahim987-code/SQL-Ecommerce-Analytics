-- STORED PROCEDURE

DELIMITER //

CREATE PROCEDURE GetCustomerRevenue(IN cust_id INT)
BEGIN
    SELECT
        SUM(p.price * od.quantity) AS revenue
    FROM orders o
    JOIN order_details od
        ON o.order_id = od.order_id
    JOIN products p
        ON od.product_id = p.product_id
    WHERE o.customer_id = cust_id;
END //

DELIMITER ;

CALL GetCustomerRevenue(5);

---------------------------

DELIMITER //

CREATE PROCEDURE GetMonthlyRevenue(IN target_year INT, IN target_month INT)
BEGIN
    SELECT
        SUM(p.price * od.quantity) AS monthly_revenue
    FROM orders o
    JOIN order_details od
        ON o.order_id = od.order_id
    JOIN products p
        ON od.product_id = p.product_id
    WHERE YEAR(o.order_date) = target_year 
      AND MONTH(o.order_date) = target_month;
END //

DELIMITER ;

CALL GetMonthlyRevenue(2024, 4);

---------------------------------

DELIMITER //

CREATE PROCEDURE GetRevenueByCity(IN target_city VARCHAR(100))
BEGIN
    SELECT
        c.city,
        SUM(p.price * od.quantity) AS city_revenue
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN order_details od
        ON o.order_id = od.order_id
    JOIN products p
        ON od.product_id = p.product_id
    WHERE c.city = target_city
    GROUP BY c.city;
END //

DELIMITER ;

CALL GetRevenueByCity('cairo');
