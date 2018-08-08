CREATE TRIGGER updateTourDetails AFTER UPDATE ON TourDetails
FOR EACH ROW 
BEGIN
SELECT exchange_rate FROM IndividualTour WHERE indiv_tour_id = NEW.indiv_tour_id INTO @indiv_exchange_rate;
SELECT sale_currency FROM IndividualTour WHERE indiv_tour_id = NEW.indiv_tour_id INTO @indiv_sale_currency;
SELECT 

SET @old_td_coupon = OLD.coupon;
SET @old_td_coupon_currency =  OLD.coupon_currency;
SET @new_td_coupon = NEW.coupon;
SET @new_td_coupon_currency =  NEW.coupon_currency;
SET @old_td_payme











-- IF @indiv_tour_coupon_currency = NEW.coupon_currency AND @indiv_tour_coupon_currency = OLD.coupon_currency THEN 
--     UPDATE IndividualTour SET coupon = IFNULL(coupon, 0) - IFNULL(OLD.coupon, 0) + IFNULL(NEW.coupon, 0) WHERE indiv_tour_id = NEW.indiv_tour_id;
-- ELSE 
--     IF @indiv_tour_coupon_currency = 'RMB' THEN
--         SET @indiv_tour_coupon = @indiv_tour_coupon / @indiv_exchange_rate;
--         UPDATE IndividualTour SET coupon = IFNULL(@indiv_tour_coupon, 0) + IFNULL(NEW.coupon, 0), coupon_currency = 'USD' WHERE indiv_tour_id = NEW.indiv_tour_id;
--     ELSE 
--         SET @tour_coupon = @tour_coupon / @indiv_exchange_rate;
--         UPDATE IndividualTour SET coupon = IFNULL(@indiv_tour_coupon, 0) + IFNULL(@tour_coupon, 0) WHERE indiv_tour_id = NEW.indiv_tour_id;        
--     END IF;
-- END IF;

END