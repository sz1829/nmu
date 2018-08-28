CREATE TRIGGER updateTourDetails AFTER UPDATE ON TourDetails
FOR EACH ROW 
BEGIN
SELECT 
    sale_currency,
    exchange_rate,
    sale_price
FROM IndividualTour WHERE indiv_tour_id = NEW.indiv_tour_id INTO 
    @sale_currency,
    @exchange_rate,
    @sale_price;

SET 
    @new_received = NEW.received,
    @old_received = OLD.received;

IF @sale_currency = NEW.payment_amount_currency AND OLD.payment_amount_currency = @sale_currency THEN 
    UPDATE IndividualTour SET sale_price = sale_price - OLD.received + NEW.received WHERE indiv_tour_id = NEW.indiv_tour_id;
ELSE 
    IF @sale_currency = 'RMB' THEN 
        SET @sale_price = @sale_price / @exchange_rate;
    END IF;
    IF NEW.payment_amount_currency = 'RMB' THEN 
        SET @new_received = @new_received / @exchange_rate;
    END IF;
    IF OLD.payment_amount_currency = 'RMB' THEN 
        SET @old_received = @old_received / @exchange_rate;
    END IF;
    UPDATE IndividualTour SET sale_price = @sale_price - @old_received + @new_received, sale_currency = 'USD' WHERE indiv_tour_id = NEW.indiv_tour_id;
END IF;


SELECT 
    coupon_currency,
    coupon 
FROM IndividualTour WHERE indiv_tour_id = NEW.indiv_tour_id INTO 
    @coupon_currency,
    @coupon;
SET @new_coupon = NEW.coupon;
SET @old_coupon = OLD.coupon;

IF NEW.coupon <> 0 THEN
    IF NEW.coupon_currency = OLD.coupon_currency AND NEW.coupon_currency = @coupon_currency THEN
        UPDATE IndividualTour SET coupon = coupon - OLD.coupon + NEW.coupon WHERE indiv_tour_id = NEW.indiv_tour_id;
    ELSE 
        IF @coupon_currency = 'RMB' THEN 
            SET @coupon = @coupon / @exchange_rate;
        END IF;
        IF NEW.coupon_currency = 'RMB' THEN 
            SET @new_coupon = @new_coupon / @exchange_rate;
        END IF;
        IF OLD.coupon_currency = 'RMB' THEN 
            SET @old_coupon = @old_coupon / @exchange_rate;
        END IF;
        UPDATE IndividualTour SET coupon = @coupon - @old_coupon + @new_coupon, coupon_currency = 'USD' WHERE indiv_tour_id = NEW.indiv_tour_id;
    END IF;
ELSE 
    IF OLD.coupon <> 0 THEN 
        IF OLD.coupon_currency = @coupon_currency THEN 
            UPDATE IndividualTour SET coupon = coupon - OLD.coupon WHERE indiv_tour_id = NEW.indiv_tour_id;
        ELSE 
            IF @coupon_currency = 'RMB' THEN 
                SET @coupon = @coupon / @exchange_rate;
            END IF;
            IF OLD.coupon_currency = 'RMB' THEN 
                SET @old_coupon = @old_coupon / @exchange_rate;
            END IF;
            UPDATE IndividualTour SET coupon = @coupon - @old_coupon, coupon_currency = 'USD' WHERE indiv_tour_id = NEW.indiv_tour_id;
        END IF;
    END IF;
END IF;

SET @indiv_tour_id = NEW.indiv_tour_id;
SET @all_clear_status = 'N';
SET @all_lock_status = 'N';

SELECT count(DISTINCT clear_status) FROM TourDetails WHERE indiv_tour_id = @indiv_tour_id INTO @clear_status_number;
IF @clear_status_number = 1 THEN 
    SELECT DISTINCT clear_status FROM TourDetails WHERE indiv_tour_id = @indiv_tour_id INTO @all_clear_status;
END IF;
SELECT count(DISTINCT lock_status) FROM TourDetails WHERE indiv_tour_id = @indiv_tour_id INTO @lock_status_number;
IF @lock_status_number = 1 THEN 
    SELECT DISTINCT lock_status FROM TourDetails WHERE indiv_tour_id = @indiv_tour_id INTO @all_lock_status;
END IF;
IF @all_clear_status = 'Y' THEN
    UPDATE Transactions SET clear_status = 'Y' WHERE indiv_tour_id = @indiv_tour_id;
END IF;
IF @all_lock_status = 'Y' THEN
    UPDATE Transactions SET clear_status = 'Y', lock_status = 'Y' WHERE indiv_tour_id = @indiv_tour_id;
END IF;

SELECT count(DISTINCT payment_type) FROM TourDetails WHERE indiv_tour_id = NEW.indiv_tour_id INTO @payment_type_number;
IF @payment_type_number = 1 THEN
    SELECT DISTINCT payment_type FROM TourDetails WHERE indiv_tour_id = NEW.indiv_tour_id INTO @payment_type_one;
    UPDATE Transactions SET payment_type = @payment_type_one WHERE indiv_tour_id = NEW.indiv_tour_id;
ELSE
    UPDATE Transactions SET payment_type = 'multiple' WHERE indiv_tour_id = NEW.indiv_tour_id;
END IF;
END