CREATE TRIGGER totalcoupon AFTER INSERT ON TourDetails
FOR EACH ROW
BEGIN
SELECT value FROM OtherInfo WHERE name = 'default_currency' INTO @default_currency;
IF NEW.currency = 'USD' THEN 
    SET @default_currency = 1;
END IF;
UPDATE Transactions SET coupon = coupon + NEW.coupon/@default_currency WHERE indiv_tour_id = NEW.indiv_tour_id;
END;
