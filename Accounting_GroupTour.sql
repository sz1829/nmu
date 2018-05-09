/*
default display
*/

SELECT * FROM 
(SELECT 
t.clear_status, 
t.lock_status, 
gto.transaction_id, 
gto.group_code, 
t.create_time, 
gto.salesperson_code, 
gto.agency_name,  
concat(currencyToIcon(gto.currency), gto.price, ' | ', t.expense, ' | ', gto.profit) AS 'transaction_details', 
gto.coupon
FROM GroupTourOrder gto 
LEFT JOIN Transactions t 
ON gto.transaction_id = t.transaction_id
) default_display
WHERE lock_status = 'N'
ORDER BY create_time DESC 
LIMIT 20;
  /* click on web to load 40 or more records*/


/*use the value of clear_status to decide what bg-color 
this row will use*/



/*-----------------------------------------*/

/*
Sorting
*/
SELECT * FROM 
(SELECT 
t.clear_status, 
t.lock_status, 
gto.transaction_id, 
gto.group_code, 
gto.create_time, 
gto.salesperson_code, 
gto.agency_name,  
concat(currencyToIcon(gto.currency), gto.price, ' | ', t.expense, ' | ', gto.profit) AS 'transaction_details', 
gto.coupon
FROM GroupTourOrder gto 
LEFT JOIN Transactions t 
ON gto.transaction_id = t.transaction_id
) default_display
WHERE lock_status = 'N'
ORDER BY salesperson_code ASC 
/*take salesperson_code for example*/ 
/*press one time, default sorting is by 'ASC'. Press again, switch to 'DESC' */
LIMIT 20;
  /* click on web to load 40 or more records*/


/*---------------------------------------*/

/*
click one transation
*/


SELECT
currency, 
(received+received2) as 'price', 
expense, 
cc_id,
coupon,
total_profit
FROM Transactions
WHERE transaction_id = v_transaction_id

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

SELECT * FROM
(SELECT 
gto.transaction_id, 
gto.group_code, 
t.create_time, 
gto.salesperson_code, 
gto.agency_name,  
concat(gto.currency, ' ', gto.price, ' | ', t.expense, ' | ', gto.profit) AS 'transaction_details', 
gto.coupon
FROM GroupTourOrder gto 
JOIN Transactions t 
ON gto.transaction_id = t.transaction_id
) default_display_table
WHERE 
transaction_id LIKE '%'
AND group_code LIKE '%'
AND agency_name LIKE '%'
AND salesperson_code LIKE '%'
AND create_time > '%' 
AND create_time < '%'

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
cc_id = (SELECT cc_id FROM CouponCode WHERE code = '2b8Wzzh0UbOL7UK4sVE5'), 
coupon  = (SELECT discount FROM CouponCode WHERE code = '2b8Wzzh0UbOL7UK4sVE5'), 
total_profit = 9328 /*calculated at web */
WHERE transaction_id  = 2;

/* coupon amount */
UPDATE Transactions SET 
currency = 'RMB',
received = 10000, 
expense = 606, 
cc_id = NULL,
coupon = 700,
total_profit = 8694 /*calculated at web */
WHERE transaction_id  = 2;

/* no coupon */
UPDATE Transactions SET 
currency = 'RMB',
received = 10000, 
expense = 606, 
cc_id = NULL,
coupon = NULL,
total_profit = 9394 /*calculated at web */
WHERE transaction_id  = 2;

/* update group tour */
UPDATE GroupTour SET
price = 10000,
total_cost = 606
WHERE group_tour_id = 
(SELECT group_tour_id FROM Transactions
WHERE transaction_id = 2);