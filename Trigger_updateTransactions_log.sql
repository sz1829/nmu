CREATE TRIGGER updateLog BEFORE UPDATE ON Transactions
FOR EACH ROW
BEGIN
IF NEW.currency = OLD.currency THEN
    IF OLD.received <> NEW.received THEN 
        INSERT INTO UpdateLog(
            transaction_id, 
            name, 
            value_before,
            value_after, 
            value_difference, 
            currency_before, 
            currency_after,
            revised_time
        ) VALUES(
            NEW.transaction_id,
            'received',
            OLD.received,
            NEW.received,
            NEW.received - OLD.received,
            OLD.currency,
            NEW.currency, 
            current_timestamp
        );
    END IF;
    IF OLD.expense <> NEW.expense THEN 
        INSERT INTO UpdateLog(
            transaction_id, 
            name, 
            value_before,
            value_after, 
            value_difference, 
            currency_before, 
            currency_after,
            revised_time
        ) VALUES(
            NEW.transaction_id,
            'expense',
            OLD.expense,
            NEW.expense,
            NEW.expense - OLD.expense,
            OLD.currency,
            NEW.currency, 
            current_timestamp
        );
    END IF;
    IF OLD.coupon <> NEW.coupon THEN 
        INSERT INTO UpdateLog(
            transaction_id, 
            name, 
            value_before,
            value_after, 
            value_difference, 
            currency_before, 
            currency_after,
            revised_time
        ) VALUES(
            NEW.transaction_id,
            'coupon',
            OLD.coupon,
            NEW.coupon,
            NEW.coupon - OLD.coupon,
            OLD.currency,
            NEW.currency, 
            current_timestamp
        );
    END IF;
ELSE 
    IF OLD.received <> NEW.received THEN 
        INSERT INTO UpdateLog(
            transaction_id, 
            name, 
            value_before,
            value_after, 
            currency_before, 
            currency_after,
            revised_time
        ) VALUES(
            NEW.transaction_id,
            'received',
            OLD.received,
            NEW.received,
            OLD.currency,
            NEW.currency, 
            current_timestamp
        );
    END IF;
    IF OLD.expense <> NEW.expense THEN 
        INSERT INTO UpdateLog(
            transaction_id, 
            name, 
            value_before,
            value_after, 
            currency_before, 
            currency_after,
            revised_time
        ) VALUES(
            NEW.transaction_id,
            'expense',
            OLD.expense,
            NEW.expense,
            OLD.currency,
            NEW.currency, 
            current_timestamp
        );
    END IF;
    IF OLD.coupon <> NEW.coupon THEN 
        INSERT INTO UpdateLog(
            transaction_id, 
            name, 
            value_before,
            value_after, 
            currency_before, 
            currency_after,
            revised_time
        ) VALUES(
            NEW.transaction_id,
            'coupon',
            OLD.coupon,
            NEW.coupon,
            OLD.currency,
            NEW.currency, 
            current_timestamp
        );
    END IF;
END IF;
END
