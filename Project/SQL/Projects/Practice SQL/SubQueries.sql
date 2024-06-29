-- Subqueries

--  A subquery is a select statement nested inside another query.alter

SELECT customer_name, customer_id
FROM customers
WHERE customer_id 
IN (
SELECT customer_id
FROM orders 
WHERE order_amount > 1000);


Select 
	customer_id,
     concat(first_name, " " , last_name) AS "Full Name"
FROM customers
Where customer_id IN
(SELECT customer_id
FROM customer_orders
WHERE order_total > 10)
;

-- Sub Query Basics
-- Cannot have more than 1 column in a subquery
Select *
FROM customers
Where customer_id in
	(
	Select customer_id
	FROM customer_orders
	)
;

-- See which customer that is higher than average

Select 
	customer_id, 
	concat(first_name, " " , last_name) AS "Full Name",
     total_money_spent
FROM customers
Where total_money_spent > 
	(
	Select AVG(total_money_spent)
	FROM customers
	)
;
