SELECT fname, lname, gender, phone, department_id, email, other_information
FROM Salesperson WHERE salesperson_code = 'sj';

UPDATE Salesperson SET
fname = 'Shuangjin', 
lname = 'Zhang', 
gender = 'M', 
phone = '123456789', 
department_id = '1', 
email = 'leinto0371@gmail.com', 
other_information = 'super boot power'
WHERE salesperson_code = 'sj';

UPDATE UserAccount SET
password = 'hahaha'
WHERE account_id = 'sj';
