/*默认显示*/
SELECT 
ta_id, 
agency_name, 
email, 
phone, 
create_time, 
concat(address, ' ', zipcode, ' ', country) as 'agency_address',
active_status, 
description
FROM TravelAgency
ORDER BY ta_id DESC ;

/*点击一行*/
SELECT 
agency_name, 
email, 
phone, 
create_time, 
address, 
zipcode, 
country,
description
FROM TravelAgency
WHERE ta_id = '1';

/*添加*/
INSERT INTO TravelAgency
(
    agency_name,
    description, 
    email, 
    phone, 
    active_status, 
    create_time, 
    address,
    zipcode,
    country
) VALUES 
(
    'test',
    'dsfaf',
    'sdfaf',
    '123213123',
    'Y',
    '2018-09-09',
    'dfafa',
    '123123',
    'werewaf'
);

/*修改*/
UPDATE TravelAgency SET
agency_name = 'dsfdsf',
description = 'sdfsafsa', 
email = 'sdfsafsa', 
phone ='12321313', 
active_status = 'Y', 
create_time = '2018-09-09', 
address = 'dfsfdsaf',
zipcode = 'dfdsafsafds',
country = 'dfs'
WHERE ta_id = '1';
