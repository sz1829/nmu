SELECT 
transaction_id,
create_time,
product_code, 
tour_name, 
salesperson_code, 
wholesaler_code,
schedule,
payment_type,
currency, 
total_profit,
revenue, 
cost, 
coupon
FROM IndividualTourOrder
WHERE transaction_id LIKE '%'
AND create_time >= '%'
AND create_time < current_timestamp
AND product_code LIKE '%'
AND clear_status = 'N'
AND lock_status = 'N'
LIMIT 15;
