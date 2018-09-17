CREATE TRIGGER deleteTourDetails AFTER DELETE ON TourDetails
FOR EACH ROW
BEGIN
SELECT exchange_rate FROM IndividualTour WHERE indiv_tour_id = OLD.indiv_tour_id INTO @exchange_rate;
IF OLD.payment_amount_currency = (SELECT sale_currency FROM IndividualTour WHERE indiv_tour_id = OLD.indiv_tour_id) THEN
    UPDATE IndividualTour SET sale_price = sale_price - OLD.received WHERE indiv_tour_id = OLD.indiv_tour_id;
ELSE
    UPDATE IndividualTour SET
    sale_price = sale_price - OLD.received / @exchange_rate
    WHERE indiv_tour_id = OLD.indiv_tour_id;
END IF;

IF OLD.coupon_currency = (SELECT coupon_currency FROM IndividualTour WHERE indiv_tour_id = OLD.indiv_tour_id) THEN
    UPDATE IndividualTour SET coupon = coupon - OLD.coupon WHERE indiv_tour_id = OLD.indiv_tour_id;
ELSE
    UPDATE IndividualTour SET
    coupon = coupon - OLD.coupon / @exchange_rate
    WHERE indiv_tour_id = OLD.indiv_tour_id;
END IF;
END
