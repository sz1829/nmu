/*
default display
*/

SELECT 
salesperson_id, 
salesperson_code, 
concat(lname, fname) as name, 
/*if any of lname and fname is not Chinese, use 
concat(lname, ' ', fname) as name, 
*/
gender, 
/* convert M, F, UNKNOWN to Chinese*/
phone, 
d.department_name, 
email,
s.description
FROM Salesperson s
JOIN Department d 
ON s.department_id = d.department_id
ORDER BY salesperson_id DESC
LIMIT 20;


/*
filter
*/

SELECT 
salesperson_id, 
salesperson_code, 
concat(lname, fname) as name, 
/*if any of lname and fname is not Chinese, use 
concat(lname, ' ', fname) as name, 
*/
gender, 
/* convert M, F, UNKNOWN to Chinese*/
phone, 
d.department_name, 
email,
s.description
FROM Salesperson s
JOIN Department d 
ON s.department_id = d.department_id
WHERE salesperson_code LIKE '%'
AND (lname LIKE '%%%' /*if input, use '%'+$fromInput+'%' */
OR fname LIKE '%%%') /* if input, use '%'+$fromInput+'%' */
AND s.department_id LIKE  
   (SELECT department_id FROM Department WHERE department_name = 'Xian')
ORDER BY salesperson_id DESC
LIMIT 20;



/*
click one
*/
SELECT
lname, 
fname, 
salesperson_code,
gender,
phone, 
d.department_name, 
email,
s.description
FROM Salesperson s
JOIN Department d 
ON s.department_id = d.department_id
WHERE salesperson_id = v_salesperson_id

/*
modify
*/

UPDATE
Salesperson
SET 
lname = 'haha',
fname = 'heihei',
salesperson_code = 'hh',
gender = 'M',
phone = '123',
department_id = 
   (SELECT department_id FROM Department WHERE department_name = 'Manhattan'),
email = 'haha@heihei.com',
description = 'Yep'
WHERE salesperson_id = 50;

/*
add
*/
INSERT INTO Salesperson
(
    lname, 
    fname, 
    salesperson_code,
    gender, 
    phone, 
    department_id,
    email,
    description
) VALUES
(
    'jjj',
    'ooo',
    'jo',
    'F',
    '435326346',
    (SELECT department_id FROM Department WHERE department_name = 'Xian'),
    '666@666.com',
    'Nope'
)

/*
delete
*/

DELETE FROM Salesperson
WHERE salesperson_id = v_salesperson_id