SELECT * FROM 
(SELECT 
t.transaction_id,
/*section 1*/
gto.group_code, 
gto.flight_number, gto.bus_company, gto.salesperson_code, 
gto.guide_name, gto.guide_phone, gto.agency_name, gto.source_name , g.leader_number, 
g.tourist_number, gto.note, 
/*section 2*/
g.start_date, g.end_date, g.duration, 
/*section 3*/
gto.currency, gto.price, g.reserve, g.write_off, g.total_cost, 
t.cc_id, gto.coupon
FROM GroupTourOrder gto
JOIN Transactions t ON gto.transaction_id = t.transaction_id
JOIN GroupTour g ON t.group_tour_id = g.group_tour_id) default_display
WHERE transaction_id = '1'