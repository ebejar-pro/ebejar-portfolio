-- Case Expressions list sales reaching at annual target
select 
    sales_person,
    sum(sale_amount) as total_sales,
    case
        when sum(sale_amount) >= 160000 then 'Target reached'
        else 'Target not reached'
    end as sales_target
from sales
group by sales_person;

-- Case expression to list "Target reached", "Target almost reached" or "Target not reached"
select 
    sales_person,
    sum(sale_amount) as total_sales,
    case
        when sum(sale_amount) >= 160000 then 'Target reached'
        when sum(sale_amount) between 150000 and 159999 then 'Target almost reached' 
        else 'Target not reached'
    end as sales_target
from sales
group by sales_person;


--- Case expression inside a CTE

WITH sales_target AS (
    SELECT
        sales_person,
        SUM(sale_amount) AS total_sales,
        CASE
            WHEN SUM(sale_amount) >= 160000 THEN 'Target reached'
            WHEN SUM(sale_amount) BETWEEN 150000 AND 159999 THEN 'Target almost reached'
            ELSE 'Target not reached'
        END AS sales_target
    FROM sales
    GROUP BY sales_person
)
SELECT 
    sales_person,
    total_sales,
    sales_target
FROM sales_target
WHERE sales_target = 'Target reached';