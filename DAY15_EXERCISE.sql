--Day15_EX1
SELECT extract(year from transaction_date) as year,
product_id, spend as curr_year_spend,
lag(spend) over(PARTITION BY product_id 
order by extract(year from transaction_date)) as prev_year_spend,
round(100.0*(spend-lag(spend) over(PARTITION BY product_id 
order by extract(year from transaction_date)))/
lag(spend) over(PARTITION BY product_id 
order by extract(year from transaction_date)),2) as yoy_rate
FROM user_transactions
--Day15_EX2
