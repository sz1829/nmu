/*default display*/

SELECT SUBSTRING(COLUMN_TYPE,5)
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA='nmu' 
AND TABLE_NAME='Transactions'
AND COLUMN_NAME='currency';

/*add display*/

ALTER 

