/*默认显示表格*/


SELECT 
    IFNULL(ask_salesperson_id, ta_id) AS 'question_man', 
    question_time, 
    question_title, 
    question_content, 
    quesntion_content 
FROM QuestionBoard 
WHERE question_status LIKE 'pending'
ORDER BY question_id DESC 
LIMIT 15;


/*添加*/

--显示关键字

SELECT words FROM FrequentWords WHERE user_id = '2';

--新增关键词

INSERT INTO FrequentWords(words, user_id) VALUES('hello', 2);

--去掉关键词

DELETE FROM FrequentWords WHERE words = 'hello' AND user_id = 2;

--提交提问内容

----先看一下这个人是不是旅行社的----
SELECT ta_id FROM Salesperson WHERE salesperson_code = 'sj';
----如果返回了一个值，则----
INSERT INTO QuestionBoard(
    question_title, 
    question_time, 
    ta_id,
    question_content
) VALUES(
    'hello',
    current_timestamp,
    '刚刚取到的ta_id',
    'fhdsikauhfdksaihfsdklajfhdsklahflsakjhf'
);
----如果返回了NULL， 则----
INSERT INTO QuestionBoard(
    question_title, 
    question_time, 
    ask_salesperson_id,
    question_content
) VALUES(
    'hello',
    current_timestamp,
    2,
    'fhdsikauhfdksaihfsdklajfhdsklahflsakjhf'
);


--回复解答、

UPDATE QuestionBoard SET answer_content = 'fdjskhagfdksahf', question_status = 'solved' WHERE question_id = 1;

