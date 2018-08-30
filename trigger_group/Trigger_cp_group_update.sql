CREATE TRIGGER updateGroupTour BEFORE UPDATE ON GroupTour 
FOR EACH ROW
BEGIN
SELECT 
    received, 
    currency, 
    expense, 
    coupon 
FROM Transactions WHERE group_tour_id = NEW.group_tour_id INTO 
    @t_received, 
    @t_currency, 
    @expense, 
    @t_coupon;
SET @exchange_rate = OLD.exchange_rate_usd_rmb;
IF @t_received <> NEW.shin_received THEN
    IF @t_currency = NEW.received_currency THEN 
        UPDATE Transactions SET received = NEW.shin_received, total_profit = received - expense - coupon  WHERE group_tour_id = NEW.group_tour_id;
    ELSE 
        IF @t_currency = 'RMB' THEN 
            UPDATE Transactions SET currency = 'USD', received = NEW.shin_received, expense = expense / @exchange_rate, coupon = coupon / @exchange_rate, total_profit = received - expense - coupon WHERE group_tour_id = NEW.group_tour_id;
        END IF;
        IF NEW.received_currency = 'RMB' THEN 
            UPDATE Transactions SET received = NEW.shin_received / @exchange_rate, total_profit = received - expense - coupon  WHERE group_tour_id = NEW.group_tour_id;
        END IF;
    END IF;
ELSE 
    IF @t_currency <> NEW.received_currency THEN 
        IF @t_currency = 'RMB' THEN 
            UPDATE Transactions SET currency = 'USD', received = NEW.shin_received, expense = expense / @exchange_rate, coupon = coupon / @exchange_rate, total_profit = received - expense - coupon WHERE group_tour_id = NEW.group_tour_id;
        END IF;
        IF NEW.received_currency = 'RMB' THEN 
            UPDATE Transactions SET received = NEW.shin_received / @exchange_rate, total_profit = received - expense - coupon  WHERE group_tour_id = NEW.group_tour_id;
        END IF;
    END IF;
END IF;
IF @expense <> NEW.total_cost THEN
    IF @t_currency = NEW.total_cost_currency THEN 
        UPDATE Transactions SET expense = NEW.total_cost, total_profit = received - expense - coupon  WHERE group_tour_id = NEW.group_tour_id;
    ELSE 
        IF @t_currency = 'RMB' THEN 
            UPDATE Transactions SET currency = 'USD', expense = NEW.total_cost, received = received / @exchange_rate, coupon = coupon / @exchange_rate, total_profit = received - expense - coupon WHERE group_tour_id = NEW.group_tour_id;
        END IF;
        IF NEW.total_cost_currency = 'RMB' THEN 
            UPDATE Transactions SET expense = NEW.total_cost / @exchange_rate, total_profit = received - expense - coupon  WHERE group_tour_id = NEW.group_tour_id;
        END IF;
    END IF;
ELSE 
    IF @t_currency <> NEW.total_cost_currency THEN 
        IF @t_currency = 'RMB' THEN 
            UPDATE Transactions SET currency = 'USD', expense = NEW.total_cost, received = received / @exchange_rate, coupon = coupon / @exchange_rate, total_profit = received - expense - coupon WHERE group_tour_id = NEW.group_tour_id;
        END IF;
        IF NEW.total_cost_currency = 'RMB' THEN 
            UPDATE Transactions SET expense = NEW.total_cost / @exchange_rate, total_profit = received - expense - coupon  WHERE group_tour_id = NEW.group_tour_id;
        END IF;
    END IF;
END IF;
IF @t_coupon <> NEW.coupon THEN
    IF @t_currency = NEW.coupon_currency THEN 
        UPDATE Transactions SET coupon = NEW.coupon, total_profit = received - expense - coupon  WHERE group_tour_id = NEW.group_tour_id;
    ELSE 
        IF @t_currency = 'RMB' THEN 
            UPDATE Transactions SET currency = 'USD', coupon = NEW.coupon, expense = expense / @exchange_rate, received = received / @exchange_rate, total_profit = received - expense - coupon WHERE group_tour_id = NEW.group_tour_id;
        END IF;
        IF NEW.coupon_currency = 'RMB' THEN 
            UPDATE Transactions SET coupon = NEW.coupon / @exchange_rate, total_profit = received - expense - coupon  WHERE group_tour_id = NEW.group_tour_id;
        END IF;
    END IF;
ELSE 
    IF @t_currency <> NEW.coupon_currency THEN 
        IF @t_currency = 'RMB' THEN 
            UPDATE Transactions SET currency = 'USD', coupon = NEW.coupon, expense = expense / @exchange_rate, received = received / @exchange_rate, total_profit = received - expense - coupon WHERE group_tour_id = NEW.group_tour_id;
        END IF;
        IF NEW.coupon_currency = 'RMB' THEN 
            UPDATE Transactions SET coupon = NEW.coupon / @exchange_rate, total_profit = received - expense - coupon  WHERE group_tour_id = NEW.group_tour_id;
        END IF;
    END IF;
END IF;
END 