
-----------------------------
-- STEP 0 GET INDIV_TOUR_ID--
-----------------------------


--get indiv_tour_id--
SELECT indiv_tour_id FROM Transactions WHERE transaction_id = 289;
--as v_indiv_tour_id--


----------------------------
-- STEP 1 GET CUSTOMER_ID --
----------------------------

      --check if the customer exits--
      SELECT customer_id FROM Customer WHERE fname = 'Vvesvo' AND lname = 'Oypqgczv' AND birth_date = '2010-07-29' LIMIT 1;
        --if returns a value
        --store it as v_customer_id
        --if returns null
        /*
        INSERT INTO Customer
        (
            fname, 
            lname, 
            email, 
            phone, 
            other_contact_type,
            other_contact_number, 
            birth_date, 
            gender, 
            zipcode
        ) VALUES
        (
            'he',
            'hangwei',
            NULL, 
            NULL, 
            NULL, 
            NULL, 
            NULL, 
            NULL, 
            NULL 
        )
        */
          --get the new customer_id--
            SELECT customer_id FROM Customer WHERE fname = 'Vvesvo' AND lname = 'Oypqgczv' AND birth_date = '2010-07-29' LIMIT 1;

---------------------------------------
-- STEP 2 MODIFY CUSTOMER INFO ON WEB--
---------------------------------------

  --click on '添加新客户'--
      INSERT INTO Customer
        (
            fname, 
            lname, 
            email, 
            phone, 
            other_contact_type,
            other_contact_number, 
            birth_date, 
            gender, 
            zipcode
        ) VALUES
        (
            'he',
            'hangwei',
            NULL, 
            NULL, 
            NULL, 
            NULL, 
            NULL, 
            NULL, 
            NULL 
        );


  --click on '编辑'--
    --编辑窗口的信息来自 之前 已储存的数据--
    --数据修改后点击‘确认修改’， 更新后台数据--
  

  --click on '删除'--
    DELETE FROM TourDetails
    WHERE customer_id = v_customer_id AND indiv_tour_id = v_indiv_tour_id

-----------------
--STEP 3 UPDATE--
-----------------

UPDATE TourDetails
SET 
join_date = '2018-05-10',
leave_date = '2018-05-11',
join_location = 'ny',
leave_location = 'la',
note = 'haha'
WHERE customer_id = v_customer_id AND indiv_tour_id = v_indiv_tour_id
 /* repeat the update for each customer */

UPDATE IndividualTour
SET 
product_code = '团号',
tour_name = '团名',
salesperson_id = 
  (SELECT salesperson_id FROM Salesperson WHERE salesperson_code = 'ackui'),
wholesaler_id = 
  (SELECT wholesaler_id FROM Wholesaler WHERE wholesaler_code = 'wdy'),
indiv_number = 10,
depart_date = '2018-05-05',
arrival_date = '2018-05-10'
WHERE indiv_tour_id = v_indiv_tour_id;



UPDATE Transactions
SET 
currency = 'USD',
payment_type = 'creditcard',
source_id = 
  (SELECT source_id FROM CustomerSource WHERE source_name = 'Csin'),
note = 'haha',
expense = 5000, /*'价格'*/
received = 10000, /*'价格'*/


    
/* 关于coupon的逻辑和独立团是一样的，需要注意的是计算total profit的时候多了一个received2
,
total_profit = received-expense
/*

+-----------------------------------------------------+
| click on 'apply' when coupon code is selected, add  |
+-----------------------------------------------------+
-----------------------------------------------------------------------------
,
cc_id = 
  (SELECT cc_id FROM CouponCode WHERE code = 'IKrp3KiGV06yuH1GsQ62'),
coupon = 
  (SELECT discount FROM CouponCode WHERE code = 'IKrp3KiGV06yuH1GsQ62')
total_profit = received-expense-coupon
------------------------------------------------------------------------------
我记得这里你有个php是专门判断是否expired的，你自行应用一下
------------------------------------------------------------------------------
+-----------------------------------------------------+
| click on 'apply' when coupon amount is select, add  |
+-----------------------------------------------------+
-----------------------------------------------------------------------------
,
coupon = 5
total_profit = received-expense-coupon


*/
WHERE transaction_id = 289;