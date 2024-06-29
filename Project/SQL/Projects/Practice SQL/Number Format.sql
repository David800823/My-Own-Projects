# Numeric Functions

Select *
From bakery.customer_orders;

# Round Function
Select Round(SUM(order_total),2) AS "Order Totals"
FROM bakery.customer_orders;

# Cieling rounds up
Select Ceiling(order_total)
From bakery.customer_orders;

# Floor rounds down
Select order_total, floor(order_total) AS "Round Down", ceiling(order_total) AS "Round UP"
From bakery.customer_orders;

# Finding the absolute value
Select ABS(-12) AS "Absolute Value";