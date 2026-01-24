---delete from safety;
---drop table safety;

--- See the number of columns and rows
PRAGMA table_info(safety);

SELECT COUNT(*) AS number_of_rows
FROM safety;

---Report how many rows in the incident date is missing or contain empty strings
SELECT COUNT(*) missing_or_empty_strings 
FROM safety
WHERE incident_type is NULL or incident_type = '';

SELECT *
FROM safety
WHERE incident_type IS NULL OR incident_type = ''
   OR incident_date IS NULL OR incident_date = '';
   
SELECT * FROM safety;
   
UPDATE safety
SET days_lost = CASE
                WHEN days_lost = 'NULL' THEN 1
                ELSE days_lost
                END
WHERE days_lost = 'NULL';

UPDATE safety
SET days_lost = CASE
                WHEN employee_id IN (6, 12,19, 28) THEN 1
                ELSE days_lost
                END
WHERE employee_id IN (6, 12,19, 28);

SELECT 
    MIN(days_lost) AS min_value,
    MAX(days_lost) AS max_value,
    AVG(days_lost) AS avg_value
FROM safety;
   
UPDATE safety
SET incident_type = CASE 
                         WHEN employee_id IN (4, 10) THEN 'Fall'
                         ELSE incident_type
                    END
WHERE employee_id IN (4, 10);

UPDATE safety
SET incident_date = CASE 
                         WHEN employee_id = 2 THEN '23/01/2023'
                         WHEN employee_id = 17 THEN '11/11/2023'
                         WHEN employee_id = 23 THEN '30/01/2024'
                         ELSE incident_date
                    END
WHERE employee_id IN (2, 17, 23);


select * from safety;