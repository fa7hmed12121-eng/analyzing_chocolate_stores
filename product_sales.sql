---- Products Sales
---CTE 

SELECT
	FORMAT(order_date, 'dd-MMM-yyyy') date,
	brand,
	product_name,
	COUNT(order_id) total_orders,
	SUM(quantity) quantity,
	ROUND(SUM(revenue),2) total_sales,
	ROUND(SUM(cost),2) cost,
	ROUND(SUM(profit),2) profits

FROM chocolate_database

WHERE  FORMAT(order_date, 'dd-MMM-yyyy')  IS not NULL
GROUP BY  brand, product_name, FORMAT(order_date, 'dd-MMM-yyyy') 
ORDER BY date