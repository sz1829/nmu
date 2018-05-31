/*
default display
*/

CALL sum_profit('monthly', '%', CURRENT_DATE-interval 6 month, CURRENT_DATE);

/*
add one salesperson
*/

CALL sum_profit('monthly', 'zyeet', '2016-05-15', '2018-05-15');

/*
add two salesperson
*/

CALL sum_profit('monthly', 'zyeet', '2016-05-31', '2018-05-31');
CALL sum_profit('monthly', 'xylyazk', '2016-05-31', '2018-05-31');


