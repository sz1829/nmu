CREATE TRIGGER deleteCoupon BEFORE DELETE ON TourDetails
FOR EACH ROW
BEGIN 
SET @old_coupon = OLD.coupon;
SET @indiv_tour_id = OLD.indiv_tour_id;
SELECT coupon FROM Transactions WHERE indiv_tour_id = @indiv_tour_id INTO @transaction_coupon;
UPDATE Transactions SET coupon = @transaction_coupon  - @old_coupon, total_profit = received-expense-coupon WHERE indiv_tour_id = @indiv_tour_id;
END;