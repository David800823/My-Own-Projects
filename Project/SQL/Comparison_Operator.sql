#Comparison Operatoe

# Select all rows where tip is greater than 3
Select *
From bakery.customer_orders
Where tip > 3;

# Select all rows where tip is not equal to 1
Select *
From bakery.customer_orders
Where tip != 1;

# Select all rows where tip is less than 5
Select *
From bakery.customer_orders
Where tip < 5;

# Select all rows that has a tip greater than or equal to 5
Select *
From bakery.customer_orders
Where tip >= 5
Order BY tip DESC;