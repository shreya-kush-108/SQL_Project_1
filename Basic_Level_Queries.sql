-- Q1. List all customer details.

SELECT * FROM customers;


-- Q2. How many orders have been placed?

SELECT COUNT(*) AS total_orders 
FROM orders;


-- Q3. Retrieve all product details.

SELECT * FROM products;


-- Q4. How many products are there in the inventory?

SELECT COUNT(*) AS total_inventory 
FROM products;


-- Q5. List the number of orders for each payment type.

SELECT payment_type, COUNT(*) AS number_of_orders 
FROM order_payment 
GROUP BY payment_type;


-- Q6. List the top 5 product categories by the number of products.

SELECT product_category_name, COUNT(*) AS number_of_products 
FROM products 
GROUP BY product_category_name 
ORDER BY number_of_products DESC LIMIT 5;


-- Q7. What is the total revenue generated from all orders?

SELECT SUM(payment_value) AS total_revenue 
FROM order_payment;


-- Q8. What is the average value of all orders?

SELECT AVG(payment_value) AS average_payment 
FROM order_payment;


-- Q9. List the number of orders from each customer state.

SELECT customer_state, COUNT(*) AS number_of_orders 
FROM customers
GROUP BY customer_state;


-- Q10. What is the average delivery time for orders?

SELECT AVG(DATEDIFF(order_delivered_customer_date, order_purchase_timestamp)) AS average_delivery_time
FROM orders;
