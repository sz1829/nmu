/*默认显示*/

SELECT 
question_id,
question_title, 
question_time, 
ask_salesperson_id, 
answer_content, 
question_status, 
question_content, 
ta_id, 
source
FROM QuestionBoard 
WHERE question_type LIKE 'airticket'
LIMIT 20;

/*输入旅行社名称*/
SELECT 
question_id,
question_title, 
question_time, 
ask_salesperson_id, 
answer_content, 
question_status, 
question_content, 
ta_id, 
source
FROM QuestionBoard 
WHERE question_type LIKE 'airticket'
AND ta_id = (SELECT ta_id FROM TravelAgency WHERE agency_name = 'ADSF')
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
    ta_id, 
    source
) VALUES
(
    'fhdlsiahf',
    current_timestamp,
    '1',
    'dsfhdsf',
    NULL,
    'namei'
);

