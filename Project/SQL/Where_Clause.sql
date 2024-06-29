# The Where Clause
# Used to filter rows in the data that meets a specified condition

# Use the "bakery" database
Use bakery;


# Select all columns where the customer is from Texas
Select *
From customers
Where state = "TX" ;

# Select the customers where the total spent is over 1000
Select 
	customer_id,
	first_name
From customers
Where total_money_spent >=1000;

# Select the customers who's birth date is over 1995
Select 
	customer_id,
	first_name,
     birth_date
From customers
Where birth_date > "1995-01-01";

# Where units is less than 30
Select * 
From products
Where units_in_stock <30;


