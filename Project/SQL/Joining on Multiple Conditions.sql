# Joining on Multiple Conditions

Select *
From customer_orders;

Select * 
From customer_orders_review;

Select * 
FROM customer_orders co
Inner Join customer_orders_review cor
	ON co.order_id = cor.order_id
     AND co.customer_id = cor.customer_id
     AND co.order_date = cor.order_date
;