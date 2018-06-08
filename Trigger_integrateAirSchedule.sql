CREATE TRIGGER integrateAirSchedule BEFORE INSERT ON AirSchedule 
FOR EACH ROW
BEGIN
SET NEW.airticket_tour_id = @at_id;
SELECT count(*) INTO @days FROM AirSchedule WHERE airticket_tour_id = @at_id;
IF @days = 0 THEN 
    INSERT INTO AirScheduleIntegrated(airticket_tour_id, all_schedule) VALUES 
        (
            @at_id, 
            concat(NEW.depart_airport, '/', DATE_FORMAT(NEW.depart_date, '%M/%d'), ' - ', NEW.arrival_airport, '/', DATE_FORMAT(NEW.arrival_date, '%M/%d'), ' | ')
        );
ELSE 
    SELECT all_scheudle FROM AirScheduleIntegrated WHERE airticket_tour_id = @at_id INTO @all_scheudle;
    SET @all_scheudle = concat(@all_scheudle, NEW.depart_airport, '/', DATE_FORMAT(NEW.depart_date, '%M/%d'), ' - ', NEW.arrival_airport, '/', DATE_FORMAT(NEW.arrival_date, '%M/%d'), ' | ');
    UPDATE AirScheduleIntegrated SET all_schedule = @all_schedule WHERE airticket_tour_id = @at_id;
END IF;
END;
