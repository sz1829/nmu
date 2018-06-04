SELECT
t.currency, 
DATE_FORMAT(t.create_time, '%Y-%m-%d') AS create_time, 
s.salesperson_code, 
t.total_profit,
t.received+t.received2 AS revenue,
t.expense,
c.code, 
t.coupon, 
cs.source_name, 
t.clear_status, 
t.lock_status,
t.note
FROM Transactions t
JOIN CouponCode c 
ON t.cc_id = c.cc_id
JOIN CustomerSource cs 
ON t.source_id = cs.source_id
JOIN Salesperson s
ON t.salesperson_id = s.salesperson_id
WHERE 
/*filter*/
t.transaction_id LIKE '%'
AND t.clear_status LIKE 'N' 
AND t.lock_status LIKE 'N' 
/*这里有三种情况，对应网页的三种情况
第一种：默认，只勾选了未完成订单，
        AND clear_status = N
        AND lock_status = N
第二种：只勾了clear选项
        AND clear_status = Y
        AND lock_status = N
第三种：只勾了lock选项，这时clear选项会自动勾上。
        （如果这是操作人员把clear选项反选了，lock也会跟着反选。
        理由是lock的单子，一定是clear的。）
        AND lock_status = Y
第四种：勾了未完成订单和clear选项
        AND lock_status = N
第四种：勾了未完成订单和lock选项，这时clear选项会自动勾上。
        无筛选（因为全都勾上了）
第五种：clerk选项和lock选项，同第三种
        AND lock_status = Y
第六种：全勾了，同第四种
        无筛选
*/
AND t.create_time >= CURRENT_DATE - interval 1 month
AND t.create_time <= CURRENT_DATE
/*
interval 7 day 最近7天
interval 1 year 最近1年
*/
/*
如果选了ALL
AND create_time >= 0
AND craete_time <= CURRENT_DATE
*/
AND t.currency LIKE '%'
AND t.payment_type LIKE '%'
AND t.total_profit BETWEEN -999999999.99 AND 999999999.99
/*
使用了单笔交易的默认最小值和最大值
*/
AND t.expense BETWEEN -999999999.99 AND 999999999.99
AND t.received+t.received2 BETWEEN -999999999.99 AND 999999999.99
AND s.salesperson_code LIKE 'sdzgkyfdi'
/*管理员登陆时才会显示“销售”搜索框，普通销售就是只有自己可以选*/
AND cs.source_name LIKE '%';

