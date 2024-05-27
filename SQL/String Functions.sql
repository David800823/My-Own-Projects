# String Functions

Select *
From bakery.customers;

# Count the length of the string
Select first_name, length(first_name) AS Length_Name
From bakery.customers
Order BY Length_Name DESC;

# Make everything upper case or lower case
Select last_name, UPPER(last_name), LOWER(last_name)
From bakery.customers;

# TRIM/Left Trim/Right Trim
Select TRIM("  Hello "), rtrim("      Hello     "), ltrim("     Heillo    ");

# Left Function
Select phone, Left(phone,3) AS Area_Code
From bakery.customers;

# Right Function
Select first_name, right(first_name,3)
From bakery.customers;

# Substring
Select phone, Substring(phone,1,3), Substring(phone,5,7), Substring(phone,9,12)
FROM bakery.customers;

# Find and Replace
Select first_name, REPLACE(first_name, 'a', 'o')
From bakery.customers;

# Data Cleaning
Select phone, REPLACE(phone, "-", "")
From bakery.customers;

# Locate
Select first_name, Locate("a", first_name)
FROM bakery.customers;

# Concatanate
Select concat(first_name, " " ,last_name) AS Full_Name, first_name, last_name
FROM bakery.customers;

# Phone Numbers
Select 
	phone, 
	Substring(phone,1,3), 
	Substring(phone,5,7), 
     Substring(phone,9,12),
	concat(Substring(phone,1,3), Substring(phone,5,7), Substring(phone,9,12))
FROM bakery.customers;