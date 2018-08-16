/*表格显示*/
--管理员登陆--
/*只查看未过期公告*/
SELECT notice_id, category, edited_by, content FROM NoticeBoard WHERE valid_untile <= CURRENT_DATE AND target_at LIKE '%';
/*只查看未过期公告+只看MCO*/
SELECT n.notice_id, n.category, n.edited_by, 
m.cardholder, 
m.card_number, 
m.exp_date, 
m.security_code, 
m.billing_address,
m.phone_issuing_bank, 
m.charging_amount_currency,
m.charging_amount
FROM NoticeBoard n 
JOIN McoInfo m 
ON n.notice_id = m.notice_id
WHERE valid_until <= CURRENT_DATE AND target_at LIKE '%' AND category = 'MCO';

/*只看MCO*/

SELECT n.notice_id, n.category, n.edited_by, 
m.cardholder, 
m.card_number, 
m.exp_date, 
m.security_code, 
m.billing_address,
m.phone_issuing_bank, 
m.charging_amount_currency,
m.charging_amount
FROM NoticeBoard n 
JOIN McoInfo m 
ON n.notice_id = m.notice_id
WHERE target_at LIKE '%' AND category = 'MCO';

/*没有勾选*/

SELECT n.notice_id, n.category, n.edited_by, 
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
WHERE target_at LIKE '%' AND category = 'MCO';

/**/
/**/
