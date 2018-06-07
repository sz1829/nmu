SELECT *
FROM

(

SELECT * FROM 
(SELECT 
g.transaction_id,
g.create_time, 
g.salesperson_code, 
g.currency,
g.payment_type,
g.profit,
g.price,
g.cost,
t.expense,
t.received+t.received2 as revenue,
c.code, 
g.coupon, 
g.source_name, 
g.clear_status, 
g.lock_status,
g.note,
g.group_code,
g.total_number,
g.flight_number,
g.bus_company,
g.schedule,
g.guide_name,
g.guide_phone,
g.agency_name
FROM GroupTourOrder g
JOIN Transactions t
ON g.transaction_id = t.transaction_id
LEFT JOIN CouponCode c 
ON t.cc_id = c.cc_id
JOIN GroupTour gt 
ON t.group_tour_id = gt.group_tour_id
WHERE 
/*filter*/
g.transaction_id LIKE '%'
AND g.group_code LIKE '%'
AND g.clear_status LIKE 'N' 
AND g.lock_status LIKE 'N' 
/*这里有三种情况，对应网页的三种情况
第一种：默认，只勾选了未完成订单，
        AND g.clear_status = N
        AND g.lock_status = N
第二种：只勾了clear选项
        AND g.clear_status = Y
        AND g.lock_status = N
第三种：只勾了lock选项，这时clear选项会自动勾上。
        （如果这是操作人员把clear选项反选了，lock也会跟着反选。
        理由是lock的单子，一定是clear的。）
        AND g.lock_status = Y
第3.5种：勾了未完成订单和clear选项
        AND g.lock_status = N
第四种：勾了未完成订单和lock选项，这时clear选项会自动勾上。
        无筛选（因为全都勾上了）
第五种：clerk选项和lock选项，同第三种
        AND g.lock_status = Y
第六种：全勾了，同第四种
        无筛选
*/
AND g.create_time >= CURRENT_DATE - interval 1 month
AND g.create_time <= CURRENT_DATE
/*
interval 7 day 最近7天
interval 1 year 最近1年
*/
/*
如果选了ALL
AND g.create_time >= 0
AND g.craete_time <= CURRENT_DATE
*/
AND g.payment_type LIKE '%'
AND g.salesperson_code LIKE 'wmvtri'
/*管理员登陆时才会显示“销售”搜索框，普通销售就是只有自己可以选*/
AND g.source_name LIKE '%'
AND g.total_number BETWEEN 0 AND 999
AND g.flight_number LIKE '%'
AND g.bus_company LIKE '%'
AND g.agency_name LIKE '%'
AND gt.start_date LIKE '%%'
/*
一个%和两个%效果是一样的。如果有人输入日期，则'2018-04-07%'，如果没人输入，则'%%'。
不能直接使用'2018-04-07'，因为grouptour里的start_date是带时分秒的。
*/
AND gt.end_date LIKE '%%'
AND guide_name LIKE '%'
) first_filter 
WHERE 
first_filter.currency = 'USD'
AND first_filter.payment_type LIKE '%'
AND first_filter.profit BETWEEN -999999999.99 AND 999999999.99
/*
使用了单笔交易的默认最小值和最大值
*/
AND first_filter.expense BETWEEN -999999999.99 AND 999999999.99
AND first_filter.revenue BETWEEN -999999999.99 AND 999999999.99

UNION


SELECT * FROM 
(SELECT 
g.transaction_id,
g.create_time, 
g.salesperson_code, 
g.currency,
g.payment_type,
g.profit,
g.price,
g.cost,
t.expense,
t.received+t.received2 as revenue,
c.code, 
g.coupon, 
g.source_name, 
g.clear_status, 
g.lock_status,
g.note,
g.group_code,
g.total_number,
g.flight_number,
g.bus_company,
g.schedule,
g.guide_name,
g.guide_phone,
g.agency_name
FROM GroupTourOrder g
JOIN Transactions t
ON g.transaction_id = t.transaction_id
LEFT JOIN CouponCode c 
ON t.cc_id = c.cc_id
JOIN GroupTour gt 
ON t.group_tour_id = gt.group_tour_id
WHERE 
/*filter*/
g.transaction_id LIKE '%'
AND g.group_code LIKE '%'
AND g.clear_status LIKE 'N' 
AND g.lock_status LIKE 'N' 
/*这里有三种情况，对应网页的三种情况
第一种：默认，只勾选了未完成订单，
        AND g.clear_status = N
        AND g.lock_status = N
第二种：只勾了clear选项
        AND g.clear_status = Y
        AND g.lock_status = N
第三种：只勾了lock选项，这时clear选项会自动勾上。
        （如果这是操作人员把clear选项反选了，lock也会跟着反选。
        理由是lock的单子，一定是clear的。）
        AND g.lock_status = Y
第四种：勾了未完成订单和clear选项
        AND g.lock_status = N
第四种：勾了未完成订单和lock选项，这时clear选项会自动勾上。
        无筛选（因为全都勾上了）
第五种：clerk选项和lock选项，同第三种
        AND g.lock_status = Y
第六种：全勾了，同第四种
        无筛选
*/
AND g.create_time >= CURRENT_DATE - interval 1 month
AND g.create_time <= CURRENT_DATE
/*
interval 7 day 最近7天
interval 1 year 最近1年
*/
/*
如果选了ALL
AND g.create_time >= 0
AND g.craete_time <= CURRENT_DATE
*/
AND g.payment_type LIKE '%'
AND g.salesperson_code LIKE 'wmvtri'
/*管理员登陆时才会显示“销售”搜索框，普通销售就是只有自己可以选*/
AND g.source_name LIKE '%'
AND g.total_number BETWEEN 0 AND 999
AND g.flight_number LIKE '%'
AND g.bus_company LIKE '%'
AND g.agency_name LIKE '%'
AND gt.start_date LIKE '%%'
/*
一个%和两个%效果是一样的。如果有人输入日期，则'2018-04-07%'，如果没人输入，则'%%'。
不能直接使用'2018-04-07'，因为grouptour里的start_date是带时分秒的。
*/
AND gt.end_date LIKE '%%'
AND guide_name LIKE '%'
) first_filter 
WHERE 
first_filter.currency = 'RMB'
AND first_filter.payment_type LIKE '%'
AND first_filter.profit BETWEEN -999999999.99*6.39 AND 999999999.99*6.39
/*
使用了单笔交易的默认最小值和最大值
*/
AND first_filter.expense BETWEEN -999999999.99*6.39 AND 999999999.99*6.39
AND first_filter.revenue BETWEEN -999999999.99*6.39 AND 999999999.99*6.39



) second_filter

ORDER BY second_filter.transaction_id DESC;

