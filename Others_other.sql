/*default*/

SELECT c.code, c.discount, s.salesperson_code, c.description
FROM CouponCode c 
JOIN Salesperson s
ON c.salesperson_id = s.salesperson_id
WHERE 
c.code_expired = 'N' 
AND
c.code LIKE 'uT13oXvEGIG7SS3vMZFz'
AND 
c.discount LIKE '%'
ORDER BY cc_id DESC
LIMIT 20;

/* uncheck */

SELECT c.code, c.discount, s.salesperson_code, c.description, c.code_expired
FROM CouponCode c 
JOIN Salesperson s
ON c.salesperson_id = s.salesperson_id
WHERE 
c.code LIKE '%'
AND 
c.discount LIKE '%'
ORDER BY cc_id DESC
LIMIT 20;

/* disable */

UPDATE CouponCode SET
code_expired = 'Y'
WHERE code = 'uT13oXvEGIG7SS3vMZFz';

/* add */

INSERT INTO CouponCode
(
    code,
    discount, 
    salesperson_id,
    description
)
VALUES 
(
    'ALEX',
    '100',
    (SELECT salesperson_id FROM Salesperson WHERE salesperson_code = 'aeodhnzx'),
    NULL
);