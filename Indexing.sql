-- Indexing & Performance

EXPLAIN 
SELECT c.customer_id, SUM(p.price * od.quantity) AS revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_details od ON o.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
GROUP BY c.customer_id;

CREATE INDEX idx_orders_customer ON orders(customer_id);
CREATE INDEX idx_details_order_product ON order_details(order_id, product_id);

EXPLAIN 
SELECT c.customer_id, SUM(p.price * od.quantity) AS revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_details od ON o.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
GROUP BY c.customer_id;
