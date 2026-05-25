/*  Stores Preformance

1- Sales preformance
----------------------*/
--Standalon CTE
WITH Chocolate_sales as (
SELECT
	The_country , city, store_name,store_type,

	product_name, brand,customer_id,age, gender,

	order_date, order_id, quantity,unit_price, 

	revenue,cost, profit

FROM chocolate_2_sales
),
--Main aggregation - nested cte

all_aggre as (SELECT 

    order_id,
    COUNT(order_id) total_orders,
	ROUND(SUM(revenue),2) revenues,
	SUM(quantity) all_orders,
	ROUND(SUM(cost),2) costs,
	ROUND(SUM(profit),2)profits,
	COUNT(DISTINCT (order_id)) unique_orders

 FROM Chocolate_sales
 GROUP BY order_id

 )
--main query 
--Overall Scall 
--SELECT 
--SUM(total_sales) Sales,
	 --SUM(quantity) quantity
	--FROM all_aggre
-- 99 = 251651.47
--Which loctations are driving the most volume


--Average Order value aov
SELECT 
	customer_id,
	unique_orders,
	cus_order,
	round((spend/unique_orders),2) cu_spends,
	spend

FROM(SELECT 
	ch.customer_id,ch.gender,ch.age,
	sum(all_orders) cus_order,
	COUNT(DISTINCT(al.order_id)) unique_orders,
	SUM(al.revenues) spend

FROM Chocolate_sales ch
LEFT JOIN all_aggre al
ON ch.order_id = al.order_id
GROUP BY customer_id,gender,age)F
ORDER BY spend desc