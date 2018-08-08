CREATE TRIGGER cPAir BEFORE INSERT ON Transactions 
FOR EACH ROW
BEGIN 
IF NEW.type = 'individual' THEN
    SET @indiv_tour_id = NEW.indiv_tour_id;
    SELECT 
END IF;
END

