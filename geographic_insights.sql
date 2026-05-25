--- Customers & Geographic insights
/*Which city has the highest number of unique customer */

SELECT 
	city,
	COUNT(Distinct(store_name)) n_stores,
	COUNT(DISTINCT(customer_id)) unique_customer,
	COUNT(customer_id) n_customer

FROM chocolate_database

GROUP BY city
ORDER BY n_customer DESC
--------------------------------
-- Find the average quantities of customer's orders
SELECT *,
	(quantity/n_orders ) avg_orders

FROM(SELECT 
	customer_id, age, gender,
	COUNT(order_id) n_orders,
	SUM(quantity) quantity
FROM chocolate_database
GROUP BY customer_id, age, gender

)F ORDER BY avg_orders DESC