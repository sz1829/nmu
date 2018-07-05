INSERT INTO IndividualTour(product_code, tour_name, wholesaler_id, salesperson_id, indiv_number, depart_date, arrival_date, exchange_rate)
VALUES
(
'团号',
'团名',
(SELECT wholesaler_id FROM Wholesaler WHERE wholesaler_code = 'vmued')
(SELECT salesperson_id FROM Salesperson WHERE salesperson_code = 'xtrteb')
'参团人数',
'出发日期',
'结束日期',
6.59
);

/*得到indiv_tour_id*/

SELECT indiv_tour_id from IndividualTour WHERE salesperson_id = 
(SELECT salesperson_id FROM Salesperson WHERE salesperson_code = 'xtrteb')
ORDER BY indiv_tour_id DESC LIMIT 1; 

/* store this indiv_tour_id in a variable*/
v_indiv_tour_id

/* insert one customer, and repeart this process until all customers are inserted into table Customers and TourDetails */

SELECT customer_id from Customer WHERE fname = 'aaa' and lanem = 'bbb' AND birth_date = '1991-01-01'

/* check if the customer already exists in the database */


/* if yes, store that customer_id */
v_customer_id

/*if the customer_id returns null, then insert a new one*/
INSERT INTO Customer(fname, lname, email, phone, other_contact_type, other_contact_number, birth_date, gender, zipcode) 
VALUES
(
'名',
'姓',
'邮箱',
'电话',
'其他联系方式',
'联系信息', 
'生日',
'性别',
'邮政编码',
'其他信息'
);

/* 取得上面这个刚插入的顾客的id */

SELECT customer_id from Customer WHERE fname = 'aaa' and lanem = 'bbb' AND birth_date = '1991-01-01'
ORDER BY customer_id DESC LIMIT 1;

/*store that customer_id */
v_customer_id

/*把这个顾客的id用于其他表*/


INSERT INTO TourDetails(customer_id, indiv_tour_id, join_date, leave_date, join_location, leave_location, note, currency, payment_type, payment_amount, cc_id, coupon)
VALUES
(
v_customer_id,
v_indiv_tour_id,
'参团时间',
'离团时间',
'参团地点',
'离团地点',
'备注', 
'USD', 
100,
'creditcard',
NULL,
50);

/* check if the coupon code has expired */
SELECT cc_id, discount, exipred FROM CouponCode WHERE code = 'whatever'
 /* if not exipred, store the cc_id and discount into variables */
 v_cc_id, v_discount

/* if an amount of money is input as coupon, set v_cc_id as NULL*/
v_discount 


/*计算总收益*/
v_received


/* 插入Transactions表 */
INSERT INTO Transactions(
    type, 
    lock_status, 
    clear_status, 
    indiv_tour_id, 
    salesperson_id, 
    cc_id, 
    coupon, 
    expense, /* ‘价格’改成’总花费‘ */
    received, /*收到现金*/
    payment_type, 
    total_profit, 
    note, 
    create_time, 
    source_id, 
    currency)
VALUES(
    'individual', 
    'N',
    'N', 
    v_indiv_tour_id, 
    v_cc_id, 
    v_discount, 
    4000,
    v_received, 
    'cash', 
    received2+received-expense-v_discount,
    NULL,
    '2018-01-01',
    (SELECT source_id FROM CustomerSource WHERE source_name = 'Icvaxibvc'),
    'USD'
);