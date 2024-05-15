select productline, year_id, dealsize,
sum(sales) as revenue
from public.sales_dataset_rfm_prj
group by productline, year_id, dealsize
order by year_id, productline,dealsize
