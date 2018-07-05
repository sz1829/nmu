/*显示表格*/
SELECT 
transaction_id,
create_time,
product_code, 
wholesaler_code,
schedule,
currency, 
total_profit,
revenue, 
cost, 
coupon
FROM IndividualTourOrder
WHERE transaction_id LIKE '%'
AND create_time >= '%'
AND create_time < current_timestamp
AND product_code LIKE '%'
AND clear_status = 'N'
AND lock_status = 'N'
AND salesperson_code = 'hahk'
LIMIT 15;

/*点击其中一行*/
SELECT 
ito.product_code,
ito.tour_name, 
ito.salesperson_code,
ito.wholesaler_code, 
ito.indiv_name, 
ito.source_name, 
ito.note, 
it.depart_date, 
it.arrival_date, 
DATEDIFF(it.arrival_date-it.depart_date) as 'duration',
it.exchange_rate,
ito.cost 
FROM IndividualTourOrder ito
JOIN Transactions t
ON ito.transaction_id = t.transaction_id
JOIN IndividualTour it
ON it.indiv_tour_id = t.indiv_tour_id
WHERE transaction_id = '201';

/*获取该订单所有客户的信息，用来填充给客户表格*/
SELECT
cl.indiv_collection_id, 
cl.customer_id,
c.fname, 
c.lname, 
c.gender, 
c.birth_date, 
c.email, 
c.phone, 
c.zipcode, 
c.other_contact_type, 
c.other_contact_number, 
cl.join_date, 
cl.join_location, 
cl.leave_date, 
cl.leave_location, 
cl.note,
cl.currency,
cl.payment_type,
cl.payment_amount, 
cl.coupon
FROM TourDetails cl
JOIN Customer c
ON cl.customer_id = c.customer_id
WHERE 
cl.indiv_tour_id  = (SELECT indiv_tour_id FROM Transcations WHERE transaction_id = '201');

/*编辑其中一行客户*/

UPDATE TourDetails SET
join_date = '2018-01-01',
leave_date = '2018-01-02',
join_location = 'NY',
leave_location = 'SA',
currency = 'USD',
payment_type = 'cash',
payment_amount = 1234,
/************/
--coupon判断--
cc_id = 1,
coupon = (SELECT discount FROM CouponCode WHERE cc_id = 1),
/************/
note = '客户信息中的其他注意事项'
WHERE 
indiv_collection_id = v_indiv_collection_id;

UPDATE Customer SET 
fname = 'Alex',
lname = 'Deng',
gender = 'M', 
birth_date = '1994-10-22', 
email = 'sdasd@dfds.vad', 
phone = '12321443', 
zipcode = '21321', 
other_contact_type = 'wechat', 
other_contact_number = '123213213'
WHERE customer_id = v_customer_id;

UPDATE IndividualTour SET 
product_code = '团号',
tour_name = '团名',
salesperson_id = 
  (SELECT salesperson_id FROM Salesperson WHERE salesperson_code = 'ackui'),
wholesaler_id = 
  (SELECT wholesaler_id FROM Wholesaler WHERE wholesaler_code = 'wdy'),
indiv_number = 10,
depart_date = '2018-05-05',
arrival_date = '2018-05-10',
exchange_rate = 6.45
WHERE indiv_tour_id = v_indiv_tour_id;

/*重新计算一次总收益（和添加页面的SQL一样）*/
--得到v_received--

UPDATE Transactions SET 
source_id = 
  (SELECT source_id FROM CustomerSource WHERE source_name = 'Csin'),
note = '基本信息中的备注',
expense = 5000, /*'价格'*/
received = v_received /*'价格'*/
WHERE transction_id = 201;

