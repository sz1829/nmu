delimiter @@
CREATE FUNCTION currencyToIcon(currency VARCHAR(3)) RETURNS VARCHAR(1)
BEGIN 
DECLARE icon VARCHAR(1);
IF currency = 'USD' THEN SET icon = '$';
ELSE SET icon = '¥';
END IF;
RETURN icon;
END@@
delimiter ;