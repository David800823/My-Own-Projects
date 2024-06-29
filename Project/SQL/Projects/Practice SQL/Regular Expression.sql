-- Regular expression

-- Regular expression is a sequence of characters to search and locate specific sequence of characters that match a provided patern
-- Similiar to the Like statement


Select *
From customers;

Select *
From customers
Where first_name LIKE "%k%"
;

-- Find a first name with a k
Select *
From customers
Where first_name REGEXP "k"
;


-- Replace the letter a to b in first name
Select 
	first_name,
	regexp_replace(first_name, "a","b")
From customers
;


-- Gives a boolean value if any name has an "a" on it
Select 
	first_name,
	regexp_LIKE(first_name, "a")
From customers
;

-- Find the position of letter a
Select 
	first_name,
	regexp_INSTR(first_name, "a")
From customers
;

-- Gives you the substring
Select 
	first_name,
	regexp_SUBSTR(first_name, "Char")
From customers
;

