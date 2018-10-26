-- SELECT 
--     t.transaction_id, 
--     s.salesperson_code, 
--     t.type, 
--     t.settle_time, 
--     concat(UPPER(c.lname), '/', c.fname) AS customer_name,
--     IFNULL(i.indiv_tour_invoice, a.invoice) AS invoice,
--     w.wholesaler_code, 
--     IFNULL(i.payment_type, a.payment_type) AS payment_type,
SELECT * FROM 
(
SELECT 
    concat(mp.face_currency, ' ', mp.face_value) AS payment_amount,
    t.transaction_id, 
    s.salesperson_code, 
    t.type, 
    DATE_FORMAT(t.settle_time, '%y-%m-%d') AS settle_time, 
    concat(UPPER(c.lname), '/', c.fname) AS customer_name,
    a.invoice, 
    w.wholesaler_code, 
    a.payment_type,
    IFNULL(fs.lock_status, '') AS lock_status, 
    IFNULL(fs.clear_status, '') AS clear_status, 
    IFNULL(fs.paid_status, '') AS paid_status, 
    IFNULL(fs.finish_status, '') AS finish_status, 
    a.locators, 
    a.deal_location, 
    group_concat(tc.following_id SEPARATOR ',') AS following_id
    FROM Transactions t 
    JOIN Salesperson s 
    ON t.salesperson_id = s.salesperson_id
    JOIN AirticketTour a 
    ON t.airticket_tour_id = t.airticket_tour_id
    JOIN Customer c 
    ON a.customer_id = c.customer_id
    JOIN Wholesaler w 
    ON a.wholesaler_id = w.wholesaler_id
    LEFT JOIN FinanceStatus fs 
    ON fs.transaction_id = t.transaction_id 
    LEFT JOIN TransactionCollections tc 
    ON t.transaction_id = tc.starter_id 
    JOIN McoPayment mp 
    ON mp.mp_id = a.mp_id
    WHERE t.transaction_id LIKE '%'
    AND s.salesperson_code LIKE '%'
    AND t.type LIKE '%'
    AND t.settle_time > 0
    AND t.settle_time < CURRENT_DATE + interval 1 day 
    AND c.lname LIKE '%'
    AND c.fname LIKE '%'
    AND a.invoice LIKE '%' OR '%'
    OR (a.invoice >= 0 AND a.invoice <= 99999999999)
    AND w.wholesaler_code LIKE '%'
    AND a.payment_type LIKE '%'
    AND mp.face_value LIKE '%'
    AND fs.lock_status LIKE '%'
    AND fs.clear_status LIKE '%'
    AND fs.paid_status LIKE '%'
    AND fs.finish_status LIKE '%'
    GROUP BY tc.starter_id 





UNION

    concat(a.selling_currency, ' ', a.selling_price) AS payment_amount,

) the_table
ORDER BY invoice ASC, transaction_id DESC





-- insert into transactioncollections (starter_id , following_id ) values 
-- (1,1), 
-- (2,2), 
-- (3,3), 
-- (4, 4)