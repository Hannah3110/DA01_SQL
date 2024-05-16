---ex1
select productline, year_id, dealsize,
sum(sales) as revenue
from public.sales_dataset_rfm_prj
group by productline, year_id, dealsize
order by year_id, productline,dealsize
---ex2
select year_id, month_id,
revenue from
(select year_id,MONTH_ID, 
sum(sales) as revenue,
dense_rank() over (partition by year_id order by sum(sales) DESC) as rank_order
from public.sales_dataset_rfm_prj
group by year_id,month_id
order by year_id,month_id) as a
where rank_order =1
