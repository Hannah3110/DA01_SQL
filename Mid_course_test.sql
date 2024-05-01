--Q1
select distinct replacement_cost
from film
order by replacement_cost 
--Q2
select
case
	when replacement_cost between 9.99 and 19.99 then 'low'
	when replacement_cost between 20.00 and 24.99 then 'medium'
	else 'high'
end as cost_level,
count(*)
from film
group by cost_level
--Q3
select a.title, a.length, c.name
from film as a
inner join film_category as b
on a.film_id=b.film_id
inner join category as c
on b.category_id=c.category_id
where c.name in('Drama','Sports')
order by length DESC
--Q4
select c.name, count(a.title)
from film as a
inner join film_category as b
on a.film_id=b.film_id
inner join category as c
on b.category_id=c.category_id
group by c.name
order by count(a.title) DESC
--Q5
select a.first_name, a.last_name, count(b.film_id)
from actor as a 
inner join film_actor as b
on a.actor_id=b.actor_id
group by a.first_name, a.last_name
order by count(b.film_id) DESC
--Q6
select a.address_id, a.address, b.customer_id 
from address as a
left join customer as b
on a.address_id=b.address_id
where b.customer_id is null
--Q7
select a.city, sum(d.amount)
from city as a
inner join address as b
on a.city_id=b.city_id
inner join customer as c
on b.address_id=c.address_id
inner join payment as d
on c.customer_id=d.customer_id
group by a.city
order by sum(d.amount) DESC
--Q8
select concat(a.city,',',b.country), sum(e.amount)
from city as a
inner join country as b
on a.country_id=b.country_id
inner join address as c
on a.city_id=c.city_id
inner join customer as d
on c.address_id=d.address_id
inner join payment as e
on d.customer_id=e.customer_id
group by concat(a.city,',',b.country)
order by sum(e.amount) DESC
