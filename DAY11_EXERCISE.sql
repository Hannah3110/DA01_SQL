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
--Day11_Exercise3
