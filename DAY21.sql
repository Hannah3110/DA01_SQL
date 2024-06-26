----Ex1
select FORMAT_DATE('%Y-%m', t2.delivered_at) as month_year, 
count(DISTINCT t1.user_id) as total_user,
count(t1.ORDER_id) as total_order
from bigquery-public-data.thelook_ecommerce.orders as t1
Join bigquery-public-data.thelook_ecommerce.order_items as t2 
on t1.order_id=t2.order_id
Where t1.status='Complete' and 
t2.delivered_at BETWEEN '2019-01-01 00:00:00' AND '2022-05-01 00:00:00'
Group by month_year
ORDER BY month_year;
----Ex2
select FORMAT_DATE('%Y-%m', t2.delivered_at) as month_year, 
count(DISTINCT t1.user_id) as distinct_users,
avg(t2.sale_price) as avg_order_value
from bigquery-public-data.thelook_ecommerce.orders as t1
Join bigquery-public-data.thelook_ecommerce.order_items as t2 
on t1.order_id=t2.order_id
Where t1.status='Complete' and 
t2.delivered_at BETWEEN '2019-01-01 00:00:00' AND '2022-05-01 00:00:00'
Group by month_year
ORDER BY month_year
----Ex3
select * from
(select first_name, last_name,gender,age,
case when age=min(age) over(partition by gender order by age) then 'youngest'
    when age=max(age) over(partition by gender order by age) then 'oldest'
end as tag
from bigquery-public-data.thelook_ecommerce.users) as a
where tag in ('youngest','oldest')
---Ex4
with cte as
(select *, 
dense_rank() over(partition by month_year order by profit DESC) as row_no from
(select FORMAT_DATE('%Y-%m', t1.delivered_at) as month_year,
t2.product_id, t4.name as product_name, t2.sale_price, t3.cost, t2.sale_price-t3.cost as profit
from bigquery-public-data.thelook_ecommerce.orders as t1
Join bigquery-public-data.thelook_ecommerce.order_items as t2
on t1.order_id=t2.order_id
join bigquery-public-data.thelook_ecommerce.inventory_items as t3
on t2.product_id=t3.product_id
join bigquery-public-data.thelook_ecommerce.products as t4
on t2.product_id=t4.id
Where t1.status='Complete' and 
t2.delivered_at BETWEEN '2019-01-01 00:00:00' AND '2022-05-01 00:00:00'
Group by month_year,t2.product_id, t4.name, t2.sale_price, t3.cost
order by month_year) a)
select * from cte
where row_no <=5
---Ex5
select FORMAT_DATE('%Y-%m-%d', t2.delivered_at) as dates,
t1.category as product_category,
sum(t2.sale_price) as revenues
from bigquery-public-data.thelook_ecommerce.products as t1
join bigquery-public-data.thelook_ecommerce.order_items as t2
on t1.id=t2.product_id
where t2.delivered_at BETWEEN '2022-01-15 00:00:00' AND '2022-04-16 00:00:00'
group by dates,product_category
order by dates
