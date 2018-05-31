CREATE PROCEDURE sum_profit
(IN
    frequency VARCHAR(10), 
    s_code VARCHAR(50), 
    from_date DATETIME, 
    to_date DATETIME
) 
    BEGIN 
        SELECT value FROM OtherInfo WHERE name = 'default_currency' INTO @default_currency;
        CREATE TEMPORARY TABLE forCalculate (
            c0 VARCHAR(45),
            c1 DECIMAL(11,2),
            c2 DECIMAL(11,2),
            c3 DECIMAL(11,2),
            c4 DECIMAL(11,2)
        );
IF frequency = 'monthly' THEN
IF from_date > DATE_FORMAT(to_date, '%Y-%m') THEN 

    CALL insertOneRow(from_date, '%Y-%m-%d', to_date, '%Y-%m-%d', s_code, @default_currency, 'forCalculate', 'N');
    SELECT * FROM forCalculate;
    DROP TABLE forCalculate;
ELSE
    CALL insertOneRow(concat(DATE_FORMAT(to_date, '%Y-%m'), '-00'), '%Y-%m', to_date, '%Y-%m-%d', s_code, @default_currency, 'forCalculate', 'N');
    SET @cursor_day = to_date - interval 1 month;
WHILE from_date < DATE_FORMAT(@cursor_day, '%Y-%m') DO
    CALL insertOneRow(concat(DATE_FORMAT(@cursor_day, '%Y-%m'), '-00'), 'hello', concat(DATE_FORMAT(@cursor_day + interval 1 month, '%Y-%m'), '-00'), 'world', s_code, @default_currency, 'forCalculate', 'Y');
    SET @cursor_day = @cursor_day - interval 1 month;
END WHILE;

    SET @last_month = DATE_FORMAT(@cursor_day + interval 1 month, '%Y-%m');
    CALL insertOneRow(from_date, '%Y-%m-%d', concat(@last_month, '-00'), '%Y-%m', s_code, @default_currency, 'forCalculate', 'N');
    SELECT * FROM forCalculate;
END IF;
ELSEIF  
END IF;
DROP TABLE forCalculate;
END;

