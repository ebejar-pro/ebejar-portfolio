CREATE OR REPLACE PROCEDURE add_customer(
    p_name VARCHAR(100),
    p_email VARCHAR(100),
    p_age INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO customers (name, email, age)
    VALUES (p_name, p_email, p_age);

    RAISE NOTICE 'New customer added for customer ID %', p_name;
END;
$$;

-- Example call to the procedure
-- call add_customer('Robert Rollis', 'robertr@example.com', 60)
