-- Q1. Identify the top 5 sellers based on the number of orders fulfilled.

SELECT seller_id, COUNT(*) AS orders_fulfilled 
FROM order_items
GROUP BY seller_id 
ORDER BY orders_fulfilled DESC LIMIT 5;


-- Q2. What is the average review score for each product?

SELECT product_id, AVG(review_score) AS average_score 
FROM order_review AS r 
JOIN order_items AS i ON r.order_id = i.order_id
GROUP BY product_id;


-- Q3. Calculate the total spending of each customer.

SELECT customer_id, SUM(payment_value) AS amount_spent
FROM orders AS o
JOIN order_payment AS p ON o.order_id = p.order_id
GROUP BY customer_id;


-- Q4. What is the total revenue generated by each product category?

SELECT product_category_name, SUM(payment_value) AS total_revenue
FROM order_payment AS op
JOIN order_items AS i ON op.order_id = i.order_id
JOIN products AS p ON p.product_id = i.product_id
GROUP BY product_category_name;


-- Q5. Calculate the percentage of customers who have not made a purchase in the last year.

SELECT((SELECT COUNT(DISTINCT customer_id) FROM orders) - 
       (SELECT COUNT(DISTINCT customer_id) FROM orders 
        WHERE NOW() - INTERVAL 1 YEAR <= order_purchase_timestamp)) 
		/(SELECT COUNT(DISTINCT customer_id) FROM orders) * 100 
AS churn_rate;

															#OR

SELECT (SELECT COUNT(DISTINCT customer_id) FROM orders WHERE NOW() - INTERVAL 1 YEAR > order_purchase_timestamp)
		/(SELECT COUNT(DISTINCT customer_id) FROM orders) * 100 
AS churn_rate;

															#OR

SELECT COUNT(DISTINCT customer_id) / (SELECT COUNT(DISTINCT customer_id) FROM orders) * 100 AS churn_rate
FROM orders 
WHERE NOW() - INTERVAL 1 YEAR > order_purchase_timestamp;


-- Q6. Analyze monthly sales trends.

SELECT DATE_FORMAT(order_purchase_timestamp, '%Y-%m') AS month, SUM(payment_value) AS monthly_sales
FROM orders AS o
JOIN order_payment AS p ON o.order_id = p.order_id
GROUP BY month
ORDER BY monthly_sales;


-- Q7. Calculate the percentage of orders delivered on or before the estimated delivery date.

SELECT COUNT(*) / (SELECT COUNT(*) FROM orders) * 100 AS timely_delivery_rate
FROM orders
WHERE order_delivered_customer_date <= order_delivery_estimate_date;


-- Q8. Identify customers who have made more than one purchase.

SELECT customer_id, COUNT(*) AS number_of_orders
FROM orders
GROUP BY customer_id
HAVING number_of_orders > 1;


-- Q9. Analyze the distribution of review scores.

SELECT review_score, COUNT(*) AS review_count
FROM order_review
GROUP BY review_score
ORDER BY review_score;


-- Q10. Identify the top 10 products based on sales revenue.

SELECT p.product_id, SUM(payment_value) AS total_revenue
FROM order_payment AS op
JOIN order_items AS i ON op.order_id = i.order_id
JOIN products AS p ON p.product_id = i.product_id
GROUP BY p.product_id
ORDER BY total_revenue DESC LIMIT 10;