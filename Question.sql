/*默认显示*/

SELECT 
question_id,
question_title, 
question_time, 
(SELECT salesperson_code FROM Salesperson WHERE salesperson_id = ask_salesperson_id) AS 'salesperson_code', 
answer_content, 
question_status, 
question_content, 
(SELECT agency_name FROM TravelAgency WHERE ta_id = qb.ta_id) AS 'agency_name'
FROM QuestionBoard qb
ORDER BY question_id DESC
LIMIT 20;

/*输入旅行社名称*/
SELECT 
question_id,
question_title, 
question_time, 
(SELECT salesperson_code FROM Salesperson WHERE salesperson_id = ask_salesperson_id) AS 'salesperson_code', 
answer_content, 
question_status, 
question_content, 
(SELECT agency_name FROM TravelAgency WHERE ta_id = qb.ta_id) AS 'agency_name'
FROM QuestionBoard qb
WHERE ta_id = (SELECT ta_id FROM TravelAgency WHERE agency_name = 'sakula')
LIMIT 20;

/*解答*/
UPDATE QuestionBoard SET 
answer_content = "dsgfuiasflasgflasdfd", 
question_status = 'solved'
WHERE question_id = '1';

/*添加*/
INSERT INTO QuestionBoard 
(
    question_title,
    question_time, 
    ask_salesperson_id,
    question_content,
    ta_id
) VALUES
(
    'fhdlsiahf',
    current_timestamp,
    '1',
    'dsfhdsf',
    NULL
);

