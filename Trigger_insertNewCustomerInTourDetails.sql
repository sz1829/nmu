CREATE Trigger addNewCustomer BEFORE INSERT ON TourDetails
FOR EACH ROW
BEGIN 
SET @new_coupon = NEW.new_coupon;
SET @indiv_tour_id = NEW.indiv_tour_id;
SELECT coupon FROM Transactions WHERE indiv_tour_id = @indiv_tour_id INTO @transaction_coupon;
UPDATE Transactions SET coupon = @transaction_coupon  + @new_coupon, total_profit = received-expense-coupon WHERE indiv_tour_id = @indiv_tour_id;
END;