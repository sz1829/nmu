CREATE TRIGGER updateIndividualTour AFTER UPDATE ON IndividualTour
FOR EACH ROW
BEGIN
SET
    @indiv_tour_id = NEW.indiv_tour_id,
    @new_base_price = IFNULL(NEW.base_price, 0),
    @new_base_currency = IFNULL(NEW.base_currency, OLD.base_currency),
    @new_received = IFNULL(NEW.received, 0),
    @new_sale_currency = IFNULL(NEW.sale_currency, OLD.sale_currency),
    @new_coupon = IFNULL(NEW.coupon, 0),
    @new_coupon_currency = IFNULL(NEW.coupon_currency, OLD.coupon_currency);

SELECT currency FROM Transactions WHERE indiv_tour_id = @indiv_tour_id INTO @t_currency;
SET @t_currency = IFNULL(@t_currency, 'USD');
IF 'USD' NOT IN (@new_base_currency, @new_coupon_currency, @new_sale_currency) THEN
    UPDATE Transactions SET currency = 'RMB' WHERE indiv_tour_id = @indiv_tour_id;
ELSE
    IF @new_base_currency = 'RMB' THEN
        SET @new_base_price = @new_base_price / NEW.exchange_rate;
    END IF;
    IF @new_sale_currency = 'RMB' THEN
        SET @new_received = @new_received / NEW.exchange_rate;
    END IF;
    IF @new_coupon_currency = 'RMB' THEN
        SET @new_coupon = @new_coupon / NEW.exchange_rate;
    END IF;
    UPDATE Transactions SET currency = 'USD' WHERE indiv_tour_id = @indiv_tour_id;
END IF;
UPDATE Transactions SET
    expense = @new_base_price,
    received = @new_received,
    coupon = @new_coupon,
    total_profit = received - expense - coupon
WHERE indiv_tour_id = @indiv_tour_id;
END
