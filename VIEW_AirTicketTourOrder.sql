/* **_____,**/
CREATE VIEW AirTicketTourOrder AS
SELECT 
t.transaction_id, 
date_format(t.create_time, '%Y-%m-%d') as 'create_time', 
s.salesperson_code, 
concat(c.fname, ' ', c.lname) as 'name',
/*if Chinese, concat(c.lname, c.fname) as 'name' */
t.currency, 
t.payment_type, 
t.total_profit, 
t.received,
t.received2,
t.expense, 
t.coupon,
a.flight_code, 
a.locators, 
a.invoice,
a.ticket_type, 
a.round_trip,
concat(a.adult_number, ' / ', a.child_number, ' / ', a.infant_number) as 'passenger', 
asi.all_schedule,
a.refunded,
sn.source_name, 
t.note,
t.clear_status,
t.lock_status
FROM AirticketTour a 
LEFT JOIN AirScheduleIntegrated asi 
ON a.airticket_tour_id = asi.airticket_tour_id
INNER JOIN Transactions t ON a.airticket_tour_id = t.airticket_tour_id
LEFT JOIN Salesperson s ON t.salesperson_id = s.salesperson_id
LEFT JOIN CustomerSource sn ON t.source_id = sn.source_id
LEFT JOIN Customer c ON a.customer_id = c.customer_id
ORDER BY transaction_id DESC

