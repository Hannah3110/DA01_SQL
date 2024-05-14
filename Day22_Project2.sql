----task 1
with cte as
(select extract(month from b.delivered_at) as month,
extract (year from b.delivered_at) as year,
c.category,
round(sum(b.sale_price*a.num_of_item),2) as TPV, count (a.order_id) as TPO,
round(sum(c.cost*a.num_of_item),2) as total_cost,
round(sum(b.sale_price*a.num_of_item)-sum(c.cost*a.num_of_item),2) as total_profit,
round((sum(b.sale_price*a.num_of_item)-sum(c.cost*a.num_of_item))/sum(c.cost*a.num_of_item),2) as profit_to_cost_ratio,
from bigquery-public-data.thelook_ecommerce.orders as a
inner join bigquery-public-data.thelook_ecommerce.order_items as b
on a.order_id=b.order_id
inner join bigquery-public-data.thelook_ecommerce.products as c
on b.product_id=c.id
where a.status = 'Complete'
group by  year, month,c.category
order by c.category,year,month)
select *,
round(100.00*(TPV-lag(TPV) over(partition by category,year order by month))/lag(TPV) over(partition by category,year order by month),2)||"%" as revenue_growth,
round(100.00*(TPO-lag(TPO) over(partition by category,year order by month))/lag(TPO) over(partition by category,year order by month),2)||"%" as order_growth
from cte
order by year,category
----task 2
with user_index as
(select user_id, amount,FORMAT_DATE('%Y-%m',first_order_date) as cohort_date,
FORMAT_DATE('%Y-%m',delivered_at)as delivered_date,
(extract(year from delivered_at)-extract(year from first_order_date))*12+
(extract(month from delivered_at)-extract(month from first_order_date))+1 as index
from (select a.user_id,
round(a.sale_price*b.num_of_item,2) as amount,
min(a.delivered_at) over (partition by a.user_id) as first_order_date,
a.delivered_at
from bigquery-public-data.thelook_ecommerce.order_items as a
inner join bigquery-public-data.thelook_ecommerce.orders as b
on a.order_id=b.order_id)),

cohort_base as
(select cohort_date, index, 
count(distinct user_id) as no_customer,
round(sum(amount),2) as rev_by_cus
from user_index
where index between 1 and 4
group by cohort_date, index
order by cohort_date),


customer_cohort as
(select cohort_date,
sum(case when index = 1 then no_customer else 0 end) as m1,
sum(case when index = 2 then no_customer else 0 end) as m2,
sum(case when index = 3 then no_customer else 0 end) as m3,
sum(case when index = 4 then no_customer else 0 end) as m4
from cohort_base
group by cohort_date
order by cohort_date)
select cohort_date,
round(100.00*m1/m1,2)||"%" as m1,
round(100.00*m2/m1,2)||"%" as m2,
round(100.00*m3/m1,2)||"%" as m3,
round(100.00*m4/m1,2)||"%" as m4
from customer_cohort
