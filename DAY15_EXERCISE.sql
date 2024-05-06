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
select transaction_date,user_id,
count (product_id) as purchase_count from
(SELECT transaction_date,rank() over(partition by user_id order by transaction_date DESC) as latest_trans, 
user_id, product_id
FROM user_transactions) as a  
where latest_trans = 1
group by transaction_date,user_id
--Day15_EX5
with cte as
(SELECT *,
COALESCE(lag(tweet_count) over (partition by user_id order by tweet_date),0) as day_1,
COALESCE(lag(tweet_count,2) over (partition by user_id order by tweet_date),0) as day_2
FROM tweets)

select user_id,tweet_date,
case
  when day_1=0 and day_2=0 then round(tweet_count,2)
  when day_1=0 then round((tweet_count+day_2)/2.0,2)
  when day_2=0 then round((tweet_count+day_1)/2.0,2)
  else round((tweet_count+day_1+day_2)/3.0,2)
end as rolling_avg_3d
from cte
--Day15_EX6
with cte AS
(SELECT merchant_id,credit_card_id,amount,
transaction_timestamp-
lag(transaction_timestamp) over(PARTITION BY merchant_id,credit_card_id,amount) as time_within
FROM transactions)
select count(time_within)
from cte 
where time_within<='00:10:00' 
--Day15_EX7
select category,product,total_spend from
(select category,product,
sum(spend) as total_spend,
rank() over (PARTITION BY category order by sum(spend) DESC) as top
from product_spend
where extract(year from transaction_date)=2022
group by category,product) as a  
where top <=2
order by category
--Day15_EX8
select *
from(SELECT a.artist_name,
dense_rank() over (order by count(b.song_id) DESC) as artist_rank 
FROM artists as a
inner join songs as b on a.artist_id=b.artist_id
inner join global_song_rank as c on b.song_id=c.song_id
where c.rank<=10
group by a.artist_name) as a  
where artist_rank<=5
