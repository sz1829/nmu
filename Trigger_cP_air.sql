CREATE TRIGGER cPAir BEFORE INSERT ON Transactions 
FOR EACH ROW
BEGIN 
IF NEW.type = 'airticket' THEN
    SET @airticket_tour_id = NEW.airticket_tour_id;
    SELECT base_price FROM AirticketTour WHERE airticket_tour_id = @airticket_tour_id INTO @base_price;
    SELECT base_currency FROM AirticketTour WHERE airticket_tour_id = @airticket_tour_id INTO @base_currency;
    SELECT sale_price FROM AirticketTour WHERE airticket_tour_id = @airticket_tour_id INTO @sale_price;
    SELECT sale_currency FROM AirticketTour WHERE airticket_tour_id = @airticket_tour_id INTO @sale_currency;
    SELECT received2 FROM AirticketTour WHERE airticket_tour_id = @airticket_tour_id INTO @received2;
    SELECT received2_currency FROM AirticketTour WHERE airticket_tour_id = @airticket_tour_id INTO @received2_currency;
    SELECT coupon FROM AirticketTour WHERE airticket_tour_id = @airticket_tour_id INTO @coupon;
    SELECT coupon_currency FROM AirticketTour WHERE airticket_tour_id = @airticket_tour_id INTO @coupon_currency;
    SELECT exchange_rate_usd_rmb FROM AirticketTour WHERE airticket_tour_id = @airticket_tour_id INTO @exchange_rate_usd_rmb;

    IF @base_currency = @sale_currency AND @base_currency = @received2_currency AND @base_currency = @coupon_currency THEN    
        SET 
            NEW.expense = IFNULL(@base_price, 0), 
            NEW.received = IFNULL(@sale_price, 0) + IFNULL(@received2, 0), 
            NEW.currency = @base_currency, 
            NEW.coupon = IFNULL(@coupon, 0),
            NEW.total_profit = NEW.received - NEW.expense - NEW.coupon;
    ELSE
        IF @base_currency = 'RMB' THEN 
            SET @base_price = @base_price / @exchange_rate_usd_rmb;
            SET @base_currency = 'USD';
        END IF;
        IF @sale_currency = 'RMB' THEN 
            SET @sale_price = @sale_price / @exchange_rate_usd_rmb;
            SET @sale_currency = 'USD';
        END IF;
        IF @received2_currency = 'RMB' THEN 
            SET @received2 = @received2 / @exchange_rate_usd_rmb;
            SET @received2_currency = 'USD';
        END IF;
        IF @coupon_currency = 'RMB' THEN
            SET @coupon = @coupon / @exchange_rate_usd_rmb;
            SET @coupon_currency = 'USD';
        END IF;
        SET 
            NEW.expense = IFNULL(@base_price, 0), 
            NEW.received = IFNULL(@sale_price, 0) + IFNULL(@received2, 0), 
            NEW.currency = @base_currency, 
            NEW.coupon = IFNULL(@coupon, 0),
            NEW.total_profit = NEW.received - NEW.expense - NEW.coupon;
    END IF;
END IF;
END
