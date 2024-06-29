# Select Values between values

# Select all for money spent between 500 and 1000
Select * 
From bakery.customers
Where total_money_spent Between 500 AND 1000;

# Select all for birth dates from 1990 to 2010
Select * 
From bakery.customers
Where birth_date Between "1990-01-01" AND "2010-01-01";

# Select customerid and city for city name betwwen Austin and New York
Select customer_id, city
From bakery.customers
Where city Between "Austin" and "New York"
ORDER BY city ASC
;