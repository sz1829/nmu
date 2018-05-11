/*
default display
*/

/* loop 
range n from 0, -1, -2...
*/

/*one row*/
/*每日*/
SELECT DATE_ADD(CURRENT_DATE, interval n day) as 'daily';

SELECT 
sum(profit)
FROM GroupTourOrder
WHERE create_time = DATE_ADD(CURRENT_DATE, interval -2 day) /* n */
/*filter*/
AND salesperson_code LIKE 'aeodhnzx';

SELECT 
sum(total_profit)
FROM IndividualTourOrder
WHERE create_time = DATE_ADD(CURRENT_DATE, interval -2 day) /* n */
/*filter*/
AND salesperson_code LIKE '%';

SELECT 
sum(total_profit)
FROM AirticketTourOrder
WHERE create_time = DATE_ADD(CURRENT_DATE, interval n day) /* n */
/*filter*/
AND salesperson_code LIKE '%';


--------------------------------------------------------------------



