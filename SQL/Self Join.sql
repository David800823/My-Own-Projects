-- Self Join


Select *
From customers c 
INNER Join customers ss
	ON c.first_name = ss.first_name
;


Select c.customer_id, c.first_name, c.last_name, ss.customer_id, ss.first_name, ss.last_name
FROM customers c
Join customers ss
	On c.customer_id = ss.customer_id
     
;