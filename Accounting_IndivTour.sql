/*
default display
*/

SELECT * FROM 
(SELECT
t.clear_status, 
t.lock_status,
t.transaction_id, 
it.product_code, 
t.create_time, 
s.salesperson_code, 
it.indiv_number,
concat(w.name, '(', w.wholesaler_code, ')') as 'wholesaler', 
concat(t.currency, ' ', t.received, ' | ', t.expense, ' | ', t.total_profit) as 'transaction_details', 
t.coupon
FROM Transactions t 
RIGHT JOIN IndividualTour it 
ON t.indiv_tour_id = it.indiv_tour_id
JOIN wholesaler w 
ON it.wholesaler_id = w.wholesaler_id
JOIN salesperson s 
ON t.salesperson_id = s.salesperson_id) default_display
WHERE lock_status = 'N'
ORDER BY create_time DESC
LIMIT 20; /* click on web to load 40 or more records*/

/*use the value of clear_status to decide what bg-color 
this row will use*/


/*-----------------------------------------*/

/*---------------------------------------*/

/*
click one transation
*/

SELECT 
currency, 
received+received2 as 'price', 
expense, 
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

/*---------------------------------------*/

/*
filter 
*/

/* 
有参团人数筛选
*/
SELECT
t.clear_status, 
t.lock_status,
t.transaction_id, 
it.product_code, 
t.create_time, 
s.salesperson_code, 
it.indiv_number,
concat(w.name, '(', 
w.wholesaler_code, ')') as 'wholesaler', 
concat(t.currency, ' ', t.received+t.received2, ' | ', t.expense, ' | ', t.total_profit) as 'transaction_details', 
t.coupon
FROM Transactions t 
RIGHT JOIN IndividualTour it 
ON t.indiv_tour_id = it.indiv_tour_id
JOIN wholesaler w 
ON it.wholesaler_id = w.wholesaler_id
JOIN salesperson s 
ON t.salesperson_id = s.salesperson_id
WHERE t.lock_status = 'N'
AND t.transaction_id LIKE '%'
AND it.product_code LIKE '%'
AND s.salesperson_code LIKE '%'
AND w.wholesaler_code LIKE '%'
AND indiv_number >= 5
AND create_time > '%' 
AND create_time < current_timestamp
ORDER BY indiv_number ASC,
t.create_time DESC 
LIMIT 20;

/*
无参团人数筛选
*/

SELECT
t.clear_status, 
t.lock_status,
t.transaction_id, 
it.product_code, 
t.create_time, 
s.salesperson_code, 
it.indiv_number,
concat(w.name, '(', w.wholesaler_code, ')') as 'wholesaler', 
concat(t.currency, ' ', t.received+t.received2, ' | ', t.expense, ' | ', t.total_profit) as 'transaction_details', 
t.coupon
FROM Transactions t 
RIGHT JOIN IndividualTour it 
ON t.indiv_tour_id = it.indiv_tour_id
JOIN wholesaler w 
ON it.wholesaler_id = w.wholesaler_id
JOIN salesperson s 
ON t.salesperson_id = s.salesperson_id
WHERE t.lock_status = 'N'
AND t.transaction_id LIKE '%'
AND it.product_code LIKE '%'
AND s.salesperson_code LIKE '%'
AND w.wholesaler_code LIKE '%'
AND create_time > '%' 
AND create_time < current_timestamp
ORDER BY
t.create_time DESC 
LIMIT 20;

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
expense = 606, 
cc_id = 1, 
coupon  = 18, 
total_profit = 9376 /*calculated at web */
WHERE transaction_id  = 290;


/* coupon amount or coupon amount is 0*/
UPDATE Transactions SET 
currency = 'RMB',
received = 10000, 
expense = 606, 
cc_id = NULL,
coupon = 700, /* or 0 */
total_profit = 8694 /*calculated at web */
WHERE transaction_id  = 290;


/* no coupon */
UPDATE Transactions SET 
currency = 'RMB',
received = 10000, 
expense = 606, 
cc_id = NULL,
coupon = NULL,
total_profit = 9394 /*calculated at web */
WHERE transaction_id  = 290;


