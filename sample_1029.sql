use nmu;

SELECT 
    t.transaction_id,
    a.locators, 
    concat(UPPER(c.fname), '/', c.lname) AS customer_name, 
    w.wholesaler_code, 
    a.deal_location, 
    concat(REPLACE(REPLACE(a.selling_currency, 'USD', '$'), 'RMB', '￥'), a.selling_price) AS selling,
    concat(REPLACE(REPLACE(a.base_currency, 'USD', '$'), 'RMB', '￥'), a.base_price) AS base,
    a.payment_type, 
    t.total_profit
FROM Transactions t 
JOIN AirticketTour a 
ON t.airticket_tour_id = a.airticket_tour_id
JOIN Customer c 
ON a.customer_id = c.customer_id 
LEFT JOIN Wholesaler w 
ON a.wholesaler_id = w.wholesaler_id 
JOIN FinanceStatus fs 
ON fs.airticket_tour_id = a.airticket_tour_id
WHERE t.transaction_id LIKE '%'
AND a.locators LIKE '%' 
AND t.settle_time > 0 
AND t.settle_time <= CURRENT_DATE + interval 1 day 
AND c.fname LIKE concat('%', '%', '%')
AND c.lname LIKE concat('%', '%', '%')
AND a.invoice >= 0
AND a.invoice <= 999999999
AND IFNULL(w.wholesaler_code, '') LIKE '%'
AND IFNULL(fs.lock_status, '') LIKE '%'
AND IFNULL(fs.clear_status, '') LIKE '%'
AND IFNULL(fs.paid_status, '') LIKE '%'
AND IFNULL(fs.finish_status, '') LIKE '%'
