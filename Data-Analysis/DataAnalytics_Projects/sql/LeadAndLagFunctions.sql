--- Present the current anmd the next sale amount Window LEAD function
SELECT
    sale_date,
    country,
    sale_amount,
    LEAD(sale_amount, 1) OVER (PARTITION BY country ORDER BY sale_date)
    AS next_sales_amount
FROM inter_sales;

-- How much the cumulative sales changed between 15-02-2024 and 12-02-2024
--Calculating cumulative sales by country
WITH cumulative_sales AS (SELECT
    sale_date,
    country,
    sale_amount,
    SUM(sale_amount) OVER (PARTITION BY country ORDER BY sale_date ASC)
    AS cumulative_sales_amt
FROM inter_sales)

SELECT
    sale_date,
    country,
    cumulative_sales_amt,
    -- Using the LEAD function to find difference in cumulative sales
    LEAD(cumulative_sales_amt, 1)
    OVER (PARTITION BY country ORDER BY sale_date ASC) - cumulative_sales_amt
    AS change_in_sales
FROM cumulative_sales
WHERE  country = 'South Africa'
AND sale_date in ('2024-02-15', '2024-02-12');

SELECT 
    sale_date,
    country,
    sale_amount,
    LAG(sale_amount, 1) OVER (PARTITION BY country ORDER BY sale_date)
    AS previous_sales_amount
FROM inter_sales;

-- LAG Function instead of looking ahead retrieves the cumulative sales from the previous row
WITH cumulative_sales AS (SELECT
    sale_date,
    country,
    sale_amount,
    SUM(sale_amount) OVER (PARTITION BY country ORDER BY sale_date ASC)
    AS cumulative_sales_amt
FROM inter_sales)

SELECT
    sale_date,
    country,
    cumulative_sales_amt,
    -- Using the LEAD function to find difference in cumulative sales
    LAG(cumulative_sales_amt, 1)
    OVER (PARTITION BY country ORDER BY sale_date ASC) - cumulative_sales_amt
    AS change_in_sales
FROM cumulative_sales
WHERE  country = 'South Africa'
AND sale_date in ('2024-02-15', '2024-02-12');


    
