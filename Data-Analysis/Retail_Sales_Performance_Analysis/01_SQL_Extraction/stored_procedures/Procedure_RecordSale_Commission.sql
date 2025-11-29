CREATE OR REPLACE PROCEDURE record_sale_commission(
    p_employee_id INT,
    p_product_id INT,
    p_sale_id INT,
    p_quantity INT,
    p_sale_date DATE
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_commission NUMERIC;
    v_commission_rate NUMERIC := 0.05;  -- 5%
    v_price NUMERIC;
BEGIN
    -- Prevent duplicate entries
    IF EXISTS (SELECT 1 FROM sales_commission WHERE sale_id = p_sale_id) THEN
        RAISE NOTICE 'Commission already exists for Sale ID %', p_sale_id;
        RETURN;
    END IF;

    -- 1. Get product price
    SELECT price INTO v_price
    FROM products
    WHERE product_id = p_product_id;

    -- 2. Calculate commission
    v_commission := v_price * p_quantity * v_commission_rate;

    -- 3. Insert commission record
    INSERT INTO sales_commission (employee_id, sale_id, commission_amount)
    VALUES (p_employee_id, p_sale_id, v_commission);

    -- 4. Update employee commission
    UPDATE employees
    SET commission = COALESCE(commission, 0) + v_commission
    WHERE employee_id = p_employee_id;

    -- 5. Update product stock
    UPDATE products
    SET stock_level = stock_level - p_quantity
    WHERE product_id = p_product_id;

    -- 6. Update dispatch date in the sales table
    UPDATE sales
    SET dispatch_date = p_sale_date + INTERVAL '2 days'
    WHERE sale_id = p_sale_id;

    RAISE NOTICE 'Commission, stock update, and dispatch processed for Sale %', p_sale_id;
END;
$$;
