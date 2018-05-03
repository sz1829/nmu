/* get the transaction_id as
v_indiv_tour_id
*/
SELECT
indiv_tour_id
FROM Transactions
WHERE
transaction_id = '201'

/*get customer list*/
SELECT * FROM
(SELECT
cl.indiv_tour_id, 
c.fname, c.lname, c.gender, c.birth_date, c.email, c.phone, c.zipcode, c.other_contact_type, c.other_contact_number, 
cl.join_date, cl.join_location, cl.leave_date, cl.leave_location, cl.note
FROM TourDetails cl
JOIN Customer c
ON cl.customer_id = c.customer_id) client_board
WHERE 
indiv_tour_id  = v_indiv_tour_id

/*
each row
if chinese
$full_name = lname+fname 
otherwise
$full_name = fname + ' ' + lname

if gender but no birth_date
$clientInfo = $full_name + '/' + gender
if birth_date but no gender
$clientInfo = $full_name + '/' + birth_date
if both
$clientInfo = $full_name + '/' + gender + '/' + birth_date
else
$clientInfo = $full_name

$otherContact = other_contact_tyep + ': ' + other_contact_number
if other_contact_number is null, set $otherContact as empty
$joinDL = join_date + '/' + join_location
$leaveDL = leave_date + '/' + leave_location

if either is null, adjust the format

*/

/*get the order details*/
SELECT * FROM
(SELECT 
ito.transaction_id,
ito.product_code, 
ito.tour_name, 
ito.salesperson_code, 
ito.wholesaler_code,
ito.indiv_number, 
ito.source_name, 
ito.note, 
ito.depart_date, 
ito.arrival_date, 
DATEDIFF(ito.arrival_date - ito.depart_date) AS 'duration', 
ito.currency, 
ito.payment_type, 
ito.cost, 
t.received, 
t.received2,
t.cc_id, 
ito.coupon
FROM 
IndividualTourOrder ito 
JOIN Transactions t
ON ito.transaction_id = t.transaction_id) indiv_tour_default_display
WHERE transaction_id = '201'


