select * from sales_dataset_rfm_prj;
alter table sales_dataset_rfm_prj
alter column priceeach type numeric using (trim(priceeach)::numeric);
alter table sales_dataset_rfm_prj
alter column ordernumber type int using (trim(ordernumber)::int);
alter table sales_dataset_rfm_prj
alter column quantityordered type int using (trim(quantityordered)::int);
alter table sales_dataset_rfm_prj
alter column orderdate type timestamp using (trim(orderdate)::timestamp)
