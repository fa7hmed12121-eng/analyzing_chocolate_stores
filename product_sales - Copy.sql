---- Products Sales
---CTE Multiples

SELECT
	brand,
	product_name,
	COUNT(order_id) total_orders,
	SUM(quantity) quantity,
	ROUND(SUM(revenue),2) total_sales,
	ROUND(SUM(profit),2) profits

FROM chocolate_database
GROUP BY brand, product_name
ORDER BY product_name