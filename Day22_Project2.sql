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
round((100.00*lead(TPV) over(partition by category order by category,year,month)-TPV)/TPV,2)||"%" as revenue_growth,
round((100.00*lead(TPO) over(partition by category order by category,year,month)-TPO)/TPO,2)||"%" as order_growth
from cte
