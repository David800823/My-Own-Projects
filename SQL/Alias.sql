-- Aliasing

-- Name first name as fn
Select first_name AS fn
From bakery.customers
;

-- Change product name
Select product_id AS "Product ID", product_name AS "Bakery Item"
From bakery.products
;

-- Change table name
Select p.product_id, p.product_name
FROM bakery.products p
;