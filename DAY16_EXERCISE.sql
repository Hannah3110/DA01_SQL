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
--Day16_Ex7
with cte as
(select b.name as Department,a.name as Employee,a.salary as Salary,
dense_rank() over(partition by b.name order by a.salary desc) as rank_order
from Employee as a
join Department as b
on a.departmentId=b.id)
select Department,Employee,Salary
from cte
where rank_order<=3
--Day16_Ex7
with cte as
(select person_name,
sum(weight) over(order by turn) as total_weight
from Queue)
select person_name
from cte
where total_weight<=1000
order by total_weight desc
limit 1
