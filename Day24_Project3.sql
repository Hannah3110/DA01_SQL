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
---ex3
select year_id,month_id,productline,
revenue from
(select year_id,month_id,productline,
sum(sales) as revenue,
dense_rank() over (partition by year_id order by sum(sales) DESC) as rank_order
from sales_dataset_rfm_prj
where month_id='11'
group by year_id,month_id, productline
order by year_id,month_id, productline) as a
where rank_order=1
---ex4
select * from
(select year_id,productline,
sum(sales) as revenue,
row_number() over (partition by year_id order by sum(sales) DESC) as rank
from sales_dataset_rfm_prj
where country='UK'
group by year_id,productline
order by year_id) as a
where rank =1
order by revenue
