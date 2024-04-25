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
