/*default display*/

SELECT SUBSTRING(COLUMN_TYPE,5)
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA='nmu' 
AND TABLE_NAME='Transactions'
AND COLUMN_NAME='currency';

/*add a new currency like EUR
*/

ALTER TABLE 
Transactions
MODIFY currency 
ENUM('USD', 'RMB', 'EUR');

/*delete a type of currency like EUR*/

ALTER TABLE
Transactions
MODIFY currency
ENUM('USD', 'RMB');
