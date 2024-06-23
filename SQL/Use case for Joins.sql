-- Use Cases for cases

Select *
FROM ordered_items
;

# Find the total profit per item

Select *
From ordered_items
;

Select * 
From products
;

Select distinct p.product_name, 
p.sale_price,
oi.unit_price, 
p.units_in_stock,
p.sale_price - oi.unit_price AS profit,
(p.sale_price - oi.unit_price) * p.units_in_stock AS potential_profit
FROM ordered_items oi JOIN products p 
	USING(product_id)
order by potential_profit DESC
;


-- -- 

Select * 
FROM supplier_delivery_status;
Select * 
FROM suppliers;
Select * 
FROM ordered_items;


Select oi.order_id, sds.name, oi.status, oi.shipped_date, s.name
FROM ordered_items oi 
JOIN supplier_delivery_status sds 
	ON oi.status = sds.order_status_id
JOIN suppliers s 
	ON oi.shipper_id = s.supplier_id
WHERE sds.name <> "Delivered" and YEAR(shipped_date) < YEAR(NOW()) - 1
;










