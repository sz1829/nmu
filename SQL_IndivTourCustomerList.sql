CREATE VIEW IndivTourCustomerList AS
SELECT 
td.indiv_tour_id, 
concat(c.fname, ' ', c.lname) AS 'full_name', 
date_format(td.join_date, '%Y-%m-%d') AS 'join_date', 
td.join_location, 
date_format(td.leave_date, '%Y-%m-%d') AS 'leave_date', 
td.leave_location, 
c.phone, 
concat(c.other_contact_type, ': ', c.other_contact_number) as 'other_contact',
td.note
FROM TourDetails AS td LEFT JOIN Customer AS c ON td.customer_id = c.customer_id;