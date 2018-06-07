SELECT 
it.trasanction_id, 
it.create_time,
it.salesperson_code,
it.total_profit,
it.revenue,
it.cost,
it.coupon,
it.source_name,
it.clear_status,
it.lock_status,
it.note,
it.product_code,
it.indiv_number,
it.schedule, 
it.wholesaler_code
FROM IndividualTourOrder it 
JOIN IndividualTour i 
ON it.transaction_id = i.transaction_id
WHERE it.transaction_id LIKE '%'

/*一样的逻辑

AND it.clear_status LIKE 'N' 
AND it.lock_status LIKE 'N' 

*/

AND i.create_time >= CURRENT_DATE - interval 1 month
AND i.create_time <= CURRENT_DATE
AND it.salesperson_code LIKE '%'
AND it.source_name LIKE '%'
AND it.indiv_number >= 0
AND it.indiv_number <= 9999
AND depart_date >= 0
AND arrival_date <= CURRENT_TIMESTAMP
AND tour_name LIKE '%%%'
/*若输入信息，替换中间的% */
AND wholesaler_code LIKE '%'
