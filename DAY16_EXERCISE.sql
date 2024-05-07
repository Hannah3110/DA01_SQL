--Day16_Ex1
with cte as
(select customer_id,order_date,customer_pref_delivery_date, immediate from
(select customer_id,order_date,customer_pref_delivery_date,
row_number() over (partition by customer_id order by order_date) as first_order,
customer_pref_delivery_date-order_date as immediate
from Delivery) as a
where first_order=1)
select 
round(100.0*sum(case 
    when immediate=0 then 1
    else 0
    end)/count(immediate),2) as immediate_percentage
from cte
