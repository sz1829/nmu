SELECT 
ato.flight_code, 
ato.salesperson_code, 
ato.locators, 
ato.round_trip, 
ato.ticket_type,
att.adult_number, 
att.child_number, 
att.infant_number,
ato.source_name,
ato.note,
att.depart_date, 
att.depart_location, 
att.arrival_date, 
att.arrival_location, 
ato.currency,
ato.payment_type, 
ato.expense,
ato.received, 
ato.received2,
t.cc_id,
t.coupon
FROM AirTicketTourOrder ato
JOIN Transactions t 
ON ato.transaction_id = t.transaction_id
JOIN AirTicketTour att 
ON t.airticket_tour_id = att.airticket_tour_id
WHERE ato.transaction_id = 490

/*
customer
*/

SELECT 
fname, 
lname, 
phone, 
other_contact_type, 
other_contact_number, 
birth_date, 
gender, 
email, 
zipcode
FROM Customer 
WHERE customer_id = 
  (SELECT customer_id FROM AirTicketTour WHERE airticket_tour_id = 
    (SELECT airticket_tour_id FROM Transactions WHERE transaction_id = 490)  
  );


