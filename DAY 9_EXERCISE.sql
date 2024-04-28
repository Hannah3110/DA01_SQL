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
