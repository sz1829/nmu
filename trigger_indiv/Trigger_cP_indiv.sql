CREATE TRIGGER cp_indiv BEFORE INSERT ON Transactions
FOR EACH ROW
BEGIN
IF NEW.type = 'individual' THEN
    SELECT
        received,
        base_price,
        coupon,
        sale_currency,
        base_currency,
        coupon_currency,
        exchange_rate
    FROM IndividualTour WHERE indiv_tour_id = NEW.indiv_tour_id INTO
        @received,
        @base_price,
        @coupon,
        @sale_currency,
        @base_currency,
        @coupon_currency,
        @exchange_rate_usd_rmb;
    IF @base_currency = @sale_currency AND @sale_currency = @coupon_currency THEN
        SET NEW.currency = @sale_currency;
        SET NEW.expense = IFNULL(@base_price, 0);
        SET NEW.received = IFNULL(@received, 0);
        SET NEW.coupon = IFNULL(@coupon, 0);
        SET NEW.total_profit = NEW.received - NEW.expense - NEW.coupon;
    ELSE
        IF @base_currency = 'RMB' THEN
            SET @base_price = @base_price / @exchange_rate_usd_rmb;
        END IF;
        IF @sale_currency = 'RMB' THEN
            SET
                @received = @received / @exchange_rate_usd_rmb;
        END IF;
        IF @coupon_currency = 'RMB' THEN
            SET @coupon = @coupon / @exchange_rate_usd_rmb;
        END IF;
        SET
            NEW.expense = IFNULL(@base_price, 0),
            NEW.received = IFNULL(@received, 0),
            NEW.currency = @base_currency,
            NEW.coupon = IFNULL(@coupon, 0),
            NEW.total_profit = NEW.received - NEW.expense - NEW.coupon;
    END IF;
END IF;
END
