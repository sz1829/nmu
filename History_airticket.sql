SELECT * FROM (
    SELECT * FROM (
        SELECT 
            ao.transaction_id,
            ao.create_time, 
            ao.salesperson_code,
            ao.currency,
            ao.total_profit,
            ao.received, --收入--
            ao.received2, --返现--
            ao.expense,
            c.code,
            ao.coupon,
            ao.source_name,
            ao.clear_status,
            ao.lock_status,
            ao.note,
            ao.locators,
            ao.name,
            ao.flight_code,
            ao.round_trip,
            ao.ticket_type,
            a.adult_number+a.child_number+a.infant_number AS passenger_number,
            
    )
)