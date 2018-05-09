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
SELECT 
t.transaction_id,
it.product_code, 
it.tour_name, 
s.salesperson_code, 
w.wholesaler_code,
it.indiv_number, 
sn.source_name, 
t.note, 
it.depart_date, 
it.arrival_date, 
DATEDIFF(it.arrival_date,it.depart_date) AS 'duration', 
t.currency, 
t.payment_type, 
t.expense, 
t.received, 
t.cc_id, 
t.coupon
FROM 
Transactions t
RIGHT JOIN IndividualTour it
ON t.indiv_tour_id =  it.indiv_tour_id
JOIN Salesperson s 
ON t.salesperson_id = s.salesperson_id
JOIN Wholesaler w 
ON it.wholesaler_id = w.wholesaler_id
JOIN CustomerSource sn 
ON t.source_id = sn.source_id
WHERE transaction_id = '201'


