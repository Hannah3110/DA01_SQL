--Day5_Exercise1
select distinct CITY from STATION
where ID%2=0
--Day5_Exercise2
select count(CITY)-count(distinct CITY) from STATION
--Day5_Exercise3
select ceiling(avg(Salary)-avg(replace(Salary,'0','')))
from EMPLOYEES
--Day5_Exercise4
SELECT round(cast(sum(item_count*order_occurrences)/sum(order_occurrences) 
as decimal),1) 
as mean
from items_per_order
--Day5_Exercise5
SELECT candidate_id FROM candidates
where skill in ('Python', 'Tableau', 'PostgreSQL') 
group by candidate_id
having count(skill)=3
order by candidate_id
--Day5_Exercise6
SELECT user_id, date(max(post_date))-date(min(post_date)) as days_between
FROM posts
where post_date>='2021-01-01' and post_date<'2022-01-01'
group by user_id
having count(post_id)>=2
--Day5_Exercise7
SELECT card_name, 
max(issued_amount)-min(issued_amount) as difference
FROM monthly_cards_issued
group by card_name
order by difference DESC
--Day5_Exercise8
SELECT manufacturer,
count(drug) as drug_count,
abs(sum(cogs-total_sales)) as total_loss
FROM pharmacy_sales
where total_sales<cogs
group by manufacturer
order by total_loss DESC
--Day5_Exercise9
select * from Cinema
where id%2=1 and description <> 'boring'
order by rating DESC
--Day5_Exercise10
