CREATE DATABASE Project_1;                                           -- DATABASE named "Project_1" created.

USE Project_1;                                                       -- Set database as default for further actions.

CREATE TABLE customers                                               -- Tables created. 
(customer_id char(255),
 customer_unique_id char(255),
 customer_zip_code_prefix char(255),
 customer_city char(50),
 customer_state char(50));

CREATE TABLE order_items
(order_id char(50),
 order_item_id int8,
 product_id char(50),
 seller_id char(50),
 shipping_limit_date char(50),
 price float4,
 freight_value float4);

CREATE TABLE order_payment
(order_id char(50),
 payment_sequential int8,
 payment_type char(50),
 payment_installments int4,
 payment_value float4);

CREATE TABLE order_review
(review_id char(50),
 order_id char(50),
 review_score int1,
 review_comment_title char(255),
 review_comment_message text,
 review_creation_date char(50),
 review_creation_timestamp char(50));

CREATE TABLE orders
(order_id char(50),
 customer_id char(255),
 order_status char(50),
 order_purchase_timestamp char(50),
 order_approved_at char(50),
 order_delivered_carrier_date char(50),
 order_delivered_customer_date char(50),
 order_delivery_estimate_date char(50));

CREATE TABLE sellers
(seller_id char(50),
 seller_zip_code_prefix bigint,
 seller_city char(50),
 seller_state char(50));

CREATE TABLE products
(product_id char(50),
 product_category_name char(50),
 product_name_length char(10),
 product_description_length char(10),
 product_photos_qty char(10),
 product_weight_g char(10),
 product_lenght_cm char(10),
 product_height_cm char(10),
 product_width_cm char(10));

SELECT * FROM customers;                                             -- All Tables can be viewed from here.
SELECT * FROM geolocation;
SELECT * FROM order_payment;
SELECT * FROM order_items;
SELECT * FROM order_review;
SELECT * FROM orders;
SELECT * FROM products;
SELECT * FROM sellers;

# IMPORTED BULK CSV DATA TABLES USING "LOAD DATA INFILE" COMMAND. EXAMPLE GIVEN BELOW:

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_geolocation_dataset.csv' INTO TABLE geolocation
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
IGNORE 1 ROWS;



