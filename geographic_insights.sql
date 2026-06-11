--- Customers & Geographic insights
/*Which city has the highest number of unique customer */

SELECT 
	year(order_date) The_year,
	city,
	COUNT(Distinct(store_name)) n_stores,
	COUNT(DISTINCT(customer_id)) unique_customer,
	COUNT(customer_id) n_customer

FROM chocolate_database

GROUP BY city, year(order_date)
ORDER BY n_customer DESC
  