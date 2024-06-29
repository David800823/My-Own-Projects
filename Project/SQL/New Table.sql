Select *
FROM product_suggestions
;

-- Be careful with the data types you choose

ALTER TABLE product_suggestions RENAME COLUMN ï»¿product_suggestion_id to Product_Suggestion_id;


-- Option 2
-- Create table in Database, then import CSV into table

USE bakery;

CREATE TABLE product_suggestions2 (
product_sugg_id INT,
product_sugg_name text,
date_recieved text,
PRIMARY KEY (product_sugg_id)

)
;

Select *
FROM product_suggestions2;