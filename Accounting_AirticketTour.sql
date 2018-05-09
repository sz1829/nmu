/*
default display
*/


/* 这里*/
SELECT 
ato.clear_status, 
ato.lock_status,
ato.transaction_id, 
ato.locators, 
ato.flight_code, 
ato.create_time, 
ato.salesperson_code, 
ato.payment_type, 
concat(ato.currency, ' ', ato.received, ' | ', ato.received2, ' | ', ato.expense, ' | ', ato.total_profit) as 'transaction_details',
ato.coupon
FROM AirticketTourOrder ato
WHERE ato.lock_status = 'N'
LIMIT 20

/*
click on one transaction
*/
SELECT 
currency, 
received, /*总机票价格*/
expense, /*总成本价*/
received2, /*返现*/
cc_id, 
coupon, 
total_profit
FROM Transactions
WHERE transaction_id = v_transaction_id;

/*
if coupon = null, then 
leave the two 'coupon' buttons unselected. 
else  
if cc_id is not null, press the 'coupon code' button. otherwise, press the 'coupon amount' button
fill the textbox with the value of 'coupon' 
*/ 

------------------------------

/*
filter
没有用到航空公司
*/
SELECT 
ato.clear_status, 
ato.lock_status,
ato.transaction_id, 
ato.locators, 
ato.flight_code, 
ato.create_time, 
ato.salesperson_code, 
ato.payment_type, 
concat(ato.currency, ' ', ato.received, ' | ', ato.received2, ' | ', ato.expense, ' | ', ato.total_profit) as 'transaction_details',
ato.coupon
FROM AirticketTourOrder ato
JOIN Transactions t 
ON ato.transaction_id = t.transaction_id
JOIN AirTicketTour att
ON t.airticket_tour_id = att.airticket_tour_id
WHERE /*ato.lock_status = 'N'
AND */ato.transaction_id LIKE '%'
AND ato.locators LIKE  '%'
AND ato.salesperson_code LIKE '%'
AND att.adult_number+att.child_number+att.infant_number LIKE '%'
AND ato.create_time >= '%'
AND ato.create_time < current_timestamp
LIMIT 20

/*
clear
*/

UPDATE Transactions
SET clear_status = 'Y'
WHERE transaction_id = v_transaction_id
OR transaction_id = v_transaction_id2
OR transaction_id = v_transaction_id3
/* continue with more transation_id selected*/

/*
lock
*/


UPDATE Transactions
SET clear_status = 'Y', lock_status = 'Y'
WHERE transaction_id = v_transaction_id
OR transaction_id = v_transaction_id2
OR transaction_id = v_transaction_id3
/* continue with more transation_id selected*/

/*
update
*/

/* coupon code */
UPDATE Transactions SET 
currency = 'RMB',
received = 10000, 
received2 = 1,
expense = 606, 
cc_id = 1, 
coupon  = 18, 
total_profit = 9377 /*calculated at web */
WHERE transaction_id  = 490;


/* coupon amount or coupon amount is 0*/
UPDATE Transactions SET 
currency = 'RMB',
received = 10000, 
received2 = 1,
expense = 606, 
cc_id = NULL,
coupon = 700, /* or 0 */
total_profit = 8695 /*calculated at web */
WHERE transaction_id  = 490;


/* no coupon */
UPDATE Transactions SET 
currency = 'RMB',
received = 10000, 
received2 = 1,
expense = 606, 
cc_id = NULL,
coupon = NULL,
total_profit = 9395 /*calculated at web */
WHERE transaction_id  = 490;


