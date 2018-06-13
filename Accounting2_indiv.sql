/* click one order */

/* first for the little window in the left corner*/
SELECT currency, revenue, cost, coupon, total_profit FROM IndividualTourOrder WHERE transaction_id = '123';


/* and then, get the list*/
SELECT currency, payment_amount, cc_id, coupon FROM TourDetails WHERE indiv_collection_id = 250;

/* update some info of the whole order*/
-- update expense, 这里只有成本可以改
UPDATE Transactions SET expense = '1525', total_profit = received + received2 - expense - coupon WHERE transaction_id = '250';

/* update some info of a specific customer*/
--去掉成本
--折扣使用分情况

--使用折扣码
UPDATE TourDetails SET payment_amount = '123', cc_id = 'abc', coupon = (
    SELECT discount FROM CouponCode WHERE cc_id = 'abc'
) WHERE indiv_collection_id = 250;



--使用折扣金额
UPDATE TourDetails SET payment_amount = '123', cc_id = NULL, coupon = '123' WHERE indiv_collection_id = 250;;

--使用rmb
UPDATE TourDetails SET payment_amount = '123'/(SELECT value FROM OtherInfo WHERE name = 'default_currency'), cc_id = NULL, coupon = '123' WHERE indiv_collection_id = 250;

/*clear*/
-- indiv_collection_id

UPDATE TourDetails SET clear_status = 'Y' WHERE indiv_collection_id IN ('2');

/*lock*/

UPDATE TourDetails SET clear_status = 'Y', lock_status = 'Y' WHERE indiv_collection_id IN ('2', '3');


