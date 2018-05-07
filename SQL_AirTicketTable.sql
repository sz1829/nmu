SELECT 
transaction_id,
create_time, 
flight_code, 
locators,
depart,
arrival,
payment_type, 
currency, 
total_profit, 
received, 
received2,
expense,
coupon
FROM AirticketTourOrder
WHERE transaction_id LIKE '%'
AND create_time < current_timestamp 
AND create_time >= '%'
AND locators LIKE '%'
AND salesperson_code LIKE 'yvfpg'
AND clear_status = 'N'
AND lock_status = 'N'
LIMIT 15;