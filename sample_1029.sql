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
    a.adult_number+a.youth_number+a.child_number+a.infant_number AS total_number,
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

SELECT 
    mco_party,
    face_value, 
    face_currency,
    mco_value, 
    mco_currency, 
    mco_credit, 
    mco_credit_currency
FROM 
    McoPayment mp 
    JOIN AirticketTour a 
    ON a.mp_id = mp.mp_id 
    JOIN Transactions t 
    ON a.airticket_tour_id = t.airticket_tour_id 
WHERE t.transaction_id = 1;

INSERT INTO FinanceStatus(transaction_id,
              invoice,
              lock_status,clear_status,paid_status,finish_status,
              debt, received, selling_price, create_time,
              depart_date, arrival_date, following_id_collection,
              total_profit)
SELECT
            $transaction_id,
            $invoice, 'N', 'N', 'N', 'N', $base_price + $mco_value - $mco_credit,
            'CC',
            $sell_price,
            t.create_time,
            $depart_date_s,
            $depart_date_e,
            group_concat(tc.following_id SEPARATOR ','),
            $profit_trans
          FROM Transactions t
          JOIN TransactionCollections tc
          ON tc.starter_id = t.transaction_id
        WHERE t.transaction_id = $transaction_id
          GROUP BY tc.starter_id

          