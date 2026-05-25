--- CUSTOMER RETERATION
--Find which stores selling most efficiently
---Standalone query

WITH Sales_aggre AS
(SElECT 
	city,
	store_name,
	ROUND(SUM(profit),2) profits,
	ROUND(SUM(revenue),2) revenues,
	ROUND(SUM(cost),2) costs

FROM chocolate_2_sales
GROUP BY store_name, city
)
--Main query
--Subquery
SELECT *,
CONCAT(ROUND((costs/revenues)*100,1),'%') stores_cost,
CONCAT(ROUND((profits/revenues) *100,1), '%') Store_sells

FROM (SELECT 

* 
FROM Sales_aggre S

)F
-- 
SELECT 
order_id,
quantity,
unit_price,
revenue,
CONCAT(CAST(ROUND((ne_discount),2) AS FLOAT) /100, '%') dicount,
cost

FROM(SELECT 
	order_id,
	quantity,

	unit_price,
	REPLACE(discount,':','') ne_discount,
	revenue,
	cost,
	profit
FROM chocolate_database)F
ORDER BY revenue