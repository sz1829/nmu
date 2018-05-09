SELECT airticket_tour_id FROM Transactions WHERE transaction_id = v_transaction_id;
/*as v_airticket_tour_id*/

DELETE FROM Transactions WHERE transaction_id = v_transaction_id;
DELETE FROM AirticketTour WHERE airticket_tour_id = v_airticket_tour_id;

