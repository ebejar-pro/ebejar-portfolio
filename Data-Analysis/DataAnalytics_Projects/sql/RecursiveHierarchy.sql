WITH RECURSIVE product_hierarchy AS (
-- Base Case: Start with root categories (parent_id = NULL)
SELECT
    accessory_id,
    accessory_name,
    parent_id,
    1 AS level
FROM accessories
WHERE parent_id IS NULL

UNION ALL

--- Recursive Case: Find child categories
SELECT
    c.accessory_id,
    c.accessory_name,
    c.parent_id,
    ph.level + 1 AS level
    
FROM accessories c
INNER JOIN product_hierarchy ph
    ON c.parent_id = ph.accessory_id
)
SELECT * FROM product_hierarchy ORDER BY level, accessory_id;

----------------------------------------------------------------
--Recursive SQL workrecords
WITH RECURSIVE work_summary AS (
-- Base Case: Start with the first occurrence (minimum id) of each employee
    SELECT 
        id,
        first_name,
        days_worked accumulated_days,
        earnings AS accumulated_earnings
FROM workrecords
WHERE id IN (SELECT MIN(ID) FROM workrecords GROUP BY first_name)


UNION ALL  --- Combining base case with recursive step

--- Recursive case: Accumulate days worked and earnings for each employee
SELECT 
    w.id,
    w.first_name,
    ws.accumulated_days + w.days_worked,
    ws.accumulated_earnings + w.earnings
FROM workrecords w
JOIN work_summary ws
ON ws.first_name = w.first_name and w.id > ws.id
)
SELECT 
    first_name,
    MAX(accumulated_earnings) AS total_accumulative,
    MAX(accumulated_days) AS total_accumulative_days
FROM work_summary
GROUP BY first_name;

--- Simple query without using RECURSIVE query
SELECT 
    first_name,
    SUM(earnings) AS total_earnings,
    SUM(days_worked) AS total_days_worked
FROM workrecords
GROUP BY first_name;