# Order By

# Order By customer id
Select *
From bakery.customers
Order By customer_id DESC
;

# Select address that contain street and Order by total money spent
Select customer_id, first_name, last_name, address, total_money_spent
From bakery.customers
Where address LIKE "%street%"
Order By total_money_spent ASC
;

# Select all order by last name then total money spent in DESC
Select last_name, total_money_spent
From  bakery.customers
Order BY last_name ASC, total_money_spent DESC
;

# Order By column number
Select *
From bakery.customers
Order by 5 ASC
;