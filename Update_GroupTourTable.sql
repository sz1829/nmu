SELECT 
gto.transaction_id, 
create_time, 
group_code, 
schedule,
payment_type, 
currency, 
profit, 
price, 
cost,
coupon
FROM GroupTourOrder gto
JOIN Transations t 
ON gto.transaction_id = t.transaction_id 
WHERE 
transaction_id LIKE '%'
AND create_time >= '%'
AND create_time < current_timestamp 
AND group_code LIKE '%' 
AND clear_status = 'N' 
AND lock_status = 'N'
AND salesperson_code = 'fzjrlct'

/**/

ORDER BY t.



LIMIT 15

