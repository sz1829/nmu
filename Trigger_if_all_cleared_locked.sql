CREATE TRIGGER if_all_cleared_locked AFTER UPDATE ON TourDetails
FOR EACH ROW
BEGIN
SET @indiv_tour_id = NEW.indiv_tour_id;
SET @all_clear_status = 'N';
SET @all_lock_status = 'N';

SELECT count(DISTINCT clear_status) FROM TourDetails WHERE indiv_tour_id = @indiv_tour_id INTO @clear_status_number;
IF @clear_status_number = 1 THEN 
    SELECT DISTINCT clear_status FROM TourDetails WHERE indiv_tour_id = @indiv_tour_id INTO @all_clear_status;
END IF;
SELECT count(DISTINCT lock_status) FROM TourDetails WHERE indiv_tour_id = @indiv_tour_id INTO @lock_status_number;
IF @lock_status_number = 1 THEN 
    SELECT DISTINCT lock_status FROM TourDetails WHERE indiv_tour_id = @indiv_tour_id INTO @all_lock_status;
END IF;
IF @all_clear_status = 'Y' THEN
    UPDATE Transactions SET clear_status = 'Y' WHERE indiv_tour_id = @indiv_tour_id;
END IF;
IF @all_lock_status = 'Y' THEN
    UPDATE Transactions SET clear_status = 'Y', lock_status = 'Y' WHERE indiv_tour_id = @indiv_tour_id;
END IF;
END
