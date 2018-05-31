    
CREATE PROCEDURE insertOneRow(
IN 
    fromDate DATETIME,
    fromDate_format VARCHAR(45),
    endDate DATETIME,
    endDate_format VARCHAR(45),
    s_code VARCHAR(45),
    d_currency DECIMAL(11,2),
    table_name VARCHAR(45),
    middle_part ENUM('Y', 'N'),
    frequency ENUM('daily', 'monthly', 'seasonly', 'hyearly', 'yearly')
)
    BEGIN
    IF frequency = 'yearly' THEN
        IF middle_part = 'Y' THEN
            SELECT DATE_FORMAT(fromDate, '%Y') INTO @c0;
        ELSE
            SELECT concat(DATE_FORMAT(fromDate, fromDate_format), '-', DATE_FORMAT(endDate, endDate_format)) INTO @c0;
        END IF;    
    ELSEIF frequency = 'monthly' THEN
        IF middle_part = 'Y' THEN
            SELECT DATE_FORMAT(fromDate, '%Y-%m') INTO @c0;
        ELSE 
            SELECT concat(DATE_FORMAT(fromDate, fromDate_format), '-', DATE_FORMAT(endDate, endDate_format)) INTO @c0;
        END IF;
    ELSEIF frequency = 'daily' THEN
        SELECT DATE_FORMAT(fromDate, '%Y-%m-%d') INTO @c0;
    ELSEIF frequency = 'seasonly' OR frequency = 'hyearly' THEN
        IF middle_part = 'N' THEN
        SELECT concat(DATE_FORMAT(fromDate, fromDate_format), '-', DATE_FORMAT(endDate, endDate_format)) INTO @c0;
        ELSE
        SELECT concat(DATE_FORMAT(fromDate, fromDate_format), '-', DATE_FORMAT(concat(DATE_FORMAT(endDate, '%Y-%m'), '-01')-interval 1 month, '%Y-%m')) INTO @c0;
        END IF;
    ELSEIF frequency = 'yearly' THEN
        IF middle_part = 'N' THEN
            SELECT concat(DATE_FORMAT(fromDate, fromDate_format), '-', DATE_FORMAT(endDate, endDate_format)) INTO @c0;
        ELSE 
            SELECT DATE_FORMAT(fromDate, '%Y') INTO @c0;
        END IF;
    END IF;
    SELECT ROUND(IFNULL((SELECT sum(profit) FROM GroupTourOrder 
    WHERE create_time < endDate 
    AND create_time >= fromDate
    AND salesperson_code LIKE s_code
    AND currency = 'USD'), 0) + IFNULL((SELECT sum(profit) FROM GroupTourOrder 
    WHERE create_time < endDate 
    AND create_time >= fromDate
    AND salesperson_code LIKE s_code
    AND currency = 'RMB'), 0)/d_currency, 2) INTO @c1;
    SELECT ROUND(IFNULL((SELECT sum(total_profit) FROM IndividualTourOrder 
    WHERE create_time < endDate 
    AND create_time >= fromDate
    AND salesperson_code LIKE s_code
    AND currency = 'USD'), 0) + IFNULL((SELECT sum(total_profit) FROM IndividualTourOrder 
    WHERE create_time < endDate 
    AND create_time >= fromDate
    AND salesperson_code LIKE s_code
    AND currency = 'RMB'), 0)/d_currency, 2) INTO @c2;
    SELECT ROUND(IFNULL((SELECT sum(total_profit) FROM AirticketTourOrder 
    WHERE create_time < endDate 
    AND create_time >= fromDate
    AND salesperson_code LIKE s_code
    AND currency = 'USD'), 0) + IFNULL((SELECT sum(total_profit) FROM AirticketTourOrder 
    WHERE create_time < endDate 
    AND create_time >= fromDate
    AND salesperson_code LIKE s_code
    AND currency = 'RMB'), 0)/d_currency, 2) INTO @c3;

    SET @insertIntoTable = concat('INSERT INTO ', table_name, ' VALUES(@c0, @c1, @c2, @c3,  @c1+@c2+@c3);');
    PREPARE forExecute FROM @insertIntoTable;
    EXECUTE forExecute;
    DEALLOCATE PREPARE forExecute;
    END;
