CREATE TRIGGER updateGroupTour AFTER INSERT ON GourpTourReceived
FOR EACH ROW
BEGIN
SELECT received FROM GroupTour WHERE group_tour_id = NEW.group_tour_id INTO @received;
SELECT received_currency FROM GroupTour WHERE group_tour_id = NEW.group_tour_id INTO @received_currency;
SELECT exchange_rate_usd_rmb FROM GroupTour WHERE group_tour_id = NEW.group_tour_id INTO @exchange_rate_usd_rmb;
IF @received = 0 THEN 
    UPDATE GroupTour SET received = NEW.received, received_currency = NEW.received_currency WHERE group_tour_id = NEW.group_tour_id;
ELSE 
    IF @received_currency = NEW.received_currency THEN 
        UPDATE GroupTour SET received = received + NEW.received, received_currency = NEW.received_currency WHERE group_tour_id = NEW.group_tour_id;
    ELSE 
        IF @received_currency = 'RMB' THEN
            SET @received = @received / @exchange_rate_usd_rmb;
        END IF;
        IF @received_currency = 'RMB' THEN
            SET @received = @received / @exchange_rate_usd_rmb;
        END IF;