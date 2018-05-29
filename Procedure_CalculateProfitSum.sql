CREATE PROCEDURE sum_profit
(IN
    --view_table VARCHAR(10), 
    frequency VARCHAR(10), 
    s_code VARCHAR(50), 
    from_date DATETIME, 
    to_date DATETIME
) 
    BEGIN 
        --DECLARE usd_profit DECIMAL(11,2);
        --DECLARE rmb_profit DECIMAL(11,2);
        --DECLARE sum_profit DECIMAL(11,2);
        --DECLARE count_date DATETIME;
        SELECT value FROM OtherInfo WHERE name = 'default_currency' INTO @default_currency
        CREATE TEMPORARY TABLE forCalculate (
            c0 VARCHAR(45),
            c1 DECIMAL(11,2),
            c2 DECIMAL(11,2),
            c3 DECIMAL(11,2),
            c4 DECIMAL(11,2)
        );
        IF frequency = 'monthly' THEN
IF from_date > DATE_FORMAT(to_date, '%Y-%m') THEN 
--SET 
--INSERT INTO forCalculate VALUES (
    SELECT concat(from_date, '-', to_date) INTO @c0;
    SELECT ROUND(IFNULL((SELECT sum(profit) FROM GroupTourOrder 
    WHERE create_time <= to_date 
    AND create_time >= from_date
    AND salesperson_code LIKE s_code
    AND currency = 'USD'), 0) + IFNULL((SELECT sum(profit) FROM GroupTourOrder 
    WHERE create_time <= to_date 
    AND create_time >= from_date
    AND salesperson_code LIKE s_code
    AND currency = 'RMB'), 0)/@default_currency, 2) INTO @c1;
    SELECT ROUND(IFNULL((SELECT sum(total_profit) FROM IndivualTourOrder 
    WHERE create_time <= to_date 
    AND create_time >= from_date
    AND salesperson_code LIKE s_code
    AND currency = 'USD'), 0) + IFNULL((SELECT sum(total_profit) FROM IndivualTourOrder 
    WHERE create_time <= to_date 
    AND create_time >= from_date
    AND salesperson_code LIKE s_code
    AND currency = 'RMB'), 0)/@default_currency, 2) INTO @c2;
    SELECT ROUND(IFNULL((SELECT sum(total_profit) FROM AirticketTourOrder 
    WHERE create_time <= to_date 
    AND create_time >= from_date
    AND salesperson_code LIKE s_code
    AND currency = 'USD'), 0) + IFNULL((SELECT sum(total_profit) FROM AirticketTourOrder 
    WHERE create_time <= to_date 
    AND create_time >= from_date
    AND salesperson_code LIKE s_code
    AND currency = 'RMB'), 0)/@default_currency, 2) INTO @c3;

    INSERT INTO forCalculate VALUES(@c0, @c1, @c2, @c3, @c1+@c2,+@c3);
    SELECT * FROM forCalculate;
    DROP TABLE forCalculate;
    END IF;
    END IF;
    END;
    































            IF from_date > DATE_FORMAT(to_date, '%Y-%m') THEN

                SELECT DATE_FORMAT(to_date, '%Y-%m') INTO @cell0;
            
                SELECT sum(profit) FROM GroupTourOrder 
                WHERE create_time > cell1
                AND  create_time <= to_date
                AND salesperson_code LIKE s_code
                AND currency = 'USD' INTO @cell2_usd;

                SELECT sum(profit) FROM view_table 
                WHERE create_time > cell1
                AND  create_time <= to_date
                AND salesperson_code LIKE s_code
                AND currency = 'RMB' INTO @cell2_rmb
            
                SELECT @cell2_usd+@cell2_rmb/@default_currency INTO @groupSum



            
            
            
            
            SET count_date = DATE_FORMAT(CURRENT_DATE, '%Y-%m');

            
            IF count_date >= to_date THEN
            SET count_date = to_date; 
            WHILE count_date > from_date THEN 
 
            SET usd_profit = (
                SELECT sum(profit) FROM view_table 
                WHERE create_time >= DATE_ADD(CURRENT_DATE, interval -30 day) /* n */
                AND  create_time < DATE_ADD(CURRENT_DATE, interval 0 day)
                AND salesperson_code LIKE 'aeodhnzx'
                AND currency = 'USD');
            


