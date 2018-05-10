/*
default display
*/

SELECT 
sum(total_profit)
FROM Transactions
WHERE type = 'group'
AND date_format(create_time, '%Y-%m-%d') = 
(
    SELECT date_format(max(create_time), '%Y-%m-%d') FROM Transactions
);