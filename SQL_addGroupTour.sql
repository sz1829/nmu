/* 如果输入的导游不在数据库里，则先添加新导游，仅记录基本信息，包括名字和联系号码 */

/* 插入导游表*/
INSERT INTO TouristGuide(fname, phone) VALUES('Alex', '1234567890');


/* 插入独立团表 */
INSERT INTO GroupTour(
    group_code, 
    flight_number, 
    bus_company, 
    salesperson_id, 
    guide_id,
    agency_name,  
    leader_number, 
    tourist_number, 
    start_date, 
    end_date, 
    duration, 
    price, 
    reserve, 
    write_off, 
    total_cost, 
    note
    ) VALUES(
        'YAHAHA', 12345, 'MOLA', (SELECT salesperson_id FROM Salesperson WHERE salesperson_code = 'sana'), 
        (SELECT guide_id FROM TouristGuide WHERE fname = 'Alex'), 
        '新东方',
        2,
        30,
        '2017-10-22', 
        '2017-11-22', 
        30,
        6000, 
        1500,
        800,
        4000,
        NULL
    );

/* '来源' 这个数据同理'导游' */

INSERT INTO CustomerSource(source_name) VALUES('LLL');


/* get the salesperson's id */

SELECT salesperson_id FROM Salesperson WHERE salesperson_code = 'whatever'

/* store the salesperson's id to a varibale */
v_salesperson_id

/* check if the coupon code has expired */
SELECT cc_id, discount, exipred FROM CouponCode WHERE code = 'whatever'
 /* if not exipred, store the cc_id and discount into variables */
 v_cc_id, v_discount

/* if an amount of money is input as coupon, set v_cc_id as NULL*/
v_discount 


/* 插入Transactions表 */
INSERT INTO Transactions(
    type, 
    lock_status, 
    clear_status, 
    group_tour_id, 
    salesperson_id, 
    cc_id, /*v_cc_id*/
    coupon, /*v_discount*/
    expense, 
    received, 
    payment_type,
    total_profit, 
    note, 
    create_time, 
    source_id, 
    currency)
VALUES(
    'group', 
    'N',
    'N', 
    (SELECT group_tour_id FROM GroupTour WHERE group_code = 'YAHAHA' AND 
    salesperson_id = v_salesperson_id ORDER BY group_tour_id DESC LIMIT 1), 
    v_salesperson_id, 
    v_cc_id, 
    v_discount,
    4000,
    6000, 
    'cash',
    received2+received-expense-v_discount
    NULL,
    '2018-01-01',
    (SELECT source_id FROM CustomerSource WHERE source_name = 'LLL'),
    'USD'
);

