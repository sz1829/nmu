
/* insert one customer*/

SELECT customer_id from Customer WHERE fname = 'aaa' and lname = 'bbb' AND birth_date = '1991-01-01';

/* check if the customer already exists in the database */

/* if yes, store that customer_id */
v_customer_id

/*if the customer_id returns null, then insert a new one*/
INSERT INTO Customer(fname, lname, email, phone, other_contact_type, other_contact_number, birth_date, gender, zipcode) 
VALUES
(
    'aaa', 
    'bbb', 
    'ccc@ddd.com', 
    '123456789', 
    NULL, 
    NULL, 
    '1993/01/02', 
    'M', 
    NULL
);

/* 取得上面这个刚插入的顾客的id */

SELECT customer_id from Customer WHERE fname = 'aaa' and lanem = 'bbb' AND birth_date = '1993-01-02';
/*store that customer_id */
v_customer_id

/* obtain salesperson_id */

SELECT salesperson_id FROM Salesperson WHERE salesperson_code = 'xtrteb'

v_salersperson_id


INSERT INTO AirticketTour(flight_code, customer_id, salesperson_id, locators, round_trip, ticket_type, adult_number, child_number, infant_number, depart_date, depart_location, arrival_date, arrival_location, note) 
VALUES 
(
    'aa',
    v_customer_id, 
    v_salersperson_id, 
    'aaa',
    'Y', 
    'group', 
    2,1,0, 
    '2018/05/01 01:01:01', 
    'SM', 
    '2018/05/02 02:02:02', 
    'JYP', 
    NULL
);

/* check if the coupon code has expired */
SELECT cc_id, discount, exipred FROM CouponCode WHERE code = 'whatever'
 /* if not exipred, store the cc_id and discount into variables */
 v_cc_id, v_discount

/* if an amount of money is input as coupon, set v_cc_id as NULL*/
v_discount 



INSERT INTO Transactions(
    type,
    airticket_tour_id, 
    salesperson_id,
    cc_id,
    coupon,
    expense, 
    received, 
    received2, 
    payment_type, 
    total_profit, 
    create_time, 
    source_id, 
    currency, 
    lock_status, 
    clear_status
) VALUES 
(
    'airticket', 
    (SELECT airticket_tour_id FROM AirticketTour WHERE salesperson_id = v_salersperson_id AND customer_id = v_customer_id
    ORDER BY airticket_tour_id DESC LIMIT 1),
    v_cc_id,
    v_discount, 
    10, 
    20, 
    1,
    'cash', 
    received+received2-expense-v_discount, 
    current_timestamps, 
    (SELECT source_id FROM CustomerSource WHERE source_name = 'Icvaxibvc'),
    'USD', 
    'N', 
    'N'
)