
/* insert one customer*/

SELECT customer_id FROM Customer 
WHERE fname = 'aaa' 
AND lname = 'bbb' 
AND birth_date = '1991-01-01';

/* check if the customer already exists in the database */

/*if the customer_id returns null, then insert a new one*/
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
    zipcode) 
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

INSERT INTO AirticketTour
(
    flight_code, 
    customer_id, 
    salesperson_id, 
    locators, 
    round_trip, 
    ticket_type, 
    adult_number, 
    child_number, 
    infant_number, 
    refunded, 
    passenger_name, 
    itinerary,
    invoice
) 
VALUES 
(
    'ADSFAWE',
    (SELECT customer_id FROM Customer WHERE fname = 'aaa' AND lname = 'bbb' AND birth_date = '1991-01-01'), 
    (SELECT salesperson_id FROM Salesperson WHERE salesperson_code = 'sj'), 
    'SWE123',
    'round', 
    'group', 
    2,
    1,
    0, 
    'N',
    'ZHANG/LIHUA, DING/RUICHENG, GU/WEIBI',
    '1P- 2GXDRA 
    1.1ZHANG/LIHUA*ADT  2.1DING/RUICHENG*ADT  3.1GU/WEIBI*ADT
    1 MF 830I 06APR FR LAXXMN HK3  1215A  530A#1/O $ E
    2 MF8127J 07APR SA XMNPEK HK3   900A 1150A/X $ E
    3 TVL ZZ MK3 MIS 18OCT18/CF-12345/AN-THANK YOU FOR THE BUSINESS	
    P- 1.E0Y-LEO
    T- 1.T/22DEC0341  1P/A81/XP*E7317092991188-190 N1.1/2.1/3.1
    A-CAOTTFLU
    TKG FAX-AUTO PRICED  FARE TYPE EX 
    FQ-    4PQ 
        FARE QUOTED 22DEC BY AGT-AM/A81 
        ADT LAX MF X/XMN MF BJS1560.00NUC1560.00END ROE1.00 MF 
            XF LAX4.5 
    )>*DH
    *DH 
    1 22DEC0341  1P/A81/XP*E7317092991190 
    GU/WEIBI*ADT 
    2 22DEC0341  1P/A81/XP*E7317092991189 
    DING/RUICHENG*ADT 
    3 22DEC0341  1P/A81/XP*E7317092991188 
    ZHANG/LIHUA*ADT 
    >*RA
    FOP- 1.CCAXXXXXXXXXXXX1013N1021 
    MU-  1. INV MGVPO8-657494 TTL SELLING 4552.80 CREDIT 0.00
    EOV- 1.E*EMULATION USED WITH SMI
            1-RS/DTK@A81/22DEC/0841Z
    EOR- 1.EY*PLEASE ENTER RETENTION LINE MACRO#
            7-XP/A81/22DEC/0841Z',
    'SDFEA123125'
);

-- get this airticket tour id--
SELECT max(airticket_tour_id) FROM AirticketTour 
WHERE salesperson_id = 'sj' 
AND customer_id = 
    (SELECT customer_id FROM Customer 
    WHERE fname = 'aaa' 
    AND lname = 'bbb' 
    AND birth_date = '1991-01-01');

-- store as --
-- v_airticket_tour_id


INSERT INTO AirSchedule 
(
    airticket_tour_id, 
    depart_airport, 
    arrival_airport,
    depart_date, 
    arrival_date, 
    flight_number
)
VALUES
(
    v_airticket_tour_id, 
    'PVG',
    'EWR',
    '2018-01-01 01:01:01',
    '2018-01-01 03:04:03',
    'AA 123'
);

INSERT INTO Transactions 
(
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
    clear_status,
    note
)
VALUES
(
    'airticket',
    v_airticket_tour_id,
    (SELECT salesperson_id FROM Salesperson WHERE salesperson_code = 'sj'), 
    NULL,
    100,
    10, 
    20, 
    1,
    'cash', 
    received+received2-expense-coupon, 
    current_timestamps, 
    (SELECT source_id FROM CustomerSource WHERE source_name = 'Icvaxibvc'),
    'USD', 
    'N', 
    'N', 
    NULL
);
