CREATE VIEW AitTicketOrder AS
SELECT 
t.transaction_id, 
date_format(t.create_time, '%Y-%m-%d') as 'create_time', 
date_format(t.settle_time, '%Y-%m-%d') as 'settle_time', 
s.salesperson_code, 
a.flight_code, 
a.locators, 
