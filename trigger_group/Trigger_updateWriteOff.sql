CREATE TRIGGER updateWriteOff AFTER UPDATE ON GroupTourGuideDetails
FOR EACH ROW
BEGIN
SET @new_write_off = NEW.write_off;
SET @old_write_off = OLD.write_off;
SELECT total_write_off FROM GroupTour WHERE group_tour_id = NEW.group_tour_id INTO @total_write_off;
SELECT total_write_off_currency FROM GroupTour WHERE group_tour_id = NEW.group_tour_id INTO @total_write_off_currency;
SELECT exchange_rate_usd_rmb FROM GroupTour WHERE group_tour_id = NEW.group_tour_id INTO @exchange_rate_usd_rmb;

IF OLD.write_off_currency = NEW.write_off_currency AND OLD.write_off_currency = @total_write_off_currency THEN
    UPDATE GroupTour SET total_write_off = total_write_off - OLD.write_off + NEW.write_off WHERE group_tour_id = NEW.group_tour_id;
    -- INSERT INTO UpdateLog(transaction_id, name, value_before, value_after, value_difference, currency_before, currency_after, revised_)
ELSE
    IF @total_write_off_currency = 'RMB' THEN
        SET @total_write_off = @total_write_off / @exchange_rate_usd_rmb;
    END IF;
    IF NEW.write_off_currency = 'RMB' THEN
        SET @new_write_off = NEW.write_off / @exchange_rate_usd_rmb;
    END IF;
    IF OLD.write_off_currency = 'RMB' THEN
        SET @old_write_off = OLD.write_off / @exchange_rate_usd_rmb;
    END IF;
    UPDATE GroupTour SET total_write_off = @total_write_off - @old_write_off + @new_write_off, total_write_off_currency = 'USD' WHERE group_tour_id = NEW.group_tour_id;
END IF;
END