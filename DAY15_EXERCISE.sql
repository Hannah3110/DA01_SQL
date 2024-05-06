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
select card_name,issued_amount from
(SELECT card_name,issued_amount,
rank() over(partition by card_name order by issue_year, issue_month)
as first_month  
FROM monthly_cards_issued) as a   
where first_month = 1
order by issued_amount DESC
--Day15_EX3  
select user_id, spend, transaction_date FROM
(SELECT user_id, spend, transaction_date,
row_number() over(PARTITION BY user_id order by transaction_date) as trans_date
FROM transactions) as a
where trans_date=3
--Day15_EX4
