# CAST & Convert Functions

Select CAST("2022-01-01" AS DATE);

SELECT 
	birth_date, 
     CAST(birth_date AS DATETIME) AS Cast_DateTime,
     CONVERT(birth_date, DATETIME) AS Convert_DateTime
FROM bakery.customers;