CREATE OR REPLACE FUNCTION trigger_record_commission()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    CALL record_sale_commission(
        NEW.employee_id,
        NEW.product_id,
        NEW.sale_id,
        NEW.quantity,
        NEW.sale_date
    );
    RETURN NEW;
END;
$$;
