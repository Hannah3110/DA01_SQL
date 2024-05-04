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
--Day13_Exercise3
select category, product, total_spend
from cte_cat1
UNION ALL 
select category, product, total_spend
from cte_cat2

with cte_count as
(SELECT policy_holder_id, 
COUNT(case_id) AS count_case
FROM callers
group by policy_holder_id)

select count(policy_holder_id) as policy_holder_count
from cte_count
where count_case>=3
--Day13_Exercise4
select page_id from pages
where page_id not in
(select page_id from page_likes
where pages.page_id=page_likes.page_id)
order by page_id
--Day13_Exercise5
SELECT extract(month from July.event_date) as month,
count(distinct July.user_id) as monthly_active_users
FROM user_actions as July
where July.user_id in (
select June.user_id from user_actions as June
where June.user_id=July.user_id
and extract(month from June.event_date)=6 and extract(year from June.event_date)=2022
and June.event_id is not null)
and extract(month from July.event_date)=7 and extract(year from July.event_date)=2022
and July.event_id is not null
group by month
--Day13_Exercise6
  select left(trans_date,7) as month,
country,
count(id) as trans_count,
sum(
    case
    when state = 'approved' then 1 else 0
    end) as approved_count,
sum(amount) as trans_total_amount,
sum(
    case 
    when state = 'approved' then amount else 0 end) as approved_total_amount
from Transactions
group by month, country
--Day13_Exercise7
with cte_minyear as
(select product_id,
min(year) as first_year
from Sales 
group by product_id)
select final.product_id, final.year as first_year, final.quantity, final.price
from sales as final
inner join cte_minyear on final.product_id=cte_minyear.product_id
and final.year=cte_minyear.first_year
--Day13_Exercise8
select customer_id
from Customer
group by customer_id
having count(product_key)=(
select count(product_key) from Product)
--Day13_Exercise9
select emp.employee_id
from Employees as emp
where emp.salary<30000
and emp.manager_id not in (
    select mng.employee_id from Employees as mng
    where mng.employee_id=emp.manager_id)
and emp.manager_id is not null
order by emp.employee_id
--Day13_Exercise11
(select name as results from Users
where user_id in
(select user_id from MovieRating
group by user_id
order by count(rating) DESC) order by name limit 1)
union all
(select title as results from Movies
where movie_id in
(select movie_id from MovieRating
where extract(year from created_at)=2020 and extract(month from created_at)=2
group by movie_id
order by avg(rating) DESC)
order by title limit 1)
--Day13_Exercise12
with cte as
(select requester_id as id,
count(accepter_id) as num
from RequestAccepted
group by id union all
select accepter_id as id,
count(requester_id) as num
from RequestAccepted
group by id)
select id, sum(num) as num
from cte
group by id
order by num DESC limit 1
