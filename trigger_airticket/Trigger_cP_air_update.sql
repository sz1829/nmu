CREATE TRIGGER updateAirticketTour AFTER UPDATE ON AirticketTour
FOR EACH ROW
BEGIN
SET @airticket_tour_id = NEW.airticket_tour_id;
SET @new_base_price = IFNULL(NEW.base_price, 0);
SET @new_received = IFNULL(NEW.received, 0);
SET @new_coupon = IFNULL(NEW.coupon, 0);
SET @new_base_currency = IFNULL(NEW.base_currency, OLD.base_currency);
SET @new_sale_currency = IFNULL(NEW.sale_currency, OLD.sale_currency);
SET @new_coupon_currency = IFNULL(NEW.coupon_currency, OLD.coupon_currency);
SELECT currency FROM Transactions WHERE airticket_tour_id = @airticket_tour_id INTO @t_currency;
SET @t_currency = IFNULL(@t_currency, 'USD');
IF 'USD' NOT IN (@new_base_currency, @new_coupon_currency, @new_sale_currency, @new_received2_currency) THEN
    UPDATE Transactions SET currency = 'RMB' WHERE airticket_tour_id = @airticket_tour_id;
ELSE
    IF @new_base_currency = 'RMB' THEN
        SET @new_base_price = @new_base_price / NEW.exchange_rate_usd_rmb;
    END IF;
    IF @new_sale_currency = 'RMB' THEN
        SET @new_received = @new_received/ NEW.exchange_rate_usd_rmb;
    END IF;
    IF @new_coupon_currency = 'RMB' THEN
        SET @new_coupon = @new_coupon / NEW.exchange_rate_usd_rmb;
    END IF;
    UPDATE Transactions SET currency = 'USD' WHERE airticket_tour_id = @airticket_tour_id;
END IF;
UPDATE Transactions SET
    expense = @new_base_price,
    received = @new_received,
    coupon = @new_coupon,
    total_profit = received - expense - coupon
WHERE airticket_tour_id = @airticket_tour_id;
END
