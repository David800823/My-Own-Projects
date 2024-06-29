# Case 

Select *
FROM bakery.products;

# Categorizing Unites in Stock
Select units_in_stock,
CASE
	When units_in_stock < 20 THEN "Order NOW!"
     WHEN units_in_stock BETWEEN 20 AND 50 THEN "Check in 3 days"
     WHEN units_in_stock > 51 THEN "In Stock"
END AS "Order Status"
FROM bakery.products;

# Categorizing Unites in Stock
Select units_in_stock,
CASE
	When units_in_stock < 20 THEN "Order NOW!"
     WHEN units_in_stock BETWEEN 20 AND 50 THEN "Check in 3 days"
     ELSE "In Stock"
END AS "Order Status"
FROM bakery.products;

# Order date & Case statement
Select 
	order_id,
	order_date,
     CASE 
		WHEN YEAR(order_date) = YEAR(NOW()) - 1 THEN "Active"
          When YEAR(order_date) = YEAR(NOW()) - 2 THEN "Last Year"
          ELSE "Not Relevant"
          END AS "Years"
FROM bakery.customer_orders;