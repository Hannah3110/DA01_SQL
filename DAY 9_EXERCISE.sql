--Day9_exercise1
SELECT 
SUM(CASE
  when device_type = 'laptop' then 1
  else 0
end) as laptop_views,
SUM(CASE
  when device_type in ('phone','tablet') then 1
  else 0
end) as moble_views
FROM viewership
--Day9_exercise2
select *,
case
    when (x+y>z) and (x+z>y) and (y+z>x) then 'Yes'
    else 'No'
end as triangle
from Triangle
--Day9_exercise3
SELECT 
round(100.0*sum(
CASE
  when call_category is null or call_category='n/a' then 1
  else 0
end)/count(case_id),1) as uncategorised_call_pct
FROM callers
--Day9_exercise4
