# Group By Introduction

# Summary of rows base in one or more columns. 

# Select all the columns in the table
Select * 
FROM bakery.customer_orders;

# Find the average order per profuct
Select product_id, Round(AVG (order_total), 2) AS Average_Order_total
FROM bakery.customer_orders
Group BY product_id;

# Find the total amount spent by customer
Select customer_id, SUM(order_total) AS Total_Ordered
From bakery.customer_orders
GROUP BY customer_id;

Select customer_id, Round(AVG(order_total),2) AS Average_Ordered
From bakery.customer_orders
GROUP BY customer_id
ORDER BY Average_Ordered;

#Get the first and last name of a customer and see how many orders they have, what was the price of the highest order,
# What is the price of the lowest order and how many unique products did they buy.
Select co.customer_id, first_name, last_name,
	Count(order_id) As NBR_of_Orders,
     Count(Distinct product_id) AS Count_of_Products_bought,
	MAX(order_total) AS Highest_Order,
	min(order_total) AS Lowest_Order
FROM bakery.customer_orders co Inner Join bakery.customers c ON co.customer_id = c.customer_id
GROUP BY co.customer_id;