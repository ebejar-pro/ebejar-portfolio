select 
    s.sales_id,
    s.sales_person,
    s.sale_amount,
    c.cost_amount
from sales as s    -- sales is the left table

left join costs as c --- costs is the right table

on s.sales_id = c.sales_id;

select 
    s.sales_id,
    s.sales_person,
    s.sale_amount,
    c.cost_amount
from costs as c  -- costs is the right table

left join sales as s   -- sales is the right table

on s.sales_id = c.sales_id;

select 
    s.sales_id,
    s.sales_person,
    s.sale_amount,
    c.cost_amount
from sales as s    -- sales is the left table

inner join costs as c --- costs is the right table

on s.sales_id = c.sales_id;

select 
    s.sales_id,
    s.sales_person,
    s.sale_amount,
    c.cost_amount
from sales as s    -- sales is the left table
left join costs as c --- costs is the right table
on s.sales_id = c.sales_id

union --- joining 2 tables

select 
    s.sales_id,
    s.sales_person,
    s.sale_amount,
    c.cost_amount
from costs as c    -- sales is the left table
left join sales as s --- costs is the right table
on s.sales_id = c.sales_id;

--- Joint sales and costs tables to find total sales > 160000
SELECT
    s.sales_person,
    SUM(s.sale_amount) AS total_sales,
    SUM(c.cost_amount) AS total_costs
FROM sales s
JOIN costs c
    ON s.sales_id = c.sales_id
GROUP BY s.sales_person
HAVING SUM(s.sale_amount) > 160000;

--- Joint sales and costs tables to find total sales Total costs and profit by each salesperson
SELECT
    s.sales_person,
    SUM(s.sale_amount) AS total_sales,
    SUM(c.cost_amount) AS total_costs,
    SUM(s.sale_amount) - SUM(c.cost_amount) AS profit  
FROM sales s
JOIN costs c
    ON s.sales_id = c.sales_id
GROUP BY s.sales_person
HAVING SUM(s.sale_amount) > 160000;

-- Rewrite above SQLs by using CTE
WITH sales_summary AS (
    SELECT
        s.sales_person,
        SUM(s.sale_amount) AS total_sales,
        SUM(c.cost_amount) AS total_costs
    FROM sales s
    JOIN costs c
        ON s.sales_id = c.sales_id
    GROUP BY s.sales_person
)
SELECT
    sales_person,
    total_sales,
    total_costs,
    total_sales - total_costs AS profit
FROM sales_summary
WHERE total_sales > 160000;

-- Add ranking 
WITH sales_summary AS (
    SELECT
        s.sales_person,
        SUM(s.sale_amount) AS total_sales,
        SUM(c.cost_amount) AS total_costs
    FROM sales s
    JOIN costs c
        ON s.sales_id = c.sales_id
    GROUP BY s.sales_person
)
SELECT
    sales_person,
    total_sales,
    total_costs,
    total_sales - total_costs AS profit,
    RANK() OVER (ORDER BY total_sales DESC) AS sales_rank
FROM sales_summary
WHERE total_sales > 160000;

--SQLite optimised CTE
WITH sales_summary AS (
    SELECT
        s.sales_person,
        ROUND(SUM(s.sale_amount), 2) AS total_sales,
        ROUND(SUM(c.cost_amount), 2) AS total_costs
    FROM sales s
    INNER JOIN costs c
        ON s.sales_id = c.sales_id
    GROUP BY s.sales_person
)
SELECT
    sales_person,
    total_sales,
    total_costs,
    ROUND(total_sales - total_costs, 2) AS profit
FROM sales_summary
WHERE total_sales > 160000
ORDER BY total_sales DESC;

