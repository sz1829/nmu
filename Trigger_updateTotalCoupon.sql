CREATE TRIGGER updateCouponAndProfit BEFORE UPDATE ON TourDetails
FOR EACH ROW
BEGIN
UPDATE Transactions SET coupon = coupon - OLD.coupon + NEW.coupon,
total_profit = total_profit + OLD.coupon - NEW.coupon;
END;