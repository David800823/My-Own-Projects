-- Unions

-- Unions operator in SQl is used to combine the result set of two or more Select statements


Select * 
From customers
;

Select *
From products
;

Select first_name, last_name
From customers
UNION
Select product_id, product_name
From products
;

-- When using Union make sure the data is the same

Select first_name, last_name, "Old"
From customers
Where YEAR(birth_date) < 1950
UNION
Select c.first_name, c.last_name,  "Good Tipper"
FROM customers c JOIN customer_orders co
	ON c.customer_id = co.customer_id
WHERE tip > 3
;

-- You cannot use an ORDER BY before a union


-- Union ALL

Select first_name, last_name, "Old"
From customers
Where YEAR(birth_date) < 1950
UNION Distinct
Select c.first_name, c.last_name,  "Good Tipper"
FROM customers c JOIN customer_orders co
	ON c.customer_id = co.customer_id
WHERE tip > 3
;

-- Union Adds data into 1 column