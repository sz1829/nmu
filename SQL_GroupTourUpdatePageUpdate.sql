--get the group tour id--
SELECT group_tour_id FROM Transactions WHERE transaction_id = 2;
--as v_group_tour_id--


UPDATE GroupTour
SET flight_number = 'ABC123',
bus_company = 'haha',
salesperson_id = 
  (SELECT salesperson_id FROM Salesperson WHERE salesperson_code = 'ackui'),
guide_id = 
  (SELECT guide_id FROM TouristGuide WHERE fname = 'Nlqoiynur' AND lname = 'Ybjruxh'),
agency_name = 'hello', 
leader_number = 2,
tourist_number = 10,
start_date = '2018-05-10', 
end_date = '2018-05-15',
duration = 5,
price = 2000,
reserve = 1000,
write_off = 100,
total_cost = 1300, 
other_expense = total_cost - reserve - write_off
WHERE group_tour_id = v_group_tour_id

-- no click on coupon 'apply' button--
UPDATE Transactions 
SET 
salesperson_id = 
  (SELECT salesperson_id FROM Salesperson WHERE salesperson_code = 'ackui'),
expense = 1300,
received = 2000,
settle_time = current_timestamp,
source_id = 
  (SELECT source_id FROM CustomerSource WHERE source_name = 'Bbthxu'),
currency = 'USD', 
note = 'hahaha'

/*
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
WHERE group_tour_id = v_group_tour_id;




