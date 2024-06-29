SELECT * 
FROM bakery.customer_sweepstakes;

-- Renaming columns
ALTER TABLE customer_sweepstakes RENAME COLUMN ï»¿sweepstake_id TO sweepstake_id;

SELECT * 
FROM bakery.customer_sweepstakes;

-- Remove people who entered in the sweepstake multiple times
SELECT customer_id, count(customer_id)
FROM bakery.customer_sweepstakes
GROUP BY customer_id
HAVING count(customer_id) > 1
;



-- Adding Row Number
Select *
FROM (SELECT sweepstake_id,
	row_number() OVER(partition by customer_id ORDER BY customer_id) AS row_num
FROM bakery.customer_sweepstakes) jj
Where row_num > 1
;

-- Delete duplicates
delete FROM customer_sweepstakes
WHERE sweepstake_id IN (
	Select sweepstake_id
     FROM (
		Select *
		FROM (SELECT sweepstake_id,
			row_number() OVER(partition by customer_id ORDER BY customer_id) AS row_num
			FROM bakery.customer_sweepstakes) jj
		Where row_num > 1) AS jjj
     )
;




-- Looking at the data again
SELECT * 
FROM bakery.customer_sweepstakes;


-- Standardized Data
Select phone, REGEXP_REPLACE(phone, "[()-/+]", "") AS Clean_Phone
FROM bakery.customer_sweepstakes;


-- Update column
UPDATE customer_sweepstakes
Set phone = REGEXP_REPLACE(phone, "[()-/+]", "");

-- Update Format
Select phone, CONCAT(substring(phone,1,3),"-", substring(phone,4,3), "-", substring(phone,7,4)) AS Phone_Clean
From customer_sweepstakes
;


-- Update column
UPDATE customer_sweepstakes
SET phone = CONCAT(substring(phone,1,3),"-", substring(phone,4,3), "-", substring(phone,7,4))
WHERE phone <> ""
;

-- Check phone number
Select phone
FROM customer_sweepstakes;

-- Change birthdate format

Select birth_date, 
CASE 
WHEN str_to_date(birth_date, "%m/%d/%Y") IS NOT NULL THEN str_to_date(birth_date, "%m/%d/%Y")
WHEN str_to_date(birth_date, "%m/%d/%Y") IS NULL THEN str_to_date(birth_date, "%Y/%d/%m") 
END AS clean_birth
FROM customer_sweepstakes
;


SELECT `Are you over 18?`, 
	CASE 
		When `Are you over 18?` = "Yes" Then "Y" 
          When `Are you over 18?` = "No" Then "N"
	ELSE `Are you over 18?`
     END AS Y_N
FROM customer_sweepstakes;


UPDATE customer_sweepstakes
SET `Are you over 18?` = CASE 
		When `Are you over 18?` = "Yes" Then "Y" 
          When `Are you over 18?` = "No" Then "N"
	ELSE `Are you over 18?`
     END
     
;


Select *
FROM customer_sweepstakes;

Select 
	sweepstake_id,
	birth_date,
     CONCAT(substring(birth_date,9,2), "/" ,substring(birth_date,6,2), "/", substring(birth_date,1,4))
     
FROM customer_sweepstakes
;


-- Setting New Dates
UPDATE customer_sweepstakes
SET birth_date = CONCAT(substring(birth_date,9,2), "/" ,substring(birth_date,6,2), "/", substring(birth_date,1,4))
WHERE sweepstake_id IN (11,9) ;


-- Set format for date
UPDATE customer_sweepstakes
SET birth_date =  str_to_date(birth_date, "%m/%d/%Y") 
;









Select *
FROM customer_sweepstakes
;













Select *
FROM customer_sweepstakes
;




-- Breaking a column into multiple columns
Select address,
	substring_index(address,",", 1) AS Street,
     substring_index(substring_index(address, ",",2), ",", -1) AS City,
	substring_index(address,",", -1) AS State
FROM customer_sweepstakes
;


-- Add new columns
ALTER TABLE customer_sweepstakes
ADD COLUMN street varchar(50) AFTER address
;

-- Add other columns

-- Add new columns
ALTER TABLE customer_sweepstakes
ADD COLUMN city varchar(50) AFTER street,
ADD COLUMN state varchar(10) AFTER city
;


-- Entering the date
UPDATE customer_sweepstakes
SET street = substring_index(address,",", 1);

UPDATE customer_sweepstakes
SET city = substring_index(substring_index(address, ",",2), ",", -1)
;

update customer_sweepstakes
SET state = substring_index(address,",", -1)
;


Select *
FROM customer_sweepstakes;

UPDATE customer_sweepstakes
SET state = upper(state)
;

UPDATE customer_sweepstakes
SET state = TRIM(state)
;

UPDATE customer_sweepstakes
SET city = TRIM(city)
;


ALTER tABLE customer_sweepstakes DROP COLUMN address;


Select *
FROM customer_sweepstakes;


-- Null Values
Select *
FROM customer_sweepstakes
;

UPDATE customer_sweepstakes
SET phone = NULL
Where phone = ""
;

UPDATE customer_sweepstakes
SET income = NULL
Where income = ""
;


Select AVG(income)
FROM customer_sweepstakes
;

Select AVG(income)
FROM customer_sweepstakes
Where income IS NOT NULL
;

-- COALESCE takes the null values and replaces it with a value you choose
Select AVG(coalesce(income,0))
FROM customer_sweepstakes
;

Select birth_date, `Are you over 18?`
FROM customer_sweepstakes
WHERE (Year(now() - 18) > YEAR(birth_date))
;

UPDATE customer_sweepstakes
SET `Are you over 18?` = "Y"
WHERE (Year(now() - 18) > YEAR(birth_date))
;


Select *
FROM customer_sweepstakes
;


