SELECT group_tour_id FROM Transactions WHERE transaction_id = '1'

/*store the group_tour_id in 
v_group_tour_id*/

DELETE FROM Transactions WHERE transaction_id = '1'
DELETE FROM GroupTour WHERE group_tour_id  = v_group_tour_id
