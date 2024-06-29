# This is in the bakery table
USE bakery;

Select customer_id, city
From customers;

Select * 
From customer_orders
Where order_total > 50;

Select 
	customer_id,
	last_name,
	first_name
     phone,
     total_money_spent,
     total_money_spent + 100 As And_100
From customers;

#Select distinct states
Select Distinct state
From customers;

# Distinct city and state
Select Distinct city, state
From customers;