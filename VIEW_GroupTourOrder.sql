/* default display */
CREATE VIEW GroupTourOrder AS
SELECT 
t.transaction_id, 
date_format(t.create_time, '%Y-%m-%d') as 'create_time', 
g.group_code, 
s.salesperson_code, 
(g.leader_number+g.tourist_number) as 'total_number',
t.currency, 
t.payment_type,
t.total_profit,
g.price,
concat(g.total_cost, '(', g.reserve, '/', g.write_off, ')') AS 'cost', 
g.flight_number, 
g.bus_company, 
concat(date_format(g.start_date, '%Y-%m-%d'), '/', date_format(g.end_date, '%Y-%m-%d')) as 'schedule', 
concat(tg.fname, ' ', tg.lname) AS 'guide_name', 
tg.phone AS 'guide_phone', 
g.agency_name, 
cs.source_name, 
t.coupon AS 'coupon', 
t.clear_status, 
t.lock_status,
t.note
FROM Transactions t 
INNER JOIN GroupTour g ON t.group_tour_id = g.group_tour_id
LEFT JOIN TouristGuide tg ON g.guide_id = tg.guide_id
LEFT JOIN CustomerSource cs ON t.source_id = cs.source_id
LEFT JOIN CouponCode cc ON t.cc_id = cc.cc_id
LEFT JOIN Salesperson s ON t.salesperson_id = s.salesperson_id
ORDER BY t.transaction_id DESC

