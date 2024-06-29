-- Inner Join Multiple Tables


# Joining Multiple Tables

Select p.product_name, co.order_total, c.first_name
From products p 
INNER Join customer_orders co 
	ON p.product_id = co.product_id
INNER Join customers c 
	ON co.customer_id = c.customer_id
;

