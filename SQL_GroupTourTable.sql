SELECT 
transaction_id, 
create_time, 
group_code, 
salesperson_code, 
schedule,
payment_type, 
currency, 
profit, 
price, 
cost,
coupon
FROM GroupTourOrder
WHERE 
transaction_id LIKE '%'
AND create_time >= '%'
AND create_time < current_timestamp 
AND group_code LIKE '%' 
AND clear_status = 'N' 
AND lock_status = 'N'
LIMIT 15

