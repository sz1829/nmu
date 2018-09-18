CREATE TRIGGER insertGroupTourReceived AFTER INSERT ON GroupTourReceived
FOR EACH ROW
BEGIN
SELECT 
    received, 
    received_currency,
    exchange_rate_usd_rmb, 
    shin_received, 
    commission_fee
FROM GroupTour WHERE group_tour_id = NEW.group_tour_id INTO 
    @received, 
    @received_currency, 
    @exchange_rate_usd_rmb,
    @shin_received,
    @commission_fee;
SET @payment_amount = NEW.payment_amount;
SET @new_commission_fee = NEW.commission_fee;
SET @new_received = NEW.received;
IF @received = 0 THEN 
    UPDATE GroupTour SET 
        received = NEW.payment_amount, 
        received_currency = NEW.received_currency, 
        commission_fee = NEW.commission_fee,
        shin_received = NEW.received
    WHERE group_tour_id = NEW.group_tour_id;
ELSE 
    IF @received_currency = NEW.received_currency THEN 
        UPDATE GroupTour SET 
            received = received + NEW.payment_amount,
            commission_fee = commission_fee + NEW.commission_fee, 
            shin_received = shin_received + NEW.received
        WHERE group_tour_id = NEW.group_tour_id;
    ELSE 
        IF @received_currency = 'RMB' THEN
            SET @received = @received / @exchange_rate_usd_rmb;
            SET @shin_received = @shin_received / @exchange_rate_usd_rmb;
            SET @commission_fee = @commission_fee / @exchange_rate_usd_rmb;
        END IF;
        IF NEW.received_currency = 'RMB' THEN
            SET @payment_amount = NEW.payment_amount / @exchange_rate_usd_rmb;
            SET @new_commission_fee = NEW.commission_fee / @exchange_rate_usd_rmb;
            SET @new_received = NEW.received / @exchange_rate_usd_rmb;
        END IF;
        UPDATE GroupTour SET 
            received = @received + @payment_amount, 
            received_currency = 'USD', 
            commission_fee = @commission_fee + @new_commission_fee,
            shin_received = @shin_received + @new_received
        WHERE group_tour_id = NEW.group_tour_id;
    END IF;
END IF;
SELECT coupon, coupon_currency, cc_id FROM GroupTour WHERE group_tour_id = NEW.group_tour_id INTO @coupon, @coupon_currency, @cc_id;
IF @cc_id IS NULL AND @coupon = 0 THEN
    UPDATE GroupTour SET coupon_currency = NEW.received_currency WHERE group_tour_id = NEW.group_tour_id;
END IF;
END