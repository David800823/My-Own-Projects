# And 
# Or 
# Not

# Select customer id where city is Scranton and total money spent is over 500
Select customer_id
From bakery.customers
Where city = "Scranton" and total_money_spent > 500
Order BY customer_id ASC;

# Select all rows where the city is Scranton or total money spent is over 500
Select *
From bakery.customers
Where city = "Scranton" or total_money_spent > 500;

# Select all rows where the city is Dallas and State is TX
Select *
From bakery.customers
Where (state = "TX" and city = "Dallas");

# Select all rows where State is not Texas
Select *
From bakery.customers
Where Not state = "TX";

