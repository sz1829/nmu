CREATE TRIGGER cPAir BEFORE INSERT ON Transactions 
FOR EACH ROW
BEGIN 
IF NEW.type = 'group' THEN
    
END IF;
END

