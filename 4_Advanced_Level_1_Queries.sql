-- Q1. Calculate the average order value for different customer segments based on their total spending.

SELECT AVG(payment_value) AS average_payment, CASE WHEN payment_value < 300 THEN "LOW"
						   WHEN payment_value BETWEEN 300 AND 500 THEN "MEDIUM"
						   ELSE "HIGH" END AS income_segment 
FROM order_payment
GROUP BY income_segment;


-- Q2. Identify common product combinations bought together.

SELECT oi1.product_id AS product1, oi2.product_id AS product2, COUNT(*) AS purchase_count
FROM order_items AS oi1
JOIN order_items AS oi2 ON oi1.order_id = oi2.order_id AND oi1.product_id < oi2.product_id
GROUP BY product1, product2
ORDER BY purchase_count DESC;


-- Q3. Calculate the average delivery time for orders in each state.

SELECT customer_state, AVG(DATEDIFF(order_delivered_customer_date, order_purchase_timestamp)) AS avg_delivery_time
FROM customers AS c
JOIN orders AS o ON c.customer_id = o.customer_id
GROUP BY customer_state;


-- Q4. Determine the most popular payment method for each state.

SELECT payment_type, customer_state, COUNT(*) AS payments
FROM customers AS c
JOIN orders AS o ON c.customer_id = o.customer_id
JOIN order_payment AS p ON o.order_id = p.order_id
GROUP BY customer_state, payment_type
ORDER BY customer_state, payments DESC;


-- Q5. Analyze the distribution of order statuses.

SELECT order_status, COUNT(*) AS total_orders
FROM orders
GROUP BY order_status;


-- Q6. Calculate the average review score for each seller.

SELECT s.seller_id, AVG(review_score) AS avg_score
FROM sellers AS s
JOIN order_items AS i ON i.seller_id = s.seller_id
JOIN order_review AS r ON r.order_id = i.order_id
GROUP BY s.seller_id
ORDER BY avg_score DESC;


-- Q7. Calculate the percentage distribution of total revenue generated by the top 10 sellers.

SELECT s.seller_id, (SUM(payment_value)/(SELECT SUM(payment_value) FROM order_payment) * 100) AS percent_contribution
FROM sellers AS s
JOIN order_items AS i ON i.seller_id = s.seller_id
JOIN order_payment AS p ON p.order_id = i.order_id
GROUP BY s.seller_id
ORDER BY percent_contribution DESC LIMIT 10;


-- Q8. Calculate the average order value for each state.

SELECT customer_state, AVG(payment_value) AS avg_order_value
FROM customers AS c 
JOIN orders AS o ON c.customer_id = o.customer_id
JOIN order_payment AS p ON p.order_id = o.order_id
GROUP BY customer_state;


-- Q9. Segment customers based on their purchase frequency.

SELECT COUNT(customer_id), CASE WHEN order_count = 1 THEN 'One-time'
				WHEN order_count BETWEEN 1 AND 5 THEN 'Occasional'
				ELSE 'Frequent' END AS purchase_frequency
FROM (SELECT customer_id, COUNT(*) AS order_count
	  FROM orders
	  GROUP BY customer_id) AS customer_orders
GROUP BY purchase_frequency;


-- Q10. Calculate the average review score for each product category.

SELECT product_category_name, AVG(review_score) AS avg_review
FROM order_review AS r
JOIN order_items AS o ON r.order_id = o.order_id
JOIN products AS p ON p.product_id = o.product_id
GROUP BY product_category_name;


-- Q11. Calculate the month-over-month revenue growth rate.

SELECT month, revenue, (revenue - LAG(revenue) OVER (ORDER BY month)) / LAG(revenue) OVER (ORDER BY month) * 100 AS growth_rate
FROM
	(SELECT DATE_FORMAT(order_purchase_timestamp, '%Y-%m') AS month, SUM(payment_value) AS revenue
	 FROM orders AS o
	 JOIN order_payment AS p ON o.order_id = p.order_id
	 GROUP BY month) AS monthly_revenue;


-- Q12. Identify products that have not been sold in the last 6 year.

SELECT p.product_id, order_purchase_timestamp
FROM orders AS o 
JOIN order_items AS i ON o.order_id = i.order_id
JOIN products AS p ON p.product_id = i.product_id
WHERE order_purchase_timestamp <= now() - INTERVAL 6 YEAR;                                -- (NOTE: Dataset latest upto 2018 only)


-- Q13. Calculate the customer retention rate over the past 6 years.

SELECT (COUNT(DISTINCT CASE WHEN order_purchase_timestamp >= NOW() - INTERVAL 6 YEAR THEN customer_id END)
	/COUNT(DISTINCT customer_id)) * 100 AS retention_rate
FROM orders;

																 -- OR
SELECT (SELECT COUNT(DISTINCT customer_id)
	FROM orders
        WHERE order_purchase_timestamp >= NOW() - INTERVAL 6 YEAR)
     / (SELECT COUNT(DISTINCT customer_id) FROM orders) * 100
AS retention_rate;


-- Q14. Analyze the average review score based on the order status.

SELECT order_status, AVG(review_score) AS avg_score
FROM orders AS o
JOIN order_review AS r ON o.order_id = r.order_id
GROUP BY order_status
ORDER BY avg_score DESC;


-- Q15. Calculate the total revenue for each geolocation.

SELECT g.geolocation_city, SUM(payment_value) AS revenue
FROM geolocation AS g
JOIN customers AS c ON c.customer_zip_code_prefix = g.geolocation_zip_code_prefix
JOIN orders AS o ON o.customer_id = c.customer_id
JOIN order_payment AS p ON p.order_id = o.order_id
GROUP BY g.geolocation_city;


-- Q16. Identify the top 10 most reviewed products.

SELECT p.product_id, COUNT(*) AS review_count
FROM products AS p
JOIN order_items AS i ON i.product_id = p.product_id
JOIN orders AS o ON o.order_id = i.order_id
GROUP BY product_id
ORDER BY review_count DESC LIMIT 10;


-- Q17. Calculate the average number of orders per customer.

SELECT AVG(order_count) AS avg_order
FROM (SELECT customer_id, COUNT(*) AS order_count
      FROM orders
      GROUP BY customer_id) AS customer_orders;


-- Q18. Analyze the distribution of revenue by payment type.

SELECT payment_type, SUM(payment_value) AS revenue
FROM order_payment
GROUP BY payment_type;


-- Q19. Calculate the number of orders for each product category.

SELECT product_category_name, COUNT(*) AS total_orders
FROM orders AS o
JOIN order_items AS i ON i.order_id = o.order_id
JOIN products AS p ON p.product_id = i.product_id
GROUP BY product_category_name;


-- Q20. Analyze the distribution of customers by geolocation.

SELECT g.geolocation_state, g.geolocation_city, COUNT(c.customer_id) AS total_customers
FROM geolocation AS g
JOIN customers AS c ON c.customer_zip_code_prefix = g.geolocation_zip_code_prefix
GROUP BY g.geolocation_state, g.geolocation_city;
