-- Regular Expression Metacharacters

Select *
FROM customers
;



-- ^: Matches the start of a line.
Select *
FROM customers
Where first_name REGEXP "^k" -- gives ypou names with a k at the begining
;


-- $: Matches the end of a line.
Select *
FROM customers
Where first_name REGEXP "n$" -- gives you a name that ends with n
;


-- .: Matches any single character except a newline character.
Select customer_id, first_name, phone
FROM customers
Where phone REGEXP "." -- . gives you any character not null
;

Select customer_id, first_name, phone
FROM customers
Where phone REGEXP "6." -- . gives a 6 with a number after it
;

Select customer_id, first_name, phone
FROM customers
Where phone REGEXP "6.5" -- . gives a 6 with any number in between then a 5
;

-- [...]: Matches any one character enclosed in the square brackets. If the first character is "^", it matches any character not enclosed in the brackets.
Select customer_id, first_name
FROM customers
Where first_name REGEXP "[a-c]"
;

Select customer_id, first_name, total_money_spent
FROM customers
Where total_money_spent REGEXP "[0-5]"
;


-- [^...]: Matches any character not enclosed in the brackets.

-- p1|p2|p3: Matches any of the patterns p1, p2, or p3.
Select *
FROM customers
Where first_name REGEXP "Ob|fro|Kev" -- gives you the start of OBI with 0 or more occurnaces
;



-- *: Matches zero or more occurrences of the preceding character or pattern.
Select *
FROM customers
Where first_name REGEXP "Obi.*" -- gives you the start of OBI with 0 or more occurnaces
;


-- +: Matches one or more occurrences of the preceding character or pattern.
Select *
FROM customers
Where first_name REGEXP "Obi.+" -- gives you the start of OBI with at least 1 occurance
;


-- ?: Matches zero or one occurrence of the preceding character or pattern.
Select *
FROM customers
Where first_name REGEXP "Obi.?" -- gives you zero or one
;

Select *
FROM customers
Where first_name REGEXP "K.?n" -- gives you the start of OBI with 0 or more occurnaces
;



-- {n}: Matches exactly n occurrences of the preceding character or pattern.
Select *
FROM customers
Where first_name REGEXP "K.{3}n" -- has to have 3 characters between l and n
;



-- {n,}: Matches n or more occurrences of the preceding character or pattern.

-- {n,m}: Matches between n and m (inclusive) occurrences of the preceding character or pattern.

-- ( ... ): Groups characters or patterns together.

-- \b: Matches a word boundary.

-- \B: Matches a non-word boundary.

-- \d: Matches any digit.

-- \D: Matches any non-digit character.

-- \s: Matches any whitespace character.

-- \S: Matches any non-whitespace character.

-- \w: Matches any word character (equivalent to [a-zA-Z0-9_]).

-- \W: Matches any non-word character.

-- \n: Matches a newline character.

-- \r: Matches a carriage return character.

-- \t: Matches a tab character.

-- \: Matches a backslash character.