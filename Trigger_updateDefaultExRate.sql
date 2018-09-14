/*已经整合进cp*/
CREATE TRIGGER updateDefaultExRate AFTER INSERT ON Transactions
FOR EACH ROW
BEGIN
IF NEW.type = 'group' THEN SELECT exchange_rate_usd_rmb FROM GroupTour WHERE group_tour_id = NEW.group_tour_id INTO @lastest_exrate; END IF;
IF NEW.type = 'individual' THEN SELECT exchange_rate FROM IndividualTour WHERE indiv_tour_id = NEW.indiv_tour_id INTO @lastest_exrate; END IF;
IF NEW.type = 'airticket' THEN SELECT exchange_rate_usd_rmb FROM AirticketTour WHERE airticket_tour_id = NEW.airticket_tour_id INTO @lastest_exrate; END IF;
SELECT value FROM OtherInfo WHERE name = 'default_currency' INTO @last_exrate;
IF abs((@lastest_exrate - @last_exrate) / @last_exrate) < 0.15 THEN
  UPDATE OtherInfo SET value  = @lastest_exrate WHERE name = 'default_currency';
END IF;
END
