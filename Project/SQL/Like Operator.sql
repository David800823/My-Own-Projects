# Like Operators

# Look at table
Select *
From bakery.customers
;

# find all rows where the first name starts with a letter "D"
Select *
From bakery.customers
Where first_name LIKE "D%"
;

# find all rows where the first name ends with the letter "n"
Select * 
From bakery.customers
Where first_name LIKE "%N"
;

# find all rows where the first name contains an "a"
Select first_name
FROM bakery.customers
Where first_name LIKE "%a%"
;

# find all first names where there is one character infront of "a"
# none exist
Select first_name
FROM bakery.customers
Where first_name LIKE "_a"
;