/* FINALE STEP 
 create 2 tabels one for tracking monthly sales
 the other to show customers behivur  */
--select * from chocolate_database
--CTE standalon

WITH monthly_sales AS (SELECT 
	FORMAT( order_date, 'MM-yyyy') date_order,
	city , store_name ,
	count((customer_id)) total_cust,
	COUNT(order_id) total_orders,
	ROUND(SUM(quantity),2) quantity,
	ROUND(SUM(revenue),2) total_sales,
	ROUND(SUM(cost),2) total_cost,
	ROUND(SUM(profit),2) profits
	
FROM chocolate_database
GROUP BY City , store_name , FORMAT( order_date, 'MM-yyyy'))


--main query +subquery
SELECT *

FROM monthly_sales
ORDER BY store_name
