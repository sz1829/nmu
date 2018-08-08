CREATE TRIGGER cPAir_update AFTER UPDATE ON AirticketTour 
FOR EACH ROW
BEGIN
SET @airticket_tour_id = NEW.airticket_tour_id;

SET @old_base_price = OLD.base_price;
SET @old_sale_price = OLD.sale_price;
SET @old_received2 = OLD.received2;
SET @old_coupon = OLD.coupon;

SET @new_base_price = NEW.base_price;
SET @new_sale_price = NEW.sale_price;
SET @new_received2 = NEW.received2;
SET @new_coupon = NEW.coupon;

SET @old_base_currency = OLD.base_currency;
SET @old_sale_currency = OLD.sale_currency;
SET @old_received2_currency = OLD.received2_currency;
SET @old_coupon_currency = OLD.coupon_currency;

SET @new_base_currency = NEW.base_currency;
SET @new_sale_currency = NEW.sale_currency;
SET @new_received2_currency = NEW.received2_currency;
SET @new_coupon_currency = NEW.coupon_currency;

SET @old_cc_id = OLD.cc_id;
SET @new_cc_id = NEW.cc_id;

SELECT currency FROM Transactions WHERE airticket_tour_id = @airticket_tour_id INTO @t_airticket_tour_id