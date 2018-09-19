CREATE TRIGGER cp_group BEFORE INSERT ON Transactions
FOR EACH ROW
BEGIN
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
END
