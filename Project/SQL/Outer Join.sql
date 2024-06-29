# Outer Joins

-- Inner Join
Select *
From customers c
INNER Join customer_orders co
	ON c.customer_id = co.customer_id
;

-- Left Join
Select *
From customers c
Left Join customer_orders co
	ON c.customer_id = co.customer_id
;

-- Right Join
Select *
From customers c
Right Join customer_orders co
	ON c.customer_id = co.customer_id
;
