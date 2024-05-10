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


