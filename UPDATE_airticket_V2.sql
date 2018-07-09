-- default table --
-- filtering --
SELECT 
transaction_id,
create_time, 
locators,
invoice, 
payment_type, 
currency, 
total_profit, 
received, 
received2,
expense,
coupon
FROM AirticketTourOrder
WHERE transaction_id LIKE '%'
AND create_time < current_timestamp 
AND create_time >= '%'
AND locators LIKE '%'
AND salesperson_code LIKE 'yvfpg'
AND clear_status = 'N'
AND lock_status = 'N'
LIMIT 15;

--click one row--

SELECT 
at.itinerary, 
s.salesperson_code, 
at.locators,
at.invoice,
at.round_trip,
at.ticket_type,
at.adult_number,
at.child_number, 
at.infant_number,
at.adult_number+at.child_number+at.infant_number AS 'total_number',
cs.source_name, 
t.note, 
t.currency, 
t.payment_type,
t.expense, 
t.received, 
t.received2, 
t.cc_id, 
t.coupon, 
c.customer_id, --get the customer_id for updating later--
c.fname, 
c.lname, 
c.phone, 
c.other_contact_type, 
c.other_contact_number, 
c.birth_date, 
c.gender, 
c.email,
c.zipcode
FROM AirTicketTour at 
JOIN Transactions t ON at.airticket_tour_id = t.airticket_tour_id
JOIN Salesperson s ON at.salesperson_id = s.salesperson_id
JOIN CustomerSource cs ON t.source_id = cs.source_id
JOIN Customer c ON at.customer_id = c.customer_id
WHERE t.transaction_id = '1';

SELECT flight_number, depart_airpart, arrival_airport FROM AirSchedule 
WHERE airticket_tour_id = (SELECT airticket_tour_id FROM Transactions WHERE transaction_id = '1');

UPDATE Customer SET 
fname = 'Shuangjin',
lname = 'Zhang',
phone = '1232894',
other_contact_type = 'wechat',
other_contact_number = '123213',
birth_date = '1990-01-01',
gender = 'M',
email = '13743@er.cpd',
zipcode = '12321'
WHERE customer_id  = 12;

UPDATE AirSchedule 