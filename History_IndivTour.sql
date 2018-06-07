SELECT 
    it.transaction_id, 
    it.create_time,
    it.salesperson_code,
    it.total_profit,
    it.revenue,
    it.cost,
    it.coupon,
    it.source_name,
    it.clear_status,
    it.lock_status,
    it.note,
    it.product_code,
    it.indiv_number,
    it.schedule, 
    it.wholesaler_code
    FROM IndividualTourOrder it 
    JOIN Transactions t 
    ON it.transaction_id = t.transaction_id
    JOIN IndividualTour i 
    ON t.indiv_tour_id = i.indiv_tour_id
    WHERE it.transaction_id LIKE '%'
    /*一样的逻辑
    AND it.clear_status LIKE 'N' 
    AND it.lock_status LIKE 'N' 
    */
    AND t.create_time >= CURRENT_DATE - interval 1 month
    AND t.create_time <= CURRENT_DATE
    AND it.salesperson_code LIKE '%'
    AND it.source_name LIKE '%'
    AND it.indiv_number >= 0
    AND it.indiv_number <= 9999
    AND i.depart_date >= 0
    AND i.arrival_date <= CURRENT_TIMESTAMP
    AND it.tour_name LIKE '%%%'
    /*若输入信息，替换中间的% */
    AND it.wholesaler_code LIKE '%'
    /* money */
    AND it.total_profit BETWEEN -999999999.99 AND 999999999.99
    AND it.cost BETWEEN -999999999.99 AND 999999999.99
    AND it.revenue BETWEEN -999999999.99 AND 999999999.99;

