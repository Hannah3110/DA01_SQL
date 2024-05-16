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
---ex5
select productline, year_id, dealsize,
sum(sales) as revenue
from public.sales_dataset_rfm_prj
group by productline, year_id, dealsize
order by year_id, productline,dealsize;

select year_id, month_id,
revenue from
(select year_id,MONTH_ID, 
sum(sales) as revenue,
dense_rank() over (partition by year_id order by sum(sales) DESC) as rank_order
from public.sales_dataset_rfm_prj
group by year_id,month_id
order by year_id,month_id) as a
where rank_order =1;

select year_id,month_id,productline,
revenue from
(select year_id,month_id,productline,
sum(sales) as revenue,
dense_rank() over (partition by year_id order by sum(sales) DESC) as rank_order
from sales_dataset_rfm_prj
where month_id='11'
group by year_id,month_id, productline
order by year_id,month_id, productline) as a
where rank_order=1;

select * from
(select year_id,productline,
sum(sales) as revenue,
row_number() over (partition by year_id order by sum(sales) DESC) as rank
from sales_dataset_rfm_prj
where country='UK'
group by year_id,productline
order by year_id) as a
where rank =1
order by revenue;
select * from sales_dataset_rfm_prj;

with customer_RFM as
(select customername,
extract (days from (current_date-max(orderdate))) as R,
count(distinct ordernumber) as F,
sum(sales) as M
from sales_dataset_rfm_prj
group by customername)
, rfm_score as
(select customername,
ntile(5) over(order by R DESC) as R_score,
ntile(5) over(order by F) as F_score,
ntile(5) over(order by M) as M_score
from customer_RFM)
,rfm_final as
(select customername,
cast(R_score as varchar)||cast(F_score as varchar)||cast(M_score as varchar) as RFM
from rfm_score)
select a.customername,b.segment
from rfm_final as a
inner join segment_score as b
on a.rfm=b.scores
