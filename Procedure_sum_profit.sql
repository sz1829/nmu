CREATE PROCEDURE sum_profit
(IN
    frequency VARCHAR(10), 
    s_code VARCHAR(50), 
    from_date DATETIME, 
    to_date DATETIME
) 
BEGIN 
    SELECT value FROM OtherInfo WHERE name = 'default_currency' INTO @default_currency;
    DROP TABLE IF EXISTS forCalculate;
    CREATE TEMPORARY TABLE forCalculate (
        time_period VARCHAR(45),
        groupSum DECIMAL(11,2),
        indivSum DECIMAL(11,2),
        airSum DECIMAL(11,2),
        totalSum DECIMAL(11,2)
    );
    IF frequency = 'monthly' THEN
        IF from_date > DATE_FORMAT(to_date, '%Y-%m') THEN 
            CALL insertOneRow(from_date, '%Y-%m-%d', to_date, '%Y-%m-%d', s_code, @default_currency, 'forCalculate', 'N', 'monthly');
            SELECT * FROM forCalculate;
        ELSE
            CALL insertOneRow(concat(DATE_FORMAT(to_date, '%Y-%m'), '-01'), '%Y-%m', to_date, '%Y-%m-%d', s_code, @default_currency, 'forCalculate', 'N', 'monthly');
            SET @cursor_day = to_date - interval 1 month;
            WHILE from_date < DATE_FORMAT(@cursor_day, '%Y-%m') DO
                CALL insertOneRow(concat(DATE_FORMAT(@cursor_day, '%Y-%m'), '-01'), 'hello', concat(DATE_FORMAT(@cursor_day + interval 1 month, '%Y-%m'), '-01'), 'world', s_code, @default_currency, 'forCalculate', 'Y', 'monthly');
                SET @cursor_day = @cursor_day - interval 1 month;
            END WHILE;
            SET @last_month = DATE_FORMAT(@cursor_day + interval 1 month, '%Y-%m');
            CALL insertOneRow(from_date, '%Y-%m-%d', concat(@last_month, '-01'), '%Y-%m', s_code, @default_currency, 'forCalculate', 'N', 'monthly');
            SELECT * FROM forCalculate;
        END IF;
    ELSEIF frequency = 'daily' THEN 
        SET @cursor_day = to_date;
        WHILE @cursor_day > from_date DO
            CALL insertOneRow(@cursor_day, '%Y-%m-%d', @cursor_day + interval 1 day, '%Y-%m-%d', s_code, @default_currency, 'forCalculate', 'N', 'daily');
            SET @cursor_day = @cursor_day - interval 1 day;
        END WHILE;
        SELECT * FROM forCalculate;
    ELSEIF frequency = 'seasonly' THEN
        IF from_date > DATE_FORMAT(to_date - interval 3 month, '%Y-%m') THEN
            CALL insertOneRow(from_date, '%Y-%m-%d', to_date, '%Y-%m-%d', s_code, @default_currency, 'forCalculate', 'N', 'seasonly');
        ELSE
            CALL insertOneRow(concat(DATE_FORMAT(to_date - interval 2 month, '%Y-%m'), '-01'), '%Y-%m', to_date, '%Y-%m-%d', s_code, @default_currency, 'forCalculate', 'N', 'seasonly');
            SET @cursor_day = to_date - interval 2 month;
            WHILE from_date < DATE_FORMAT(@cursor_day - interval 3 month, '%Y-%m') DO
                CALL insertOneRow(concat(DATE_FORMAT(@cursor_day - interval 3 month, '%Y-%m'), '-01'), '%Y-%m', concat(DATE_FORMAT(@cursor_day, '%Y-%m'), '-01'), '%Y-%m', s_code, @default_currency, 'forCalculate', 'Y', 'seasonly');
                SET @cursor_day = @cursor_day - interval 3 month;
            END WHILE;
            CALL insertOneRow(from_date, '%Y-%m-%d', concat(DATE_FORMAT(@cursor_day, '%Y-%m'), '-01'), '%Y-%m', s_code, @default_currency, 'forCalculate', 'Y', 'seasonly');
        END IF;
        SELECT * FROM forCalculate;
    ELSEIF frequency = 'hyearly' THEN
        IF from_date > DATE_FORMAT(to_date-interval 6 month, '%Y-%m') THEN
            CALL insertOneRow(from_date, '%Y-%m-%d', to_date, '%Y-%m-%d', s_code, @default_currency, 'forCalculate', 'N', 'hyearly');
        ELSE
            CALL insertOneRow(concat(DATE_FORMAT(to_date - interval 5 month, '%Y-%m'), '-01'), '%Y-%m', to_date, '%Y-%m-%d', s_code, @default_currency, 'forCalculate', 'N', 'hyearly');
            SET @cursor_day = to_date - interval 5 month;
            WHILE from_date < DATE_FORMAT(@cursor_day - interval 6 month, '%Y-%m') DO
                CALL insertOneRow(concat(DATE_FORMAT(@cursor_day - interval 6 month, '%Y-%m'), '-01'), '%Y-%m', concat(DATE_FORMAT(@cursor_day, '%Y-%m'), '-01'), '%Y-%m', s_code, @default_currency, 'forCalculate', 'Y', 'hyearly');
                SET @cursor_day = @cursor_day - interval 6 month;
            END WHILE;
            CALL insertOneRow(from_date, '%Y-%m-%d', concat(DATE_FORMAT(@cursor_day, '%Y-%m'), '-01'), '%Y-%m', s_code, @default_currency, 'forCalculate', 'Y', 'hyearly');
        END IF;
        SELECT * FROM forCalculate;
    ELSEIF frequency = 'yearly' THEN
        IF from_date >= DATE_FORMAT(to_date-interval 12 month, '%Y-%m') THEN
            CALL insertOneRow(from_date, '%Y-%m-%d', to_date, '%Y-%m-%d', s_code, @default_currency, 'forCalculate', 'N', 'yearly');
        ELSE 
            CALL insertOneRow(concat(DATE_FORMAT(to_date, '%Y'), '-01-01'), '%Y', to_date, '%Y-%m-%d', s_code, @default_currency, 'forCalculate', 'N', 'yearly');
            SET @cursor_day = to_date - interval 12 month;
            WHILE from_date < DATE_FORMAT(@cursor_day, '%Y') DO
                CALL insertOneRow(concat(DATE_FORMAT(@cursor_day, '%Y'), '-01-01'), 'hello', concat(DATE_FORMAT(@cursor_day+interval 12 month, '%Y'), '-01-01'), 'world', s_code, @default_currency, 'forCalculate', 'Y', 'yearly');
                SET @cursor_day = @cursor_day - interval 12 month;
            END WHILE;
            CALL insertOneRow(from_date, '%Y-%m-%d', concat(DATE_FORMAT(@cursor_day+interval 12 month, '%Y'), '-01-01'), '%Y', s_code, @default_currency, 'forCalculate', 'N', 'yearly');
        END IF;
        SELECT * FROM forCalculate;
    END IF;
    DROP TABLE forCalculate;
END;
