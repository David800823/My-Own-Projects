# Limits

# Select the top 3 customers with the most money spent
Select customer_id, first_name, total_money_spent
From bakery.customers
Order By total_money_spent DESC
Limit 3
;

# Select the 3 oldest customers with their customer id and date of birth
Select customer_id, first_name, birth_date
From bakery.customers
Order By birth_date ASC
Limit 3
;

# Select the 5 highest total money spent after the first 3
Select *
From bakery.customers
Order By total_money_spent DESC
Limit 3, 5
;