CREATE TRIGGER updateCoupon BEFORE UPDATE ON TourDetails
FOR EACH ROW
BEGIN
SET @indiv_collection_id = NEW.indiv_collection_id;
SET @indiv_tour_id = NEW.indiv_tour_id;
SET @new_coupon = NEW.coupon;
SELECT coupon FROM Transactions WHERE indiv_tour_id = @indiv_tour_id INTO @transaction_coupon;
SELECT coupon FROM TourDetails WHERE indiv_collection_id = @indiv_collection_id INTO @old_coupon;
UPDATE Transactions SET coupon = @transaction_coupon - @old_coupon + @new_coupon, total_profit = received-expense-coupon WHERE indiv_tour_id = @indiv_tour_id;
END;
