CREATE OR REPLACE PROCEDURE add_sale(
    p_customer_id INT,
    p_product_id INT,
    p_quantity INT,
    p_sale_date DATE,
    p_employee_id INT,
    p_supplier_id INT,
    p_sales_channel VAR(20)
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO sales (customer_id, product_id, quantity, sale_date, employee_id, supplier_id, sales_channel)
    VALUES (p_customer_id, p_product_id, p_quantity, p_sale_date, p_employee_id, p_supplier_id, p_sales_channel);

    RAISE NOTICE 'New sale added for customer ID %', p_customer_id;
END;
$$;

-- Example calls to the procedure
-- call add_sale(7, 12, 2, '2025-11-06',3 , 11, 'Online')
-- call add_sale(8, 15, 1, '2025-11-07',4 , 12, 'In-Store')





