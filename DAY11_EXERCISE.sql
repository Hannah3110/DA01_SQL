--Day11_Exercise1
select A.CONTINENT, floor(avg(B.POPULATION))
from COUNTRY as A
INNER JOIN CITY as B
on B.COUNTRYCODE=A.CODE
group by A.CONTINENT
--Day11_Exercise2
SELECT 
round(sum(case
when b.signup_action='Confirmed' then 1
else 0
end)/cast(count(*)as decimal),2) as confirm_rate
FROM emails AS a   
inner JOIN texts AS b
ON a.email_id=b.email_id
--Day11_Exercise3
SELECT b.age_bucket,
round(100.0*sum(CASE  
  when a.activity_type='send'then a.time_spent 
  else 0 end)/sum(a.time_spent),2) as send_perc,
round(100.0*sum(CASE  
  when a.activity_type='open'then a.time_spent 
  else 0 end)/sum(a.time_spent),2) as open_perc
FROM activities AS a
INNER JOIN age_breakdown AS b
ON a.user_id=b.user_id
where activity_type in ('send','open')
group by age_bucket
--Day11_Exercise4
SELECT 
a.customer_id
FROM customer_contracts as a   
INNER JOIN products as b  
ON a.product_id=b.product_id
group by a.customer_id
having count(distinct b.product_category)=3
--Day11_Exercise5
select mng.employee_id, mng.name,
count(emp.employee_id) as reports_count,
round(avg(emp.age)) as average_age
from Employees as emp
join Employees as mng
on mng.employee_id=emp.reports_to 
group by employee_id
order by employee_id
--Day11_Exercise6
select a.product_name, sum(b.unit) as unit
from Products as a
inner join Orders as b
on a.product_id=b.product_id
where extract(month from b.order_date)=02 and extract(year from b.order_date)=2020
group by a.product_name
having sum(b.unit)>=100
--Day11_Exercise6
