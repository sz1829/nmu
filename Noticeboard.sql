/*表格显示*/
--管理员登陆--
/*只查看未过期+公告*/
SELECT category, edited_by, content 
FROM NoticeBoard 
WHERE valid_until >= CURRENT_DATE
ORDER BY no.tice_id DESC;

/*MCO*/
SELECT n.category, n.edited_by, 
IFNULL(n.content, concat('Card Holder: ', m.cardholder, '\n', 
'Card Number: ', m.card_number,  '\n',
'EXP Date: ', m.exp_date, '\n', 
'Security Code: ', m.security_code, '\n', 
'Billing Address: ', m.billing_address, '\n',
'Issuing Bank Phone: ', m.phone_issuing_bank, '\n', 
'Currency: ', m.charging_amount_currency, '\n',
'Amount: ', m.charging_amount,  '\n'
)) AS 'content'
FROM NoticeBoard n 
JOIN McoInfo m 
ON n.notice_id = m.notice_id
WHERE valid_until >= CURRENT_DATE
AND category = 'MCO' 
ORDER BY n.notice_id DESC;


/*添加*/

INSERT INTO NoticeBoard(
    valid_until, 
    edited_by, 
    target_at,
    content, 
    gotop,
    category
)
 VALUES (
    '2018-12-12',
    1, 
    NULL, 
    'dfsafasdfdsafsdafsadf',
    'Y',
    'notice'
);



/*index*/

SELECT 


