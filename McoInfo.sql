INSERT INTO NoticeBoard (
    valid_until, 
    edited_by, 
    content,
    gotop, 
    category
) VALUES (
    current_timestamp + interval 10 hour,
    1, 
    NULL, 
    'N',
    'MCO'
);
/*get that notice_id*/
INSERT INTO NoticeTarget (
    notice_id, 
    target_id
) VALUES (6, (SELECT user_id FROM UserAccount WHERE account_id = 'sj'));

INSERT INTO McoInfo (
    cardholder, 
    card_number, 
    exp_date, 
    security_code, 
    billing_address, 
    phone_issuing_bank, 
    charging_amount_currency, 
    charging_amount, 
    notice_id, 
    create_time,
    note
) VALUES (
    'test',
    'test',
    '0819',
    '123',
    'test',
    'test',
    'USD',
    123,
    6, 
    current_timestamp,
    NULL
);

