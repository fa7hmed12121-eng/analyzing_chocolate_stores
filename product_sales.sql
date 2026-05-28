---- Products Sales
---CTE Multiples

SELECT
	city,
	FORMAT(order_date, 'ddd-MM-yyyy') date,
	brand,
	product_name,
	COUNT(order_id) total_orders,
	SUM(quantity) quantity,
	ROUND(SUM(revenue),2) total_sales,
	ROUND(SUM(cost),2) cost,
	ROUND(SUM(profit),2) profits

FROM chocolate_database

WHERE product_name IS NOT NULL
GROUP BY city, brand, product_name, FORMAT(order_date, 'ddd-MM-yyyy') 
ORDER BY date