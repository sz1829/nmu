--get airticket_tour_id--
SELECT airticket_tour_id FROM Transactions WHERE transaction_id = 490;
--as v_airticket_tour_id--

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




UPDATE AirTicketTour 
SET 
flight_code = 'haha',
salesperson_id = 
  (SELECT salesperson_id FROM Salesperson WHERE salesperson_code = 'ackui'),
locators = 'HRHR',
round_trip = 'oneway',
ticket_type = 'group',
adult_number = 5,
child_number = 1,
infant_number = 0,
depart_date = '2018-06-11',
depart_location = 'NWK',
arrival_date = '2018-06-30',
arrival_location = 'PGA',
customer_id = v_customer_id
WHERE airticket_tour_id = v_airticket_tour_id;

UPDATE Transactions
SET 
salesperson_id = 
  (SELECT salesperson_id FROM Salesperson WHERE salesperson_code = 'ackui'),
currency = 'USD',
payment_type = 'creditcard',
source_id = 
  (SELECT source_id FROM CustomerSource WHERE source_name = 'Csin'),
note = 'haha',
expense = 5000, /*'价格'*/
received = 10000, /*'价格'*/

/* 关于coupon的逻辑和独立团是一样的，需要注意的是计算total profit的时候多了一个received2
,
total_profit = received+received2-expense
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
total_profit = received+received2-expense-coupon
------------------------------------------------------------------------------
我记得这里你有个php是专门判断是否expired的，你自行应用一下
------------------------------------------------------------------------------
+-----------------------------------------------------+
| click on 'apply' when coupon amount is select, add  |
+-----------------------------------------------------+
-----------------------------------------------------------------------------
,

coupon = 5,
total_profit = received+received2-expense-coupon

*/

WHERE transaction_id = 490;