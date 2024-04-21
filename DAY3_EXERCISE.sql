--DAY 3_EXERCISE 1
select NAME from CITY
where COUNTRYCODE='USA' and POPULATION>120000
--DAY 3_EXERCISE 2
select * from CITY
where COUNTRYCODE='JPN'
--DAY 3_EXERCISE 3
select CITY, STATE from STATION
--DAY 3_EXERCISE 4
select distinct CITY from STATION
where CITY like 'A%' or CITY like  'E%' or CITY like 'I%' or CITY like 'O%' or CITY like 'U%'
--DAY 3_EXERCISE 5
select distinct CITY from STATION
where CITY like '%A' or CITY like '%E' or CITY like '%I' or CITY like '%O' or CITY like '%U'
--DAY 3_EXERCISE 6
select distinct CITY from STATION
where not (CITY like 'A%' or CITY like  'E%' or CITY like 'I%' or CITY like 'O%' or CITY like 'U%')
--DAY 3_EXERCISE 7
select name from Employee
order by name 
--DAY 3_EXERCISE 8
select name from Employee
where salary>2000 and months<10
order by employee_id
--DAY 3_EXERCISE 9
select product_id from Products
where low_fats='Y' and recyclable='Y'
--DAY 3_EXERCISE 10
select name from Customer
where referee_id is null or referee_id<>2
--DAY 3_EXERCISE 11
select name, population, area from World
where area>=3000000 or population>=25000000
--DAY 3_EXERCISE 12
select distinct author_id as id from Views
where author_id=viewer_id
order by author_id
--DAY 3_EXERCISE 13
SELECT part, assembly_step FROM parts_assembly
where assembly_step is not null and finish_date is null
--DAY 3_EXERCISE 14
select * from lyft_drivers
where yearly_salary<=30000 or yearly_salary>=70000
--DAY 3_EXERCISE 15
select * from uber_advertising
where year='2019' and money_spent>100000
