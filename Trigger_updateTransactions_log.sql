-- CREATE TRIGGER updateLog BEFORE UPDATE ON Transactions
-- FOR EACH ROW
-- BEGIN

-- IF NEW.type = 'group' THEN 
--     SELECT received FROM GroupTour WHERE group_tour_id = NEW.group_tour_id INTO @g_received;
--     SELECT received_currency FROM GroupTour WHERE group_tour_id = NEW.group_tour_id INTO @g_received_currency;
--     SELECT total_cost FROM GroupTour WHERE group_tour_id = NEW.group_tour_id INTO @g_total_cost;
--     SELECT total_cost_currency FROM GroupTour WHERE group_tour_id = NEW.group_tour_id INTO @g_total_cost_currency;
--     SELECT received FROM GroupTour WHERE group_tour_id = NEW.group_tour_id INTO @g_received;



-- IF OLD.received <> NEW.received THEN 
--     INSERT INTO UpdateLog(
--         transaction_id, 
--         name, 
--         value_before,
--         value_after, 
--         value_difference, 
--         currency_before, 
--         currency_after,
--         revised_by, 
--         revised_time
--     ) VALUES(
--         NEW.transaction_id,
--         'received',
--         OLD.received,
--         NEW.received,
--         NEW.received - OLD.
--     )