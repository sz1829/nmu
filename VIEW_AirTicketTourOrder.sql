/* **_____,**/
CREATE VIEW AirTicketTourOrder AS
SELECT 
t.transaction_id, 
date_format(t.create_time, '%Y-%m-%d') as 'create_time', 
date_format(t.settle_time, '%Y-%m-%d') as 'settle_time', 
s.salesperson_code, 
concat(c.fname, ' ', c.lname) as 'name',
/* concat(c.lname, c.fname) as 'name' */
t.currency, 
t.payment_type, 
t.total_profit, 
t.received,
t.received2,
t.expense, 
t.coupon,
a.flight_code, 
a.locators, 
a.ticket_type, 
a.round_trip,
concat(a.adult_number, ' / ', a.child_number, ' / ', a.infant_number) as 'passenger', 
concat(date_format(a.depart_date, '%Y-%m-%d'), ' / ', a.depart_location) as 'depart',
concat(date_format(a.arrival_date, '%Y-%m-%d'), ' / ', a.arrival_location) as 'arrival',
a.refunded,
sn.source_name, 
t.note,
t.clear_status,
t.lock_status
FROM AirticketTour a 
INNER JOIN Transactions t ON a.airticket_tour_id = t.airticket_tour_id
LEFT JOIN Salesperson s ON t.salesperson_id = s.salesperson_id
LEFT JOIN CustomerSource sn ON t.source_id = sn.source_id
LEFT JOIN Customer c ON a.customer_id = c.customer_id
ORDER BY transaction_id DESC

