CREATE TRIGGER addTourDetails AFTER INSERT ON TourDetails 
FOR EACH ROW 
BEGIN
SELECT 
    sale_price, 
    sale_currency, 
    exchange_rate, 
    coupon, 
    coupon_currency 
FROM IndividualTour WHERE indiv_tour_id = NEW.indiv_tour_id INTO 
    @sale_price, 
    @sale_currency, 
    @exchange_rate, 
    @it_coupon, 
    @it_coupon_currency;

SET 
    @td_coupon = NEW.coupon, 
    @sale_price = IFNULL(@sale_price, 0),
    @it_coupon = IFNULL(@it_coupon, 0),
    @received = NEW.received;

IF @sale_price = 0 THEN 
    UPDATE IndividualTour SET sale_currency = NEW.payment_amount_currency, sale_price = NEW.received WHERE indiv_tour_id = NEW.indiv_tour_id;
ELSE 
    IF @sale_currency = NEW.payment_amount_currency THEN
        UPDATE IndividualTour SET sale_price = sale_price + NEW.received WHERE indiv_tour_id = NEW.indiv_tour_id;
    ELSE 
        IF @sale_currency = 'RMB' THEN 
            SET @sale_price = @sale_price / @exchange_rate;
        END IF;
        IF NEW.payment_amount_currency = 'RMB' THEN
            SET @received = @received / @exchange_rate;
        END IF;
        UPDATE IndividualTour SET sale_price = @sale_price + @received, sale_currency = 'USD' WHERE indiv_tour_id = NEW.indiv_tour_id;
    END IF;
END IF;

IF @it_coupon = 0 THEN 
    IF NEW.coupon <> 0 THEN 
        UPDATE IndividualTour SET coupon_currency = NEW.coupon_currency, coupon = NEW.coupon WHERE indiv_tour_id = NEW.indiv_tour_id;
    ELSE 
        UPDATE IndividualTour SET coupon_currency = NEW.payment_amount_currency, coupon = 0 WHERE indiv_tour_id = NEW.indiv_tour_id;
    END IF;
ELSE 
    IF @it_coupon_currency = NEW.coupon_currency THEN
        UPDATE IndividualTour SET coupon = coupon + NEW.coupon WHERE indiv_tour_id = NEW.indiv_tour_id;
    ELSE 
        IF @it_coupon_currency = 'RMB' THEN 
            SET @it_coupon = @it_coupon / @exchange_rate;
        END IF;
        IF NEW.coupon_currency = 'RMB' THEN
            SET @td_coupon = @td_coupon / @exchange_rate;
        END IF;
        UPDATE IndividualTour SET coupon = @it_coupon + @td_coupon, coupon_currency = 'USD' WHERE indiv_tour_id = NEW.indiv_tour_id;
    END IF;
END IF;
SELECT count(DISTINCT payment_type) FROM TourDetails WHERE indiv_tour_id = NEW.indiv_tour_id INTO @payment_type_number;
IF @payment_type_number = 1 THEN
    SELECT DISTINCT payment_type FROM TourDetails WHERE indiv_tour_id = NEW.indiv_tour_id INTO @payment_type_one;
    UPDATE Transactions SET payment_type = @payment_type_one WHERE indiv_tour_id = NEW.indiv_tour_id;
ELSE
    UPDATE Transactions SET payment_type = 'multiple' WHERE indiv_tour_id = NEW.indiv_tour_id;
END IF;
END