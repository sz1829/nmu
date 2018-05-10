/*
default display
*/


SELECT 
guide_id, 
concat(lname, fname) as name, 
/*if either of lname and fname is not Chinese, use 
concat(lname, ' ', fname) as name, 
*/
gender, 
/* convert M, F, UNKNOWN to Chinese*/
age, 
phone,
email, 
concat(other_contact_type, ': ', other_contact_number) as 'other_contact',
descriptions
FROM TouristGuide
ORDER BY guide_id DESC
LIMIT 20;

/*
filter
*/
SELECT 
guide_id, 
concat(lname, fname) as name, 
/*if either of lname and fname is not Chinese, use 
concat(lname, ' ', fname) as name, 
*/
gender, 
/* convert M, F, UNKNOWN to Chinese*/
age, 
phone,
email, 
concat(other_contact_type, ': ', other_contact_number) as 'other_contact',
descriptions
FROM TouristGuide
WHERE (lname LIKE '%%%' OR fname LIKE '%%%')
AND gender LIKE '%'
ORDER BY guide_id DESC
LIMIT 20;



/*
click one
*/

SELECT 
fname,
lname,
gender, 
age, 
phone,
email, 
other_contact_type,
other_contact_number,
descriptions
FROM TouristGuide
WHERE guide_id = v_guide_id;

/*
modify
*/

UPDATE TouristGuide 
SET 
fname = 'haha',
lname = 'heihei',
gender = 'M',
age = 22,
phone = '123902184',
email = NULL,
other_contact_type = 'QQ',
other_contact_number = '10000',
descriptions = 'Dont add my QQ'
WHERE guide_id = v_guide_id;

/*
add
*/

INSERT INTO TouristGuide
(
    fname, 
    lname,
    gender,
    age,
    phone, 
    email,
    other_contact_type,
    other_contact_number,
    descriptions
)
VALUES
(
    'haha',
    'heihei',
    'M',
    33,
    '1232414',
    '312321132@qq.com',
    NULL,
    NULL,
    NULL
);

/*
delete
*/

DELETE FROM TouristGuide
WHERE guide_id = v_guide_id;