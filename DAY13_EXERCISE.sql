--Day13_Exercise1
WITH counting_job_duplicate as 
(SELECT company_id, title, description,
count(job_id) as job_count 
from job_listings
group by company_id, title, description)

select count(company_id) as duplicate_companies
from counting_job_duplicate
where job_count > 1
--Day13_Exercise2
with cte_cat1 as
(SELECT category, product, sum(spend) as total_spend
FROM product_spend
where extract (year from transaction_date)=2022
and category='appliance'
group by category, product
order by sum(spend) DESC
limit 2),
cte_cat2 as
(SELECT category, product, sum(spend) as total_spend
FROM product_spend
where extract (year from transaction_date)=2022
and category='electronics'
group by category, product
order by sum(spend) DESC
limit 2)

select category, product, total_spend
from cte_cat1
UNION ALL 
select category, product, total_spend
from cte_cat2
