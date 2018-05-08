--get airticket_tour_id--
SELECT airticket_tour_id FROM Transactions WHERE transaction_id = 490;
--as v_airticket_tour_id--

----------------------------
-- STEP 1 GET CUSTOMER_ID --
----------------------------

      --check if the customer exits--
      SELECT customer_id FROM Customer WHERE fname = 'Vvesvo' AND lname = 'Oypqgczv' AND birth_date = '2010-07-29' LIMIT 1;
      --if returns a value
        --store it as v_customer_id
      --if returns null
        /*
        INSERT INTO Customer
        (
            fname, 
            lname, 
            email, 
            phone, 
            other_contact_type,
            other_contact_number, 
            birth_date, 
            gender, 
            zipcode
        ) VALUES
        (
            'he',
            'hangwei',
            NULL, 
            NULL, 
            NULL, 
            NULL, 
            NULL, 
            NULL, 
            NULL 
        )
        */
      --get the new customer_id--
            SELECT customer_id FROM Customer WHERE fname = 'Vvesvo' AND lname = 'Oypqgczv' AND birth_date = '2010-07-29' LIMIT 1;




UPDATE AirTicketTour 
SET 
flight_code = 'haha',
salesperson_id = 
  (SELECT salesperson_id FROM Salesperson WHERE salesperson_code = 'ackui'),
locators = 'HRHR',
round_trip = 'oneway',
ticket_type = 'group',
adult_number = 5,
child_number = 1,
infant = 0,





customer_id = v_customer_id,
