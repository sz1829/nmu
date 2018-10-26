CREATE TRIGGER cp BEFORE INSERT ON Transactions
FOR EACH ROW
BEGIN
IF NEW.type = 'airticket' THEN
    SET @airticket_tour_id = NEW.airticket_tour_id;
    SELECT
        base_price,
        base_currency,
        sale_currency,
        received2,
        received2_currency,
        coupon,
        coupon_currency,
        exchange_rate_usd_rmb,
        received
    FROM AirticketTour
    WHERE airticket_tour_id = @airticket_tour_id
    INTO
        @base_price,
        @base_currency,
        @sale_currency,
        @received2,
        @received2_currency,
        @coupon,
        @coupon_currency,
        @exchange_rate_usd_rmb,
        @received;
    IF @base_currency = @sale_currency AND @base_currency = @received2_currency AND @base_currency = @coupon_currency
    THEN
        SET
            NEW.expense = IFNULL(@base_price, 0),
            NEW.received = IFNULL(@received, 0),
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
                @sale_price = @sale_price / @exchange_rate_usd_rmb,
                @received = @received / @exchange_rate_usd_rmb;
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
            NEW.received = IFNULL(@received, 0),
            NEW.currency = 'USD',
            NEW.coupon = IFNULL(@coupon, 0),
            NEW.total_profit = NEW.received - NEW.expense - NEW.coupon;
    END IF;
END IF;
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
IF NEW.type = 'group' THEN
    SELECT
        received,
        total_cost,
        coupon,
        received_currency,
        total_cost_currency,
        coupon_currency,
        exchange_rate_usd_rmb,
        commission_fee,
        shin_received
    FROM GroupTour WHERE group_tour_id = NEW.group_tour_id INTO
        @received,
        @total_cost,
        @coupon,
        @received_currency,
        @total_cost_currency,
        @coupon_currency,
        @exchange_rate_usd_rmb,
        @commission_fee,
        @shin_received;
    IF 'USD' IN (@received_currency, @total_cost_currency, @coupon_currency) AND 'RMB' IN (@received_currency, @total_cost_currency, @coupon_currency) THEN
        IF @received_currency = 'RMB' THEN
            SET
                @commission_fee = @commission_fee / @exchange_rate_usd_rmb,
                @received = @received / @exchange_rate_usd_rmb,
                @shin_received = @received - @commission_fee;
            SET @received_currency = 'USD';
        END IF;
        IF @total_cost_currency = 'RMB' THEN
            SET @total_cost = @total_cost / @exchange_rate_usd_rmb;
            SET @total_xost_currency = 'USD';
        END IF;
        IF @received_currency = 'RMB' THEN
            SET @coupon = @coupon / @exchange_rate_usd_rmb;
            SET @coupon_currency = 'USD';
        END IF;
    END IF;
    SET NEW.received = IFNULL(@shin_received, 0);
    SET NEW.expense = IFNULL(@total_cost, 0);
    SET NEW.coupon = IFNULL(@coupon, 0);
    SET NEW.total_profit = NEW.received - NEW.expense - NEW.coupon;
    SET NEW.currency = @received_currency;
    SELECT count(DISTINCT payment_type) FROM GroupTourReceived WHERE group_tour_id = NEW.group_tour_id INTO @payment_type_number;
    IF @payment_type_number = 1 THEN
        SELECT DISTINCT payment_type FROM GroupTourReceived WHERE group_tour_id = NEW.group_tour_id INTO @payment_type_one;
        SET NEW.payment_type = @payment_type_one;
    ELSE
        SET NEW.payment_type = 'multiple';
    END IF;
END IF;
IF NEW.type = 'group' THEN SELECT exchange_rate_usd_rmb FROM GroupTour WHERE group_tour_id = NEW.group_tour_id INTO @lastest_exrate; END IF;
IF NEW.type = 'individual' THEN SELECT exchange_rate FROM IndividualTour WHERE indiv_tour_id = NEW.indiv_tour_id INTO @lastest_exrate; END IF;
IF NEW.type = 'airticket' THEN SELECT exchange_rate_usd_rmb FROM AirticketTour WHERE airticket_tour_id = NEW.airticket_tour_id INTO @lastest_exrate; END IF;
SELECT value FROM OtherInfo WHERE name = 'default_currency' INTO @last_exrate;
IF abs((@lastest_exrate - @last_exrate) / @last_exrate) < 0.15 THEN
  UPDATE OtherInfo SET value  = @lastest_exrate WHERE name = 'default_currency';
END IF;
END
