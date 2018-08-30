CREATE TRIGGER insertWriteOff AFTER INSERT ON GroupTourGuideDetails
FOR EACH ROW
BEGIN
SELECT 
    total_write_off,
    total_write_off_currency, 
    exchange_rate_usd_rmb 
FROM GroupTour WHERE group_tour_id = NEW.group_tour_id INTO 
    @total_write_off, 
    @total_write_off_currency, 
    @exchange_rate_usd_rmb;
SET @new_write_off = NEW.write_off;
IF @total_write_off = 0 THEN 
    UPDATE GroupTour SET total_write_off = NEW.write_off, total_write_off_currency = NEW.write_off_currency WHERE group_tour_id = NEW.group_tour_id;
ELSE 
    IF @total_write_off_currency = NEW.write_off_currency THEN 
        UPDATE GroupTour SET total_write_off = total_write_off + NEW.write_off WHERE group_tour_id = NEW.group_tour_id;
    ELSE 
        IF @total_write_off_currency = 'RMB' THEN
            SET @total_write_off = @total_write_off / @exchange_rate_usd_rmb;
        END IF;
        IF NEW.write_off_currency = 'RMB' THEN
            SET @new_write_off = NEW.write_off / @exchange_rate_usd_rmb;
        END IF;
        UPDATE GroupTour SET total_write_off = @total_write_off + @new_write_off, total_write_off_currency = 'USD' WHERE group_tour_id = NEW.group_tour_id;
    END IF;
END IF;
SELECT coupon, coupon_currency, cc_id FROM GroupTour WHERE group_tour_id = NEW.group_tour_id INTO @coupon, @coupon_currency, @cc_id;
IF @cc_id IS NULL AND @coupon = 0 THEN
    UPDATE GroupTour SET coupon_currency = NEW.write_off_currency WHERE group_tour_id = NEW.group_tour_id;
END IF;
END


