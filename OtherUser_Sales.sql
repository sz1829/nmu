SELECT fname, lname, gender, phone, department_id, email, other_information
FROM Salesperson WHERE salesperson_code = 'sj';


/*if returns null*/

INSERT INTO Salesperson(fname, lname, salesperson_code, department_id, phone, email, description, gender, active_status)
VALUES 
(
    'sdf',
    'sdf',
    'sj',
    '1',
    '123213',
    '12313132',
    '123213',
    'M',
    'Y'
);

/*otherwise*/


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
