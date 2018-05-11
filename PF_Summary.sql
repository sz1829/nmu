/*
default display
*/

-- default display means salesperson_code is '%' and time interval is 30 days--

/* loop 
range n from 0, -30, -60, ...
*/

/*one row*/
/*每30天*/
SELECT concat(DATE_ADD(CURRENT_DATE, interval n-30 day), '~', DATE_ADD(CURRENT_DATE, interval n day)) as 'monthly';
/*每日*/
SELECT DATE_ADD(CURRENT_DATE, interval n day) as 'daily';
/*每3个月*/
SELECT concat(date_format(DATE_ADD(CURRENT_DATE, interval 0-90 day), '%Y-%m'), '~', date_format(DATE_ADD(CURRENT_DATE, interval 0 day), '%Y-%m')) as 'mulmonthly';
/*每半年*/
SELECT concat(date_format(DATE_ADD(CURRENT_DATE, interval 0-90 day), '%Y-%m'), '~', date_format(DATE_ADD(CURRENT_DATE, interval 0 day), '%Y-%m')) as 'mulmonthly';

SELECT 
sum(profit)
FROM GroupTourOrder
WHERE create_time <= DATE_ADD(CURRENT_DATE, interval n day) /* n */
AND create_time > DATE_ADD(CURRENT_DATE, interval n-30 day) /* n */
/*filter*/
AND salesperson_code LIKE '%';

SELECT 
sum(total_profit)
FROM IndividualTourOrder
WHERE create_time <= DATE_ADD(CURRENT_DATE, interval n day) /* n */
AND create_time > DATE_ADD(CURRENT_DATE, interval n-30 day) /* n */
/*filter*/
AND salesperson_code LIKE '%';

SELECT 
sum(total_profit)
FROM AirticketTourOrder
WHERE create_time <= DATE_ADD(CURRENT_DATE, interval n day) /* n */
AND create_time > DATE_ADD(CURRENT_DATE, interval n-30 day) /* n */
/*filter*/
AND salesperson_code LIKE '%';


--------------------------------------------------------------------



