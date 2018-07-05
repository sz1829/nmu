SELECT last_time_login FROM UserAccount WHERE account_id = 'sj';

SELECT count(*) FROM ThingsToDo WHERE user_id = 'sj' AND type = 'notice';



/* 日历*/
--for default display
SELECT title, create_time, importance FROM ThingsToDo WHERE create_time >= DATE_FORMAT(CURRENT_DATE, '%Y-&m-01')
AND create_time < DATE_FORMAT(CURRENT_DATE, '%Y-&m-01') + interval 1 month
AND user_id = 'sj';


INSERT INTO ThingsToDo(create_time, content, user_id, importance, type, title) 
VALUES (CURRENT_DATE, 
        'dfhi hf  isdhfis  dhfdfhi hf  isdhfis  dhfdfhi hf  isdhfis  dhfdfhi hf  isdhfis  dhf', 
        'sj', 
        'highlight', 
        'calendar', 
        'dfhi ');

-- 点击以后显示
SELECT title, content FROM ThingsToDo WHERE create_time = '2018-07-05' AND user_id ='sj';


UPDATE ThingsToDo SET 
title = 'dfuhdisf',
content = 'dfhi hf  isdhfis  dhfdfhi hf  isdhfis  dhfdfhi hf  isdhfis  dhfdfhi hf  isdhfis  dhf'
WHERE create_time = '2018-07-05' AND user_id = 'sj';

DELETE FROM ThingsToDo WHERE tto_id = (SELECT tto_id FROM ThingsToDo WHERE create_time = '2018-07-05' AND user_id = 'sj');


/*待处理事项*/
--default display
SELECT tto_id, title, content, importance FROM ThingsToDo WHERE user_id ='sj' ORDER BY tto_id DESC LIMIT 10;


INSERT INTO ThingsToDo(create_time, content, user_id, importance, type, title) 
VALUES (current_timestamp, 
        'dfhi hf  isdhfis  dhfdfhi hf  isdhfis  dhfdfhi hf  isdhfis  dhfdfhi hf  isdhfis  dhf', 
        'sj', 
        'normal', 
        'notice', 
        'dfhi ');


-- 点击以后显示

SELECT title, content FROM ThingsToDo WHERE tto_id = 1;

UPDATE ThingsToDo SET 
title = 'dfuhdisf',
content = 'dfhi hf  isdhfis  dhfdfhi hf  isdhfis  dhfdfhi hf  isdhfis  dhfdfhi hf  isdhfis  dhf'
WHERE tto_id = 1;

DELETE FROM ThingsToDo WHERE tto_id = 1;

/*公告*/

SELECT content, char1, char2, char3 FROM NoticeBoard WHERE valid_until >= CURRENT_DATE  ORDER BY notice_id DESC;

/* 4个饼图 */

-- total
SELECT count(*) FROM Transactions 
WHERE salesperson_id = (SELECT salesperson_id FROM Salesperson WHERE salesperson_code = 'sj')
AND create_time <= current_timestamp
AND create_time >= DATE_FORMAT(CURRENT_DATE, '%Y-%m-01');

SELECT sum(total_profit) FROM Transactions
WHERE currency = 'USD'
AND salesperson_id = (SELECT salesperson_id FROM Salesperson WHERE salesperson_code = 'sj')
AND create_time <= current_timestamp
AND create_time >= DATE_FORMAT(CURRENT_DATE, '%Y-%m-01');

SELECT sum(total_profit) / (SELECT value FROM OtherInfo WHERE name = 'default_currency') FROM Transactions
WHERE currency = 'RMB'
AND salesperson_id = (SELECT salesperson_id FROM Salesperson WHERE salesperson_code = 'sj')
AND create_time <= current_timestamp
AND create_time >= DATE_FORMAT(CURRENT_DATE, '%Y-%m-01');

-- group
SELECT count(*) FROM Transactions 
WHERE type = 'group'
AND salesperson_id = (SELECT salesperson_id FROM Salesperson WHERE salesperson_code = 'sj')
AND create_time <= current_timestamp
AND create_time >= DATE_FORMAT(CURRENT_DATE, '%Y-%m-01');

SELECT sum(total_profit) FROM Transactions
WHERE currency = 'USD'
AND type = 'group'
AND salesperson_id = (SELECT salesperson_id FROM Salesperson WHERE salesperson_code = 'sj')
AND create_time <= current_timestamp
AND create_time >= DATE_FORMAT(CURRENT_DATE, '%Y-%m-01');

SELECT sum(total_profit) / (SELECT value FROM OtherInfo WHERE name = 'default_currency') FROM Transactions
WHERE currency = 'RMB'
AND type = 'group'
AND salesperson_id = (SELECT salesperson_id FROM Salesperson WHERE salesperson_code = 'sj')
AND create_time <= current_timestamp
AND create_time >= DATE_FORMAT(CURRENT_DATE, '%Y-%m-01');

-- individual
SELECT count(*) FROM Transactions 
WHERE salesperson_id = (SELECT salesperson_id FROM Salesperson WHERE salesperson_code = 'sj')
AND type = 'individual'
AND create_time <= current_timestamp
AND create_time >= DATE_FORMAT(CURRENT_DATE, '%Y-%m-01');

SELECT sum(total_profit) FROM Transactions
WHERE currency = 'USD'
AND type = 'individual'
AND salesperson_id = (SELECT salesperson_id FROM Salesperson WHERE salesperson_code = 'sj')
AND create_time <= current_timestamp
AND create_time >= DATE_FORMAT(CURRENT_DATE, '%Y-%m-01');

SELECT sum(total_profit) / (SELECT value FROM OtherInfo WHERE name = 'default_currency') FROM Transactions
WHERE currency = 'RMB'
AND type = 'individual'
AND salesperson_id = (SELECT salesperson_id FROM Salesperson WHERE salesperson_code = 'sj')
AND create_time <= current_timestamp
AND create_time >= DATE_FORMAT(CURRENT_DATE, '%Y-%m-01');

-- airticket
SELECT count(*) FROM Transactions 
WHERE salesperson_id = (SELECT salesperson_id FROM Salesperson WHERE salesperson_code = 'sj')
AND type = 'airticket'
AND create_time <= current_timestamp
AND create_time >= DATE_FORMAT(CURRENT_DATE, '%Y-%m-01');

SELECT sum(total_profit) FROM Transactions
WHERE currency = 'USD'
AND type = 'airticket'
AND salesperson_id = (SELECT salesperson_id FROM Salesperson WHERE salesperson_code = 'sj')
AND create_time <= current_timestamp
AND create_time >= DATE_FORMAT(CURRENT_DATE, '%Y-%m-01');

SELECT sum(total_profit) / (SELECT value FROM OtherInfo WHERE name = 'default_currency') FROM Transactions
WHERE currency = 'RMB'
AND type = 'airticket'
AND salesperson_id = (SELECT salesperson_id FROM Salesperson WHERE salesperson_code = 'sj')
AND create_time <= current_timestamp
AND create_time >= DATE_FORMAT(CURRENT_DATE, '%Y-%m-01');
