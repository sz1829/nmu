CREATE TRIGGER insertGroupTourReceived AFTER INSERT ON GroupTourReceived
FOR EACH ROW
BEGIN
SELECT 
    received, 
    received_currency,
    exchange_rate_usd_rmb
FROM GroupTour WHERE group_tour_id = NEW.group_tour_id INTO 
    @received, 
    @received_currency, 
    @exchange_rate_usd_rmb;
SET @new_received = NEW.received;
IF @received = 0 THEN 
    UPDATE GroupTour SET 
        received = NEW.received, 
        received_currency = NEW.received_currency
    WHERE group_tour_id = NEW.group_tour_id;
ELSE 
    IF @received_currency = NEW.received_currency THEN 
        UPDATE GroupTour SET 
            received = received + NEW.received
        WHERE group_tour_id = NEW.group_tour_id;
    ELSE 
        IF @received_currency = 'RMB' THEN
            SET @received = @received / @exchange_rate_usd_rmb;
        END IF;
        IF NEW.received_currency = 'RMB' THEN
            SET @new_received = NEW.received / @exchange_rate_usd_rmb;
        END IF;
        UPDATE GroupTour SET 
            received = @received + @new_received, 
            received_currency = 'USD'
        WHERE group_tour_id = NEW.group_tour_id;
    END IF;
END IF;
SELECT coupon, coupon_currency, cc_id FROM GroupTour WHERE group_tour_id = NEW.group_tour_id INTO @coupon, @coupon_currency, @cc_id;
IF @cc_id IS NULL AND @coupon = 0 THEN
    UPDATE GroupTour SET coupon_currency = NEW.received_currency WHERE group_tour_id = NEW.group_tour_id;
END IF;
END