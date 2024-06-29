# Inner Join

-- ONly return rows where the data is the same

Select * 
From customers c
INNER JOIN customer_orders co
	ON c.customer_id = co.customer_id
Order BY c.customer_id   
;

-- What are the top 3 customer with the highest sales all time
Select co.customer_id, CONCAT(c.first_name," " ,c.last_name) AS "Customer Name" , SUM(co.order_total) AS "Total Orders"
From customer_orders co INNER JOIN customers c 
	ON co.customer_id = c.customer_id
GROUP BY customer_id
ORDER BY SUM(co.order_total) DESC
Limit 3
;

# Order the products from the most sold to least
Select p.product_id, p.product_name, SUM(co.order_total) AS Total
FROM products p INNER JOIN customer_orders co ON p.product_id = co.product_id
GROUP BY p.product_id
ORDER BY 3 DESC
;

# JOINS
Select *
FRom suppliers s INNER JOIN ordered_items oi ON s.supplier_id = oi.shipper_id
;