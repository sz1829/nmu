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
AND salesperson_code LIKE 'sj'
AND clear_status = 'N'
AND lock_status = 'N'
LIMIT 15;

--click one row--

SELECT 
at.itinerary, 
s.salesperson_code, 
at.locators,
at.invoice,
at.flight_code,
at.round_trip,
at.ticket_type,
at.passenger_name,
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

SELECT flight_number, depart_date, depart_airport, arrival_airport FROM AirSchedule 
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
WHERE customer_id  = 21;


DELETE FROM AirScheduleIntegrated WHERE airticket_tour_id = 
(
    SELECT airticket_tour_id FROM Transactions WHERE transaction_id = '1'
);

DELETE FROM AirSchedule WHERE airticket_tour_id = 
(
    SELECT airticket_tour_id FROM Transactions WHERE transaction_id = '1'
);

UPDATE AirticketTour SET 
salesperson_id = (SELECT salesperson_id FROM Salesperson WHERE salesperson_code = 'sj'),
locators = 'ASDF123',
invoice = 'ASDSAF',
flight_code = 'SDFDSAF',
round_trip = 'round',
ticket_type = 'individual',
passenger_name = 'DSFS/SDFDSAF;DSFDS/DFSAF',
adult_number = 1,
child_number = 1,
infant_number = 0,
itinerary = "dsfsaf",
/*单独判断refund*/
refunded = 'N' 
WHERE airticket_tour_id = (SELECT airticket_tour_id FROM Transactions WHERE transaction_id = '1');

INSERT INTO AirSchedule 
(
    airticket_tour_id, 
    depart_airport, 
    arrival_airport,
    depart_date, 
    flight_number
)
VALUES 
(
    (SELECT airticket_tour_id FROM Transactions WHERE transaction_id = '1'), 
    'PVG',
    'EWR',
    '2018-01-01 01:01:01',
    'AA 123'
);

UPDATE Transactions SET 
salesperson_id = (SELECT salesperson_id FROM Salesperson WHERE salesperson_code = 'sj'),
note = 'dfhdsafhasf',
currency = 'USD',
payment_type = 'cash'
received = 1200,
received2 = 10,
expense = 1000,
/*coupon逻辑*/
cc_id = 1,
coupon = 100,
/*----*/
total_profit = received+received2-expense-coupon,
source_id = (SELECT source_id FROM CustomerSource WHERE source_name = 'Youtube')
WHERE transaction_id = '1';





-- UPDATE AirSchedule SET 
-- flight_number = 'SD1232',
-- depart_date = '2018-08-01',
-- depart_airport = 'SAF',
-- arrival_airport = 'SDF'
-- WHERE as_id = 1;

-- UPDATE AirTicketTour SET 
-- itinerary = 'dsfhdskahfdkshf',
-- salesperson_id = (
--     SELECT salesperson_id FROM Salesperson WHERE salesperson_code = 'sj'
-- ),
-- locators = 'dfiusahf1',
-- invoice = '1231sd',
-- flight_code = 'dfhdsif',
-- round_trip = 'round',
-- ticket_type = 'individual',
-- passenger_name = 'DFA/DSFDASF;DSF/DSFDSAG;DFD/SDFSADF',
-- adult_number = '1',
-- child_number = '1',
-- infant_number = '0',
-- /*refund 单独操作*/
-- refunded = 'Y',
-- /*后续增加旅行社管理*/
-- -- ta_id = (
-- --     SELECT ta_id FROM TravelAgency WHERE agency_name = 'DAFDAS'
-- -- )
-- WHERE airticket_tour_id = 
-- (
--     SELECT airticket_tour_id FROM Transactions WHERE transaction_id = '1'
-- );


