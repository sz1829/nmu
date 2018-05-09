/*
default display
*/

SELECT 
salesperson_id, 
salesperson_code, 
concat(lname, fname) as name, 
/*if either of lname and fname is not Chinese, use 
concat(lname, ' ', fname) as name, 
*/
gender, 
/* convert M, F, UNKNOWN to Chinese*/
phone, 
depart_location, 
email,
description
FROM Salesperson
LIMIT 20;

/*
click one
*/