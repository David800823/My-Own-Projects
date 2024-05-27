# IF functions

Select * 
From bakery.customer_orders;

# IF (Condition, value if true, value if false)
Select tip, if(tip > 3, "Good Tip", "Cheap Customer") AS Tip_Description
From bakery.customer_orders;