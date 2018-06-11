CREATE TRIGGER integrateAirSchedule BEFORE INSERT ON AirSchedule 
FOR EACH ROW
BEGIN
SET @at_id = NEW.airticket_tour_id;
SELECT count(*) INTO @days FROM AirSchedule WHERE airticket_tour_id = @at_id;
IF @days = 0 THEN 
    INSERT INTO AirScheduleIntegrated(airticket_tour_id, all_schedule) VALUES 
        (
            @at_id, 
            concat(NEW.depart_airport, '/', DATE_FORMAT(NEW.depart_date, '%M/%d'), ' - ', NEW.arrival_airport, '/', DATE_FORMAT(NEW.arrival_date, '%M/%d'), ' | ')
        );
ELSE 
    SELECT all_schedule FROM AirScheduleIntegrated WHERE airticket_tour_id = @at_id INTO @all_schedule;
    SET @all_schedule = concat(@all_schedule, NEW.depart_airport, '/', DATE_FORMAT(NEW.depart_date, '%M/%d'), ' - ', NEW.arrival_airport, '/', DATE_FORMAT(NEW.arrival_date, '%M/%d'), ' | ');
    UPDATE AirScheduleIntegrated SET all_schedule = @all_schedule WHERE airticket_tour_id = @at_id;
END IF;
END;
