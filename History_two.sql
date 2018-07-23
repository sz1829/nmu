SELECT 
    t.transaction_id,
    t.salesperson_code,
    t.total_profit,
    t.received+t.received2 AS revenue,
    t.expense,
    (SELECT code FROM CouponCode WHERE cc_id = t.cc_id) AS couponCode,
    s.source_name, 
    t.clear_status,
    t.lock_status, 
    t.note
FROM Traansactions t
JOIN CustomerSource s ON t.source_id = s.source_id
WHERE t.transaction_id LIKE '%'
/*只点了“未完成订单”*/
AND t.clear_status = 'N'
AND t.lock_status = 'N'
/*点了“未完成订单”和“clear订单”*/
--AND t.lock_status = 'N'
/*点了“未完成订单”和“lock订单”，此时“clear订单”会自动被勾上*/
--无条件
/*只点了“clear订单”*/
--AND t.clear_status = 'Y'
--AND t.lock_status = 'N'
/*点了“clear订单”和“lock订单”*/
--AND t.clear_status = 'Y'
/*只点了“lock订单”，“clear”会被自动勾上，所以同上*/
/*三个全点*/
--无条件

/*备注：和之前版本唯一的区别在于，clear和lock同时勾上，应该是既看clear又看lock，所以是clear_status='Y'
还有一个地方要修改的是，只勾上lock不会自动勾上clear了。这里用到的默认前提是
网页里的”clear订单“是指”只clear但是还没有lock的单子“*/

AND t.create_time <= current_timestamp
AND t.create_time >= 0
AND t.payment_type LIKE '%'
AND 
(
    t.currency = 'USD'
    AND t.total_profit >= -999999999.99 
    AND t.total_profit <= 999999999.99
    AND t.expense >= -999999999.99
    AND t.expense <= 999999999.99
    AND t.received+t.received2 >= -999999999.99
    AND t.received+t.received2 <= 999999999.99
    )
    OR
    (t.currency = 'RMB'
    AND t.total_profit/(SELECT value FROM OtherInfo WHERE name = 'default_currency') >= -999999999.99
    AND t.total_profit/(SELECT value FROM OtherInfo WHERE name = 'default_currency') <= 999999999.99
    AND t.expense/(SELECT value FROM OtherInfo WHERE name = 'default_currency') >= -999999999.99
    AND t.expense/(SELECT value FROM OtherInfo WHERE name = 'default_currency') <= 999999999.99
    AND (t.received+t.received2)/(SELECT value FROM OtherInfo WHERE name = 'default_currency') >= -999999999.99
    AND (t.received+t.received2)/(SELECT value FROM OtherInfo WHERE name = 'default_currency') <= 999999999.99
    )
)
AND t.salesperson_code LIKE '%'
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
(
    SELECT transaction_id FROM Transactions WHERE airticket_tour_id IN 
    (
        SELECT DISTINCT airticket_tour_id FROM AirSchedule WHERE 
        depart_airport LIKE '%' 
        AND arrival_airport LIKE '%' 
        AND depart_date >= 0 
        AND depart_date <= current_timestamp
    )
)
ORDER BY ao.transaction_id DESC 
LIMIT 15;    