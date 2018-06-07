CREATE TRIGGER totalcoupon AFTER INSERT ON TourDetails
FOR EACH ROW
BEGIN
UPDATE Transactions SET coupon = coupon + NEW.coupon WHERE indiv_tour_id = NEW.indiv_tour_id;
END;



