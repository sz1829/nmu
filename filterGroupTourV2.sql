

transaction_id_from_page = 'input' or '%'
from_date = 'input' or '%'
to_date = 'input' or '%'
group_code_from_page = 'input' or '%'



SELECT * FROM GroupTourOrder WHERE transaction_id  in 
    (SELECT id_table.transaction_id FROM 
        (SELECT t.transaction_id, 
                g.group_code, 
                t.create_time 
        FROM Transactions t JOIN GroupTour g ON t.group_tour_id = g.group_tour_id) id_table 
    WHERE 
    transaction_id LIKE transaction_id_from_page
    AND create_time >= from_date
    AND create_time >= to_date 
    AND group_code LIKE group_code_from_page)


SELECT count(*) FROM GroupTourOrder WHERE transaction_id  in 
    (SELECT id_table.transaction_id FROM 
        (SELECT t.transaction_id, 
                g.group_code, 
                t.create_time 
        FROM Transactions t JOIN GroupTour g ON t.group_tour_id = g.group_tour_id) id_table 
    WHERE 
    transaction_id LIKE '%'
    AND create_time >= '2018-04-17'
    AND create_time >= '2018-04-17' 
    AND group_code LIKE '%')


