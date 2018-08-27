CREATE TRIGGER deleteGroupTourReceived AFTER DELETE ON GroupTourReceived 
FOR EACH ROW
BEGIN
SELECT received_currency FROM GroupTour WHERE group_tour_id = OLD.group_tour_id INTO @received_currency;
SELECT exchange_rate_usd_rmb FROM GroupTour WHERE group_tour_id = OLD.group_tour_id INTO @exchange_rate_usd_rmb;
SELECT shin_received FROM GroupTour WHERE group_tour_id = OLD.group_tour_id INTO @received;
SET @old_received = OLD.shin_received;
IF OLD.received_currency = @received_currency THEN
    UPDATE GroupTour SET received = received - OLD.shin_received WHERE group_tour_id = OLD.group_tour_id;
ELSE 
    IF OLD.received_currency = 'RMB' THEN 
        SET @old_received = OLD.shin_received / @exchange_rate_usd_rmb;
    END IF;
    IF @received_currency = 'RMB' THEN 
        SET @received = @received / @exchange_rate_usd_rmb;
    END IF;
    UPDATE GroupTour SET received = @received - @old_received, received_currency = 'USD' WHERE group_tour_id = OLD.group_tour_id;
END IF;
END