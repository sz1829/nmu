CREATE TRIGGER cp_group BEFORE INSERT ON Transactions 
FOR EACH ROW
BEGIN 
IF NEW.type = 'group' THEN 
    SELECT received FROM GroupTour WHERE group_tour_id = NEW.group_tour_id INTO @received;
    SELECT total_cost FROM GroupTour WHERE group_tour_id = NEW.group_tour_id INTO @total_cost;
    SELECT coupon FROM GroupTour WHERE group_tour_id = NEW.group_tour_id INTO @coupon;
    SELECT received_currency FROM GroupTour WHERE group_tour_id = NEW.group_tour_id INTO @received_currency;
    SELECT total_cost_currency FROM GroupTour WHERE group_tour_id = NEW.group_tour_id INTO @total_cost_currency;
    SELECT coupon_currency FROM GroupTour WHERE group_tour_id = NEW.group_tour_id INTO @coupon_currency;
    SELECT exchange_rate_usd_rmb FROM GroupTour WHERE group_tour_id = NEW.group_tour_id INTO @exchange_rate_usd_rmb;
    IF 'USD' IN (@received_currency, @total_cost_currency, @coupon_currency) AND 'RMB' IN (@received_currency, @total_cost_currency, @coupon_currency) THEN
        IF @received_currency = 'RMB' THEN 
            SET @received = @received / @exchange_rate_usd_rmb;
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
    SET NEW.received = IFNULL(@received, 0);
    SET NEW.expense = IFNULL(@total_cost, 0);
    SET NEW.coupon = IFNULL(@coupon, 0);
    SET NEW.total_profit = NEW.received - NEW.expense - NEW.coupon;
    SET NEW.currency = @received_currency;
END IF;
END