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
INNER JOIN AirticketTour a 
ON t.airticket_tour_id = a.airticket_tour_id
LEFT JOIN Wholesaler w 
ON a.wholesaler_id = w.wholesaler_id 
JOIN Customer c 
ON a.customer_id = c.customer_id 
JOIN Salesperson s 
ON s.salesperson_id = a.salesperson_id
WHERE t.transaction_id LIKE '%'
AND s.salesperson_code LIKE '%'
AND a.locators LIKE '%' 
AND t.settle_time > 0 
AND t.settle_time <= CURRENT_DATE + interval 1 day 
AND c.fname LIKE concat('%', '%', '%')
AND c.lname LIKE concat('%', '%', '%')
AND a.invoice >= 0
AND a.invoice <= 999999999
AND IFNULL(w.wholesaler_code, '') LIKE '%'
AND t.transaction_id IN (
SELECT transaction_id FROM FinanceStatus WHERE
IFNULL(lock_status, '') LIKE '%'
AND IFNULL(clear_status, '') LIKE '%'
AND IFNULL(paid_status, '') LIKE '%'
AND IFNULL(finish_status, '') LIKE '%');



SELECT 
    a.itinerary,
    s.salesperson_code,
    a.flight_code, 
    a.ticket_type, 
    a.round_trip,
    a.adult_number+a.youth_number+child_number+infant_numebr AS total_number,
    w.wholesaler_code,
    a.invoice,
    cs.source_name, 
    t.note, 
    a.exchange_rate_usd_rmb,
    a.deal_location, 
    a.selling_price,
    a.selling_currency,
    a.payment_type,
    t.total_profit,
    c.fname,
    c.lname, 
    a.adult_number,
    a.youth_number,
    a.child_number,
    a.infant_number,
    c.phone,
    c.email,
    c.birth_date,
    c.gender, 
    c.other_contact_type, 
    c.other_contact_number, 
    c.zipcode
FROM 
    AirticketTour a 
    JOIN Transactions t 
    ON a.airticket_tour_id = t.airticket_tour_id
    JOIN Salesperson s 
    ON a.salesperson_id = s.salesperson_id
    JOIN Wholesaler w 
    ON a.wholesaler_id = w.wholesaler_id   
    JOIN CustomerSource cs 
    ON cs.source_id = t.source_id 
    JOIN Customer c 
    ON a.customer_id = c.customer_id
WHERE t.transaction_id = 1;

SELECT 
    tc.following_id, 
    s.salesperson_code
FROM 
    TransactionCollections tc 
    JOIN Transactions t 
    ON t.transaction_id = tc.starter_id
    JOIN Salesperson s 
    ON s.salesperson_id = t.salesperson_id
WHERE tc.starter_id = 1;

     
    