# Date and Date Formats

Select *
From bakery.customer_orders;

Select 
	NOW(), -- Date Time NOW 
	curdate(), -- Current Date 
	curtime(); -- Current Time
     
Select
	NOW(), -- Gets Date/Time now
	Day(NOW()), -- Get the Date Today 
     Month(NOW()), -- Get the Month 
     YEAR(NOW()); -- Get the Year
     
     
SELECT birth_date
FROM bakery.customers
Where YEAR(birth_date) != "2000";

Select curdate(), dayname(curdate());

SELECT birth_date, DAYNAME(birth_date)
FROM bakery.customers;

# Date Format
Select 
	birth_date, 
	DATE_FORMAT(birth_date, "%M %D %Y"),
     DATE_FORMAT(birth_date, "%M-%D-%Y"),
     DATE_FORMAT(birth_date, "%M %Y")
FROM bakery.customers;