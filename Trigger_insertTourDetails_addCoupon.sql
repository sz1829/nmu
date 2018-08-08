CREATE TRIGGER addNewCoupon AFTER INSERT ON TourDetails 
FOR EACH ROW 
BEGIN
SELECT coupon FROM IndividualTour WHERE indiv_tour_id = NEW.indiv_tour_id INTO @indiv_tour_coupon;
SELECT coupon_currency FROM IndividualTour WHERE indiv_tour_id = NEW.indiv_tour_id INTO @indiv_tour_coupon_currency;
SELECT exchange_rate FROM IndividualTour WHERE indiv_tour_id = NEW.indiv_tour_id INTO @indiv_exchange_rate;
SET @tour_coupon = NEW.coupon;
IF @indiv_tour_coupon = 0 THEN 
    UPDATE IndividualTour SET coupon = NEW.coupon, coupon_currency = NEW.coupon_currency WHERE indiv_tour_id = NEW.indiv_tour_id;
ELSE 
    IF @indiv_tour_coupon_currency = NEW.coupon_currency THEN 
        UPDATE IndividualTour SET coupon = IFNULL(coupon, 0) + IFNULL(NEW.coupon, 0) WHERE indiv_tour_id = NEW.indiv_tour_id;
    ELSE 
        IF @indiv_tour_coupon_currency = 'RMB' THEN
            SET @indiv_tour_coupon = @indiv_tour_coupon / @indiv_exchange_rate;
            UPDATE IndividualTour SET coupon = IFNULL(@indiv_tour_coupon, 0) + IFNULL(NEW.coupon, 0), coupon_currency = 'USD' WHERE indiv_tour_id = NEW.indiv_tour_id;
        ELSE 
            SET @tour_coupon = @tour_coupon / @indiv_exchange_rate;
            UPDATE IndividualTour SET coupon = IFNULL(@indiv_tour_coupon, 0) + IFNULL(@tour_coupon, 0) WHERE indiv_tour_id = NEW.indiv_tour_id;        
        END IF;
    END IF;
END IF;
END