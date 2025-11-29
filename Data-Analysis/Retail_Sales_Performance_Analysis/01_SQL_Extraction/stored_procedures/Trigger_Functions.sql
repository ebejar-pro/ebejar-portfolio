-- =============================================
-- TRIGGER: Automate Commission Recording
-- =============================================

-- 1. Create the Trigger Function
-- This function simply calls the procedure we wrote earlier
CREATE OR REPLACE FUNCTION trg_record_sale_commission()
RETURNS TRIGGER AS $$
BEGIN
    -- Call the stored procedure for the new sale
    -- We pass the new values inserted into the sales table
    CALL record_sale_commission(
        NEW.employee_id,
        NEW.product_id,
        NEW.sale_id,
        NEW.quantity
    );
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- 2. Attach the Trigger to the Sales Table
-- It runs AFTER a new sale is inserted
CREATE TRIGGER after_sale_insert_trigger
AFTER INSERT ON sales
FOR EACH ROW
EXECUTE FUNCTION trg_record_sale_commission();