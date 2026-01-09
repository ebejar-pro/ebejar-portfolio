select * from inter_sales;

-- ROW NUMBER function
select
    sales_person,
    sale_amount,
    ROW_NUMBER() OVER (ORDER BY sale_amount DESC)
    as rank
FROM inter_sales;

-- RANK function
select
    sales_person,
    sale_amount,
    RANK() OVER (ORDER BY sale_amount DESC)
    as rank
FROM inter_sales;

-- RANK function SELECTING rankingmsales person
WITH rank_sales AS (SELECT
    sales_person,
    sale_amount,
    RANK() OVER (ORDER BY sale_amount DESC)
    as rank
FROM inter_sales)

-- Retrieveing number one ranked sales person
SELECT 
    sales_person,
    sale_amount,
    rank
FROM    rank_sales
WHERE rank = 1;

-- DENSE RANK function
SELECT
    country,
    sales_person,
    sale_amount,
    DENSE_RANK() OVER (ORDER BY sale_amount DESC)
    as rank
FROM inter_sales;

--- Partition data by country
SELECT
    country,
    sales_person,
    sale_amount,
    DENSE_RANK() OVER (PARTITION BY country ORDER BY sale_amount DESC)
    as rank
FROM inter_sales;

--- Rank sellers by ecah country
WITH rank_sellers AS (
SELECT
    country,
    sales_person,
    sale_amount,
    DENSE_RANK() OVER (PARTITION BY country ORDER BY sale_amount DESC)
    as rank
FROM inter_sales)
-- Retrieving top sellers each country
SELECT
        country,
        sales_person,
        sale_amount
FROM     rank_sellers
WHERE    rank = 1;

--- Calculate accumulative sales per country
SELECT
    sale_date,
    country,
    sale_amount,
    SUM(sale_amount) OVER (PARTITION BY country ORDER BY sale_date ASC)
    AS cumulative_sales
    FROM inter_sales;
    
--- Calculate accumulative average sales per country
SELECT
    sale_date,
    country,
    sale_amount,
    AVG(sale_amount) OVER (PARTITION BY country ORDER BY sale_date ASC)
    AS cumulative_avg_sales
    FROM inter_sales;
    
-- Calculating average sales per country
WITH group_wise_average AS (
    SELECT
        sale_date,
        sales_person,
        country,
        sale_amount,
        AVG(sale_amount) OVER (PARTITION BY country)
        as avg_sales_country
FROM inter_sales
)
-- Calculating the percentage of each countr's average to sale amount
SELECT 
    sale_date,
    sales_person,
    country,
    avg_sales_country,
    ROUND((avg_sales_country/sale_amount * 100), 2)
    AS average_to_sales_percentage
FROM group_wise_average;
    