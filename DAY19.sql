--- Ex1
alter table sales_dataset_rfm_prj
alter column ordernumber type integer using (trim(ordernumber)::integer),
alter column quantityordered type int using (trim(quantityordered)::int),
alter column priceeach type numeric using (trim(priceeach)::numeric),
alter column orderlinenumber type int USING (trim(orderlinenumber)::integer),
alter column sales type numeric USING (trim(sales)::numeric),
alter column orderdate type timestamp using (trim(orderdate)::timestamp),
alter column status type text USING (trim(status)::text),
alter column productline type text USING (trim(productline)::text),
alter column msrp type int USING (trim(msrp)::int),
alter column productcode type varchar USING (trim(productcode)::varchar),
alter column customername type text USING (trim(customername)::text),
alter column phone type text USING (trim(phone)::text),
alter column addressline1 type text USING (trim(addressline1)::text),
alter column addressline2 type text USING (trim(addressline2)::text),
alter column city type text USING (trim(city)::text),
alter column state type text USING (trim(state)::text),
alter column postalcode type text USING (trim(postalcode)::text),
alter column country type text USING (trim(country)::text),
alter column territory type text USING (trim(territory)::text),
alter column contactfullname type text USING (trim(contactfullname)::text),
alter column productcode type varchar USING (trim(productcode)::varchar),
alter column dealsize type text USING (trim(dealsize)::text)

--- Ex2
select * from sales_dataset_rfm_prj
where ORDERNUMBER is null 
or ORDERNUMBER='';
select * from sales_dataset_rfm_prj
where QUANTITYORDERED is null 
or QUANTITYORDERED='';
select * from sales_dataset_rfm_prj
where PRICEEACH is null 
or PRICEEACH='';
select * from sales_dataset_rfm_prj
where ORDERLINENUMBER is null 
or ORDERLINENUMBER='';
select * from sales_dataset_rfm_prj
where SALES is null 
or SALES='';
select * from sales_dataset_rfm_prj
where ORDERDATE is null 
or ORDERDATE='';

--- Ex3
alter table sales_dataset_rfm_prj
add column CONTACTLASTNAME text,
add column CONTACTFIRSTNAME text;

update sales_dataset_rfm_prj
set CONTACTFIRSTNAME=upper(left(left(contactfullname,position('-'in contactfullname)-1),1))||
						   substring(left(contactfullname,position('-'in contactfullname)-1),2);
update sales_dataset_rfm_prj						   
set CONTACTLASTNAME=upper(substring(contactfullname,position('-'in contactfullname)+1,1))||
							substring(contactfullname,position('-'in contactfullname)+2)

--- Ex4
alter table sales_dataset_rfm_prj
add column QTR_ID int,
add column MONTH_ID int,
add column YEAR_ID int;

update sales_dataset_rfm_prj
set QTR_ID=extract (quarter from orderdate);
update sales_dataset_rfm_prj
set MONTH_ID=extract (month from orderdate);
update sales_dataset_rfm_prj
set YEAR_ID=extract (year from orderdate)

--- Ex5
--- using BOXPLOT
with twt_min_max as
(select Q1-1.5*IQR as min_value,
Q3+1.5*IQR as max_value from
(select
percentile_cont(0.25) within group (order by QUANTITYORDERED) as Q1,
percentile_cont(0.75) within group (order by QUANTITYORDERED) as Q3,
percentile_cont(0.75) within group (order by QUANTITYORDERED) - percentile_cont(0.25) within group (order by QUANTITYORDERED) as IQR
from sales_dataset_rfm_prj) as a)
select * from sales_dataset_rfm_prj
where QUANTITYORDERED < (select min_value from twt_min_max)
or QUANTITYORDERED > (select max_value from twt_min_max)
--- using z-score
with cte as
(select *
(select avg(QUANTITYORDERED) from sales_dataset_rfm_prj) as avg,
(select stddev(QUANTITYORDERED) from sales_dataset_rfm_prj) as std
from sales_dataset_rfm_prj),
twt_oulier as
(select *, (QUANTITYORDERED-avg)/std as z_score
from cte
where abs((QUANTITYORDERED-avg)/std)>3)

update sales_dataset_rfm_prj
set QUANTITYORDERED=(set avg(QUANTITYORDERED)
from sales_dataset_rfm_prj)
where QUANTITYORDERED in (select QUANTITYORDERED from twt_oulier);
---- delete outlier
delete from sales_dataset_rfm_prj
where QUANTITYORDERED in (select QUANTITYORDERED from twt_oulier)
---Ex6
create or replace view SALES_DATASET_RFM_PRJ_CLEAN as
(update sales_dataset_rfm_prj
set QUANTITYORDERED=(set avg(QUANTITYORDERED)
from sales_dataset_rfm_prj)
where QUANTITYORDERED in (select QUANTITYORDERED from twt_oulier))

