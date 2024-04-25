--Day7_exercise1
select Name 
from STUDENTS
where Marks>75
order by right(Name,3), ID
--Day7_exercise2
select user_id,
concat(upper(left(name,1)),lower(right(name,length(name)-1))) as name
from Users
order by user_id
--Day7_exercise3
select manufacturer,
concat('$',round(sum(total_sales)/1000000,0),' ','million') as sale
from pharmacy_sales
group by manufacturer
order by sum(total_sales) DESC,manufacturer
--Day7_exercise4
SELECT extract (month from submit_date) as mth,
product_id as product,
round(avg(stars),2) as avg_stars
FROM reviews
group by product_id, extract (month from submit_date)
order by extract (month from submit_date), product_id
--Day7_exercise5
SELECT
sender_id,
count(message_id) as message_count
from messages
where extract(month from sent_date)=8
and extract(year from sent_date)=2022
group by sender_id
order by count(message_id) DESC
limit 2
--Day7_exercise6
select tweet_id
from Tweets
where length(content )>15
--Day7_exercise7
select 
activity_date as day,
count(distinct user_id) as active_users
from Activity 
where activity_date between '2019-06-28' and '2019-07-27'
group by activity_date
--Day7_exercise8
select count(id) as number_employee
from employees
where extract (month from joining_date) between 1 and 7
and abd extract (year from joining_date)=2022
--Day7_exercise9
select position('a' in first_name) as position
from worker
where first_name='Amitah'
--Day7_exercise10
select winery,
substring (title, length(winery)+2,4) as vintage_years
from winemag_p2
where country='Macedonia'
