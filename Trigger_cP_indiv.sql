CREATE TRIGGER cPAir BEFORE INSERT ON Transactions 
FOR EACH ROW
BEGIN 
IF NEW.type = 'individual' THEN
    SELECT sale_price FROM IndividualTour WHERE indiv_tour_id = NEW.indiv_tour_id INTO @sale_price;
    SELECT base_price FROM IndividualTour WHERE indiv_tour_id = NEW.indiv_tour_id INTO @base_price;
    SELECT coupon FROM IndividualTour WHERE indiv_tour_id = NEW.indiv_tour_id INTO @coupon;
    SELECT sale_currency FROM IndividualTour WHERE indiv_tour_id = NEW.indiv_tour_id INTO @sale_currency;
    SELECT base_currency FROM IndividualTour WHERE indiv_tour_id = NEW.indiv_tour_id INTO @base_currency;
    SELECT coupon_currency FROM IndividualTour WHERE indiv_tour_id = NEW.indiv_tour_id INTO @coupon_currency;
    SELECT exchange_rate FROM IndividualTour WHERE indiv_tour_id = NEW.indiv_tour_id INTO @exchange_rate_usd_rmb;
    IF @base_currency = @sale_currency AND @sale_currency = @coupon_currency THEN
        SET NEW.currency = @sale_currency;
        SET NEW.expense = IFNULL(@base_price, 0);
        SET NEW.received = IFNULL(@sale_price, 0);
        SET NEW.coupon = IFNULL(@coupon, 0);
        SET NEW.total_profit = NEW.received - NEW.expense - NEW.coupon;
    ELSE 
        IF @base_currency = 'RMB' THEN 
            SET @base_price = @base_price / @exchange_rate_usd_rmb;
            SET @base_currency = 'USD';
        END IF;
        IF @sale_currency = 'RMB' THEN 
            SET @sale_price = @sale_price / @exchange_rate_usd_rmb;
            SET @sale_currency = 'USD';
        END IF;
        IF @coupon_currency = 'RMB' THEN
            SET @coupon = @coupon / @exchange_rate_usd_rmb;
            SET @coupon_currency = 'USD';
        END IF;
        SET
            NEW.expense = IFNULL(@base_price, 0), 
            NEW.received = IFNULL(@sale_price, 0),
            NEW.currency = @base_currency, 
            NEW.coupon = IFNULL(@coupon, 0),
            NEW.total_profit = NEW.received - NEW.expense - NEW.coupon;
    END IF;
END IF;
END

