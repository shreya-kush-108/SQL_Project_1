-- Q41. Top 5 Most Expensive Products using a CTE

WITH product_prices AS (SELECT product_id, price FROM order_items)

SELECT product_id, price
FROM product_prices
ORDER BY price DESC LIMIT 5;


-- Q42. Average Review Score by Product Category using a CTE

WITH review_scores AS (SELECT p.product_category_name, r.review_score
			FROM products AS p
			JOIN order_items i ON p.product_id = i.product_id
			JOIN order_review r ON i.order_id = r.order_id)
                        
SELECT product_category_name, AVG(review_score) AS avg_review_score
FROM review_scores
GROUP BY product_category_name;


-- Q43. Orders and Payments Summary using a CTE

WITH orders_summary AS (SELECT o.order_id, o.order_status, p.payment_value
			FROM orders AS o
			JOIN order_payment AS p ON o.order_id = p.order_id)

SELECT order_status, COUNT(*) AS total_orders, SUM(payment_value) AS total_revenue
FROM orders_summary
GROUP BY order_status;


-- Q44. Customer Spending Above Average using a CTE

WITH 
	customer_spending AS (SELECT customer_id, SUM(payment_value) AS total_spent
				FROM order_payment AS p
				JOIN orders AS o ON p.order_id = o.order_id
	       		        GROUP BY customer_id),

	avg_spending AS (SELECT AVG(total_spent) AS avg_spent
			FROM customer_spending)
                 
SELECT cs.customer_id, cs.total_spent
FROM customer_spending AS cs
CROSS JOIN avg_spending
WHERE cs.total_spent > avg_spent;


-- Q45. Monthly Revenue Growth using a CTE

WITH monthly_revenue AS (SELECT DATE_FORMAT(order_purchase_timestamp, '%Y-%m') AS month, SUM(payment_value) AS total_revenue
			 FROM orders AS o
			 JOIN order_payment AS p ON o.order_id = p.order_id
			 GROUP BY month)
                         
SELECT month, total_revenue, 
		(total_revenue - LAG(total_revenue) OVER (ORDER BY month)) / LAG(total_revenue) OVER (ORDER BY month) * 100 AS growth_rate
FROM monthly_revenue;

