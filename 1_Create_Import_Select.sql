CREATE DATABASE Project_1;                                           -- DATABASE named "Project_1" created.

USE Project_1;                                                       -- Set database as default for further actions.

CREATE TABLE customers                                               -- Tables created. 
(customer_id VARCHAR(50) PRIMARY KEY,
 customer_unique_id VARCHAR(50),
 customer_zip_code_prefix CHAR(50),
 customer_city CHAR(50),
 customer_state CHAR(50));

CREATE TABLE geolocation
(geolocation_zip_code_prefix CHAR(50),
 geolocation_lat DOUBLE,
 geolocation_lng DOUBLE,
 geolocation_city CHAR(50),
 geolocation_state CHAR(50));

CREATE TABLE orders
(order_id VARCHAR(50) PRIMARY KEY,
 customer_id VARCHAR(50),
 order_status CHAR(50),
 order_purchase_timestamp CHAR(50),
 order_approved_at CHAR(50),
 order_delivered_carrier_date CHAR(50),
 order_delivered_customer_date CHAR(50),
 order_delivery_estimate_date CHAR(50),
 FOREIGN KEY (customer_id) REFERENCES customers(customer_id));

CREATE TABLE sellers
(seller_id VARCHAR(50) PRIMARY KEY,
 seller_zip_code_prefix CHAR(50),
 seller_city CHAR(50),
 seller_state CHAR(50));

CREATE TABLE products
(product_id VARCHAR(50) PRIMARY KEY,
 product_category_name CHAR(50),
 product_name_length CHAR(10),
 product_description_length CHAR(10),
 product_photos_qty CHAR(10),
 product_weight_g CHAR(10),
 product_lenght_cm CHAR(10),
 product_height_cm CHAR(10),
 product_width_cm CHAR(10));

CREATE TABLE order_items
(order_id VARCHAR(50),
 order_item_id BIGINT,
 product_id VARCHAR(50),
 seller_id VARCHAR(50),
 shipping_limit_date CHAR(50),
 price FLOAT,
 freight_value FLOAT,
PRIMARY KEY (order_id, product_id),
FOREIGN KEY (order_id) REFERENCES orders(order_id),
FOREIGN KEY (product_id) REFERENCES products(product_id),
FOREIGN KEY (seller_id) REFERENCES sellers(seller_id));

CREATE TABLE order_payment
(order_id VARCHAR(50),
 payment_sequential BIGINT,
 payment_type CHAR(50),
 payment_installments INT,
 payment_value FLOAT,
 PRIMARY KEY (order_id, payment_sequential),
 FOREIGN KEY (order_id) REFERENCES orders(order_id));

CREATE TABLE order_review
(review_id VARCHAR(50),
 order_id VARCHAR(50),
 review_score TINYINT,
 review_comment_title CHAR(255),
 review_comment_message TEXT,
 review_creation_date CHAR(50),
 review_creation_timestamp CHAR(50),
 PRIMARY KEY (review_id, order_id),
 FOREIGN KEY (order_id) REFERENCES orders(order_id));



SELECT * FROM customers;                                             -- All Tables can be viewed from here.
SELECT * FROM geolocation;
SELECT * FROM order_payment;
SELECT * FROM order_items;
SELECT * FROM order_review;
SELECT * FROM orders;
SELECT * FROM products;
SELECT * FROM sellers;

-- IMPORTED BULK CSV DATA TABLES USING THE "LOAD DATA INFILE" COMMAND. EXAMPLE GIVEN BELOW:

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_geolocation_dataset.csv' INTO TABLE geolocation
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
IGNORE 1 ROWS;



