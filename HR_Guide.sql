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
concat(other_con)