CREATE TRIGGER updateCouponAndProfit AFTER UPDATE ON TourDetails
FOR EACH ROW
BEGIN
SELECT value FROM OtherInfo WHERE name = 'default_currency' INTO @default_currency;
IF OLD.currency = 'USD' THEN
    SET @default_currency_old = 1;
ELSE SET @default_currency_old = @default_currency;
END IF;
IF NEW.currency = 'USD' THEN
    SET @default_currency_new = 1;
ELSE SET @default_currency_new = @default_currency;
END IF;
UPDATE Transactions SET coupon = coupon - OLD.coupon/@default_currency_old + NEW.coupon/@default_currency_new,
total_profit = total_profit + OLD.coupon/@default_currency_old - NEW.coupon/@default_currency_new;
END;