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
t.total_profit as 'profit',
t.received AS price,
concat(g.total_cost, '(', g.reserve, '/', sum(gtg.write_off), ')') AS 'cost', 
t.coupon AS 'coupon', 
g.flight_number, 
g.bus_company, 
concat(date_format(g.start_date, '%Y-%m-%d'), '/', date_format(g.end_date, '%Y-%m-%d')) as 'schedule', 
group_concat(concat(tg.fname, ' ', tg.lname) SEPARATOR ', ') AS 'guide_name', 
group_concat(tg.phone SEPARATOR ', ') AS 'guide_phone', 
group_concat(gtg.write_off SEPARATOR ', ') AS 'guide_write_off',
(SELECT w.wholesaler_code FROM Wholesaler w WHERE w.wholesaler_id = g.wholesaler_id) as 'agency_name',
cs.source_name, 
t.clear_status, 
t.lock_status,
t.note
FROM Transactions t 
INNER JOIN GroupTour g ON t.group_tour_id = g.group_tour_id
LEFT JOIN CustomerSource cs ON t.source_id = cs.source_id
LEFT JOIN CouponCode cc ON t.cc_id = cc.cc_id
LEFT JOIN Salesperson s ON t.salesperson_id = s.salesperson_id
JOIN GroupTourGuideDetails gtg ON g.group_tour_id = gtg.group_tour_id
JOIN TouristGuide tg ON gtg.guide_id = tg.guide_id
GROUP BY g.group_tour_id 
ORDER BY t.transaction_id DESC