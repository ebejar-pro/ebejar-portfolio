--- ROW_NUMBER functionWITH sales_summary A
WITH sales_summary AS (
    SELECT
        s.sales_person,
        SUM(s.sale_amount) AS total_sales
    FROM sales s
    GROUP BY s.sales_person
)
SELECT
    sales_person,
    total_sales,
    ROW_NUMBER() OVER (ORDER BY total_sales DESC) AS rank
FROM sales_summary;

--- RANK Function
WITH sales_summary AS (
    SELECT
        s.sales_person,
        SUM(s.sale_amount) AS total_sales
    FROM sales s
    GROUP BY s.sales_person
)
SELECT
    sales_person,
    total_sales,
    RANK() OVER (ORDER BY total_sales DESC) AS rank
FROM sales_summary;

-- DENSE RANK Function
WITH sales_summary AS (
    SELECT
        s.sales_person,
        SUM(s.sale_amount) AS total_sales
    FROM sales s
    GROUP BY s.sales_person
)
SELECT
    sales_person,
    total_sales,
    DENSE_RANK() OVER (ORDER BY total_sales DESC) AS rank
FROM sales_summary;