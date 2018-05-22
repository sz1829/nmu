/*
default display
*/

/* loop 
range n from 0, -1, -2...
*/

/*one row*/
/*每日*/
SELECT DATE_ADD(CURRENT_DATE, interval -n day) as 'daily';

/*SELECT date_format(DATE_ADD(CURRENT_DATE, interval -n day), '%Y-%m') as 'monthly';*/

SELECT 
sum(profit)
FROM GroupTourOrder
WHERE create_time >= DATE_ADD(CURRENT_DATE, interval -60 day) /* n */
AND  create_time < DATE_ADD(CURRENT_DATE, interval -30 day)
/*filter*/
AND salesperson_code LIKE 'aeodhnzx';

SELECT 
sum(total_profit)
FROM IndividualTourOrder
WHERE create_time = DATE_ADD(CURRENT_DATE, interval n day) /* n */
/*filter*/
AND salesperson_code LIKE '%';

SELECT 
sum(total_profit)
FROM AirticketTourOrder
WHERE create_time = DATE_ADD(CURRENT_DATE, interval n day) /* n */
/*filter*/
AND salesperson_code LIKE '%';


--------------------------------------------------------------------



