CREATE OR REPLACE FUNCTION generate_sales_data()
RETURNS VOID
LANGUAGE plpgsql
AS $$
DECLARE
    -- Define the number of new records to generate (100 requested - 15 existing ≈ 85)
    v_num_records INT := 100; 
    v_counter INT := 0;

    -- Define arrays of existing valid IDs based on your table screenshots[cite: 5]:
    v_customer_ids INT[] := ARRAY[1, 2, 3, 7, 8, 12, 13];
    v_employee_ids INT[] := ARRAY[2, 3, 4, 5, 6]; -- Focusing on 'SALES' staff
    v_product_ids INT[] := ARRAY[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13];
    v_supplier_ids INT[] := ARRAY[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
    v_sales_channels TEXT[] := ARRAY['Retail', 'Online'];

    -- Variables for random data generation
    v_rand_customer_id INT;
    v_rand_employee_id INT;
    v_rand_product_id INT;
    v_rand_supplier_id INT;
    v_rand_quantity INT;
    v_rand_sale_channel VARCHAR(20);
    v_rand_sale_date DATE;
    v_date_range_days INT;
    v_start_date DATE := '2025-01-01'::DATE;
    v_end_date DATE := '2025-11-30'::DATE; 
    
BEGIN
    -- Calculate the total number of days in the requested date range (Jan 1 to Nov 30)
    v_date_range_days := v_end_date - v_start_date;

    WHILE v_counter < v_num_records LOOP
        -- 1. Random Date (between 2025-01-01 and 2025-11-30)
        v_rand_sale_date := v_start_date + (floor(random() * v_date_range_days) * '1 day'::INTERVAL);

        -- 2. Random Foreign Keys (using existing IDs)
        v_rand_customer_id := v_customer_ids[1 + floor(random() * array_length(v_customer_ids, 1))];
        v_rand_employee_id := v_employee_ids[1 + floor(random() * array_length(v_employee_ids, 1))];
        v_rand_product_id := v_product_ids[1 + floor(random() * array_length(v_product_ids, 1))];
        v_rand_supplier_id := v_supplier_ids[1 + floor(random() * array_length(v_supplier_ids, 1))];
        
        -- 3. Random Quantity (1 to 5 units per sale)
        v_rand_quantity := floor(random() * 5) + 1;
        
        -- 4. Random Sales Channel
        v_rand_sale_channel := v_sales_channels[1 + floor(random() * array_length(v_sales_channels, 1))];

        -- Call the user's existing procedure with random data
        CALL add_sale(
            v_rand_customer_id,
            v_rand_product_id,
            v_rand_quantity,
            v_rand_sale_date,
            v_rand_employee_id,
            v_rand_supplier_id,
            v_rand_sale_channel
        );
        
        v_counter := v_counter + 1;
    END LOOP;
END;
$$;

SELECT generate_sales_data();
