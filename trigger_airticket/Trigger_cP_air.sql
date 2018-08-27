CREATE TRIGGER cPAir BEFORE INSERT ON Transactions 
FOR EACH ROW
BEGIN 
IF NEW.type = 'airticket' THEN
    SET @airticket_tour_id = NEW.airticket_tour_id;
    SELECT 
        base_price,
        base_currency,
        sale_price,
        received2,
        received2_currency,
        coupon,
        coupon_currency,
        exchange_rate_usd_rmb,
        commission_fee,
        received
    FROM AirticketTour WHERE airticket_tour_id = @airticket_tour_id INTO 
        @base_price,
        @base_currency,
        @sale_price,
        @sale_currency,
        @received2,
        @received2_currency,
        @coupon,
        @coupon_currency, 
        @exchange_rate_usd_rmb,
        @commission_fee,
        @received;

    IF @base_currency = @sale_currency AND @base_currency = @received2_currency AND @base_currency = @coupon_currency THEN    
        SET 
            NEW.expense = IFNULL(@base_price, 0), 
            NEW.received = IFNULL(@received, 0) + IFNULL(@received2, 0), 
            NEW.currency = @base_currency, 
            NEW.coupon = IFNULL(@coupon, 0),
            NEW.total_profit = NEW.received - NEW.expense - NEW.coupon;
    ELSE
        IF @base_currency = 'RMB' THEN 
            SET @base_price = @base_price / @exchange_rate_usd_rmb;
            SET @base_currency = 'USD';
        END IF;
        IF @sale_currency = 'RMB' THEN 
            SET 
                @commission_fee = @commission_fee / @exchange_rate_usd_rmb,
                @sale_price = @sale_price / @exchange_rate_usd_rmb
                @received = @sale_price - @commission_fee;
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
            NEW.received = IFNULL(@received, 0) + IFNULL(@received2, 0), 
            NEW.currency = @base_currency, 
            NEW.coupon = IFNULL(@coupon, 0),
            NEW.total_profit = NEW.received - NEW.expense - NEW.coupon;
    END IF;
END IF;
END

