SELECT indiv_tour_id FROM Transactions WHERE transaction_id = 290;

-- as v_indiv_tour_id--

DELETE FROM TourDetails WHERE indiv_tour_id  = v_indiv_tour_id;
DELETE FROM Transactions WHERE transaction_id = 290;
DELETE FROM IndividualTour WHERE indiv_tour_id = v_indiv_tour_id;
