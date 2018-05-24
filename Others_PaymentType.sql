/*default display*/

SELECT SUBSTRING(COLUMN_TYPE,5)
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA='nmu' 
AND TABLE_NAME='Transactions'
AND COLUMN_NAME='payment_type';

/*add a new currency like 'kakaopay'
*/

ALTER TABLE 
Transactions
MODIFY payment_type 
ENUM('creditcard','mco','alipay','wechat','cash','check','other','kakaopay');

/*delete a type of currency like 'kakaopay*/

ALTER TABLE
Transactions
MODIFY payment_type
ENUM('creditcard','mco','alipay','wechat','cash','check','other');
