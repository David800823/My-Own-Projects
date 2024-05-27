# IN Operator

# Look in table
Select *
From bakery.customers;

# Without IN
Select *
From bakery.customers
Where state = "PA" or state = "TX" or state = "FL";

# IN
# Useful for multiple values in one column
Select *
From bakery.customers
Where state IN ("PA" , "TX", "FL");

Select *
From bakery.customers
Where state NOT IN ("PA" , "TX", "FL");