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

SELECT c.code, c.discount, s.salesperson_code, c.code_expired
FROM CouponCode c 
JOIN Salesperson s
ON c.salesperson_id = s.salesperson_id
WHERE 
c.code LIKE '%'
AND 
c.discount LIKE '%'
ORDER BY cc_id DESC
LIMIT 20;