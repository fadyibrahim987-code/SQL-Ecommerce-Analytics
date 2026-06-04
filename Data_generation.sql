/* =====================================
   CUSTOMER DATA GENERATION
===================================== */

DELIMITER $$

CREATE PROCEDURE generate_customers()
BEGIN
    DECLARE i INT DEFAULT 1;

    WHILE i <= 100 DO

        INSERT INTO customers (
            customer_id,
            first_name,
            last_name,
            city,
            signup_date
        )
        VALUES (
            i,
            CONCAT('Customer', i),
            CONCAT('User', i),
            ELT(
                1 + FLOOR(RAND() * 8),
                'Cairo',
                'Giza',
                'Alexandria',
                'Mansoura',
                'Tanta',
                'Zagazig',
                'Luxor',
                'Aswan'
            ),
            DATE_ADD(
                '2023-01-01',
                INTERVAL FLOOR(RAND() * 700) DAY
            )
        );

        SET i = i + 1;

    END WHILE;

END $$

DELIMITER ;

CALL generate_customers();

/* =====================================
   PRODUCT DATA INSERTION
===================================== */

INSERT INTO products VALUES
(1,'Laptop','Electronics',25000),(2,'Mouse','Electronics',350),(3,'Keyboard','Electronics',700),
(4,'Monitor','Electronics',4500),(5,'Desk Chair','Furniture',3200),(6,'Desk','Furniture',5500),
(7,'Notebook','Stationery',50),(8,'Pen Pack','Stationery',40),(9,'Headphones','Electronics',1200),
(10,'Webcam','Electronics',900),(11,'Gaming Laptop','Electronics',35000),(12,'Office Laptop','Electronics',18000),
(13,'Mechanical Keyboard','Electronics',1500),(14,'Gaming Mouse','Electronics',900),(15,'USB Hub','Electronics',300),
(16,'SSD 1TB','Electronics',4500),(17,'External HDD','Electronics',3200),(18,'Smart Watch','Electronics',5500),
(19,'Bluetooth Speaker','Electronics',1800),(20,'Phone Stand','Accessories',120),(21,'Desk Lamp','Furniture',450),
(22,'Bookshelf','Furniture',2500),(23,'Whiteboard','Office',850),(24,'Office Chair Pro','Furniture',4200),
(25,'Monitor 24 Inch','Electronics',5200),(26,'Monitor 27 Inch','Electronics',7800),(27,'Webcam HD','Electronics',1200),
(28,'Microphone USB','Electronics',1700),(29,'Graphics Tablet','Electronics',2900),(30,'Printer','Office',3500),
(31,'Ink Cartridge','Office',400),(32,'Paper Pack','Office',150),(33,'Calculator','Office',200),
(34,'Notebook A4','Stationery',40),(35,'Notebook Premium','Stationery',90),(36,'Pen Blue','Stationery',10),
(37,'Pen Black','Stationery',10),(38,'Marker Set','Stationery',80),(39,'Stapler','Office',75),
(40,'Power Bank','Accessories',650),(41,'USB Cable','Accessories',90),(42,'Wireless Charger','Accessories',500),
(43,'Router','Electronics',1300),(44,'Ethernet Cable','Electronics',120),(45,'Coffee Mug','Accessories',100),
(46,'Water Bottle','Accessories',150),(47,'Backpack','Accessories',750),(48,'Tablet','Electronics',9000),
(49,'Smartphone','Electronics',15000),(50,'Projector','Electronics',12000);

/* =====================================
   ORDER DATA GENERATION
===================================== */

DELIMITER $$

CREATE PROCEDURE generate_orders()
BEGIN
    DECLARE i INT DEFAULT 1;
    WHILE i <= 1000 DO
        INSERT INTO orders VALUES (
            i,
            FLOOR(1 + RAND()*100),
            DATE_ADD('2024-01-01', INTERVAL FLOOR(RAND()*365) DAY)
        );
        SET i = i + 1;
    END WHILE;
END $$

/* =====================================
   ORDER DETAILS GENERATION
===================================== */

CREATE PROCEDURE generate_order_details()
BEGIN
    DECLARE i INT DEFAULT 1;
    WHILE i <= 3000 DO
        INSERT INTO order_details VALUES (
            i,
            FLOOR(1 + RAND()*1000),
            FLOOR(1 + RAND()*50),
            FLOOR(1 + RAND()*5)
        );
        SET i = i + 1;
    END WHILE;
END $$

DELIMITER ;

CALL generate_orders();
CALL generate_order_details();

/* =====================================
   DATA VALIDATION
===================================== */

SELECT COUNT(*)  as count_customer FROM customers ;
SELECT COUNT(*) as count_products FROM products ;
SELECT COUNT(*) as count_orders FROM orders ;
SELECT COUNT(*) as count_order_details FROM order_details ;
