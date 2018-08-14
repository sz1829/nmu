CREATE TRIGGER updateGroupTourReceived AFTER UPDATE ON GroupTourReceived
FOR EACH ROW
BEGIN
SET @new_received = NEW.received;
SET @old_received = OLD.received;
SELECT received FROM GroupTour WHERE group_tour_id = NEW.group_tour_id INTO @received;
SELECT received_currency FROM GroupTour WHERE group_tour_id = NEW.group_tour_id INTO @received_currency;
SELECT exchange_rate_usd_rmb FROM GroupTour WHERE group_tour_id = NEW.group_tour_id INTO @exchange_rate_usd_rmb;

IF OLD.received_currency = NEW.received_currency AND OLD.received_currency = @received_currency THEN
    UPDATE GroupTour SET received = received - OLD.received + NEW.received WHERE group_tour_id = NEW.group_tour_id;
ELSE
    IF @received_currency = 'RMB' THEN
        SET @received = @received / @exchange_rate_usd_rmb;
    END IF;
    IF NEW.received_currency = 'RMB' THEN
        SET @new_received = NEW.received / @exchange_rate_usd_rmb;
    END IF;
    IF OLD.received_currency = 'RMB' THEN
        SET @old_received = OLD.received / @exchange_rate_usd_rmb;
    END IF;
    UPDATE GroupTour SET received = @received - @old_received + @new_received, received_currency = 'USD' WHERE group_tour_id = NEW.group_tour_id;
END IF;
END