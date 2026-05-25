/* FINALE STEP 
 create 2 tabels one for tracking monthly sales
 the other to show customers behivur  */
--select * from chocolate_database
--CTE standalon

WITH monthly_sales AS (SELECT 
	YEAR(order_date) a_year,
	MONTH(order_date) a_month,
	city , store_name ,
	count((customer_id)) total_cust,
	COUNT(order_id) total_orders,
	ROUND(SUM(quantity),2) quantity,
	ROUND(SUM(revenue),2) total_sales,
	ROUND(SUM(cost),2) total_cost,
	ROUND(SUM(profit),2) profits
	
FROM chocolate_database
GROUP BY City , store_name ,YEAR(order_date) ,
	MONTH(order_date) )


--main query +subquery
SELECT *


FROM(SELECT *,

	SUM(total_sales) OVER(PARTITION BY city) total_sales_by_city,
	SUM(total_cost) OVER(PARTITION BY city) total_cost_by_city


FROM monthly_sales) F
ORDER BY a_year, a_month, store_name
