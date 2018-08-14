CREATE TRIGGER deleteWriteOff AFTER DELETE ON GroupTourGuideDetails
FOR EACH ROW
BEGIN
SELECT total_write_off_currency FROM GroupTour WHERE group_tour_id = OLD.group_tour_id INTO @total_write_off_currency;
SELECT exchange_rate_usd_rmb FROM GroupTour WHERE group_tour_id = OLD.group_tour_id INTO @exchange_rate_usd_rmb;
SELECT total_write_off FROM GroupTour WHERE group_tour_id = OLD.group_tour_id INTO @total_write_off;
SET @old_write_off = OLD.write_off;
IF OLD.write_off_currency = @total_write_off_currency THEN
    UPDATE GroupTour SET total_write_off = total_write_off - OLD.write_off WHERE group_tour_id = OLD.group_tour_id;
ELSE 
    IF OLD.write_off_currency = 'RMB' THEN 
        SET @old_write_off = OLD.write_off / @exchange_rate_usd_rmb;
    END IF;
    IF @total_write_off_currency = 'RMB' THEN 
        SET @total_write_off = @total_write_off / @exchange_rate_usd_rmb;
    END IF;
    UPDATE GroupTour SET total_write_off = @total_write_off - @old_write_off, total_write_off_currency = 'USD' WHERE group_tour_id = OLD.group_tour_id;
END IF;
END