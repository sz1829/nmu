SELECT 
    ao.transaction_id,
    ao.create_time, 
    ao.salesperson_code,
    ao.currency,
    ao.total_profit,
    ao.received, 
    ao.received2, 
    ao.expense,
    (SELECT cc.code FROM CouponCode cc WHERE cc.cc_id = t.cc_id) as 'code',
    ao.coupon,
    ao.source_name,
    ao.clear_status,
    ao.lock_status,
    ao.note,
    ao.locators,
    ao.invoice,
    ao.flight_code,
    ao.round_trip,
    ao.ticket_type,
    a.adult_number+a.child_number+a.infant_number AS passenger_number,
    ao.refunded,
    ao.agency_name
FROM AirticketTourOrder ao 
JOIN Transactions t ON ao.transaction_id = t.transaction_id
JOIN AirticketTour a ON t.airticket_tour_id = a.airticket_tour_id
JOIN Customer c ON a.customer_id = c.customer_id
WHERE ao.transaction_id LIKE '%'
/*只点了“未完成订单”*/
AND ao.clear_status = 'N'
AND ao.lock_status = 'N'
AND ao.locators LIKE '%'
AND ao.create_time <= current_timestamp
AND ao.create_time >= 0
AND ao.payment_type LIKE '%'
AND 
(
    (ao.currency = 'USD'
    AND ao.total_profit >= -999999999.99 
    AND ao.total_profit <= 999999999.99
    AND ao.expense >= -999999999.99
    AND ao.expense <= 999999999.99
    AND ao.received+ao.received2 >= -999999999.99
    AND ao.received+ao.received2 <= 999999999.99
    )
    OR
    (ao.currency = 'RMB'
    AND ao.total_profit/(SELECT value FROM OtherInfo WHERE name = 'default_currency') >= -999999999.99
    AND ao.total_profit/(SELECT value FROM OtherInfo WHERE name = 'default_currency') <= 999999999.99
    AND ao.expense/(SELECT value FROM OtherInfo WHERE name = 'default_currency') >= -999999999.99
    AND ao.expense/(SELECT value FROM OtherInfo WHERE name = 'default_currency') <= 999999999.99
    AND (ao.received+ao.received2)/(SELECT value FROM OtherInfo WHERE name = 'default_currency') >= -999999999.99
    AND (ao.received+ao.received2)/(SELECT value FROM OtherInfo WHERE name = 'default_currency') <= 999999999.99
    )
)
AND ao.salesperson_code LIKE '%'
AND ao.source_name LIKE '%'
AND ao.agency_name LIKE '%'
AND a.adult_number <= 1
ANd a.adult_number >= 1
AND a.child_number <= 9999
ANd a.child_number >= 0
AND a.infant_number <= 9999
ANd a.infant_number >= 0
AND ao.flight_code LIKE '%'
AND ao.transaction_id IN 
(SELECT transaction_id FROM Transactions WHERE airticket_tour_id IN (SELECT DISTINCT airticket_tour_id FROM AirSchedule WHERE 
depart_airport LIKE '%' 
AND arrival_airport LIKE '%' 
AND depart_date >= 0 
AND depart_date <= current_timestamp))
AND 
/*仅中间的%用于替换*/
(c.fname LIKE '%%%'
OR c.lname LIKE '%%%')
AND ao.round_trip LIKE '%'
AND ao.ticket_type LIKE '%'
AND ao.refunded LIKE '%'
ORDER BY ao.transaction_id DESC LIMIT 15;
