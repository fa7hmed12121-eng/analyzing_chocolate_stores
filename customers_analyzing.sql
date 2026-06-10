
/*--------------------------------
	CTEs 
-- customers sales
-- Find the average quantities of customer's orders

-----------------------------------*/
WITH customers_behivor AS (

	 SELECT
	customer_id,
	COUNT(order_id)total_orders,
	SUM(quantity) quantity, 
	ROUND(SUM(revenue),2) total_sales, 
	ROUND(SUM(cost),2) cost,
	ROUND(SUM(profit),2) profits
From chocolate_database
GROUP BY customer_id
),


--- Second CTE
average_days_customers as (SELECT 
	customer_id,
	avg_spending,
	DATEDIFF(day,order_date, next_order) days_of_orders
FROM(SELECT 
	customer_id,
	order_date ,
	AVG(revenue) OVER(PARTITION BY customer_id) avg_spending,
	LEAD(order_date) OVER(PARTITION BY customer_id ORDER BY order_date)next_order

FROM chocolate_database )f
),

-- Nested CTE

customers_sales AS (

	SELECT 
	t.customer_id,t.age, t.gender, t.loyalty_member,t.join_date, avg_spending,
	b.total_orders, b.quantity, b.total_sales,t.customer_retention

FROM(SELECT
	customer_id, age, gender, loyalty_member, join_date,avg_spending,
	AVG(days_of_orders) customer_retention

FROM(

	SELECT 
		c.customer_id ,c.age, c.gender,c.loyalty_member,c.join_date,
		av.avg_spending,av.days_of_orders
	


	from average_days_customers av
	LEFT JOIN customers c
	ON c.customer_id = av.customer_id

)f
GROUP BY 	customer_id, age, gender, loyalty_member, join_date, avg_spending)t

LEFT JOIN customers_behivor b
ON b.customer_id = t.customer_id),



--Third CTE 
customer_favoirate_product AS (SELECT *
FROM( SELECT 
	customer_id,
	product_name,
	COUNT(*) purchase_time,
	ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY COUNT(*) DESC) numbers
FROM chocolate_database

GROUP BY customer_id, product_name )f
WHERE numbers = 1)

-- Main query
SELECT
	s.customer_id, s.age, s.gender, s.loyalty_member, 
	s.join_date,c.product_name,s.avg_spending, s.total_orders, 
	s.quantity, s.total_sales, s.customer_retention

from customers_sales s
LEFT JOIN customer_favoirate_product c
ON s.customer_id = c.customer_id
ORDER BY customer_retention

