WITH counting_job_duplicate as 
(SELECT company_id, title, description,
count(job_id) as job_count 
from job_listings
group by company_id, title, description)

select count(company_id) as duplicate_companies
from counting_job_duplicate
where job_count > 1
