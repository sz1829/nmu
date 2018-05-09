/*
default display
*/

SELECT 
wholesaler_id, 
wholesaler_code, 
name,
email, 
contact_person,
region,
business_type,
description 
FROM wholesaler
ORDER BY wholesaler_id DESC
LIMIT 20;

/*
click one 
*/
SELECT 
wholesaler_code, 
name,
email, 
contact_person,
region,
contact_person_phone,
business_type,
description 
FROM wholesaler
WHERE wholesaler_id = v_wholesaler_id;

/*
modify
*/

UPDATE wholesaler
SET 
wholesaler_code = 'haha',
name = 'hahaha',
email = 'haha@haha.com',
contact_person = 'hehe',
region = 'Galaxy',
contact_person_phone = '123',
business_type = 'World Peace',
description = NULL
WHERE wholesaler_id = 1

/*
add
*/

INSERT INTO Wholesaler
(
    wholesaler_code,
    name,
    email,
    phone,
    contact_person,
    region,
    contact_person_phone,
    business_type,
    description
) VALUES 
(
    'keke',
    'KEKE',
    'keke@keke.com',
    12344566,
    'JUUUU',
    'Universe',
    '456',
    'Human Clearing',
    'World belongs to Three Body'
)

/*
delete
*/

DELETE FROM Wholesaler
WHERE wholesaler_id = v_wholesaler_id;