# Comparison Operators

# = equal to
# <> not equal to
# > greater than
# < less than
# >= greater than or equal to
# <= less than or equal to

# Filter for orders that are equal to 1
Select *
From bakery.customer_orders
Where tip = 1;

# Filter for orders that are not equal to 1
Select *
From bakery.customer_orders
Where tip <> 1;