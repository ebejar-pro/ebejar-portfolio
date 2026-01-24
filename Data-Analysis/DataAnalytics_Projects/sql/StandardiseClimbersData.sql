PRAGMA table_info ('climbers');-- LIst duplicates in the table climbers (id , climber_name)

-- List duplicates count
SELECT 
       climber_name, 
       nationality,
       count( * ) AS duplicate_count
  FROM climbers
 GROUP BY 
          climber_name, nationality
HAVING COUNT( * ) > 1;

--- Delete duplicates records
DELETE FROM climbers
WHERE rowid NOT IN (
    SELECT MIN(rowid)
    FROM climbers
    GROUP BY climber_name, nationality
);

--- Duplicates have been removed
SELECT COUNT(*) FROM climbers;

--It should list ZERO records
SELECT climber_name, nationality, COUNT(*)
FROM climbers
GROUP BY climber_name, nationality
HAVING COUNT(*) > 1;

--- Prevent duplicates in climbers table
CREATE UNIQUE INDEX idx_climber_unique
ON climbers (climber_name, nationality);

--- Update date_of_first_ascent from 'DD MM YYYY ' to 'YYYY-MM-DD'
UPDATE climbers
SET date_of_first_ascent =
    substr(date_of_first_ascent, 7, 4) || '-' ||
    substr(date_of_first_ascent, 4, 2) || '-' ||
    substr(date_of_first_ascent, 1, 2);

UPDATE climbers
SET date_of_last_ascent =
    substr(date_of_last_ascent, 7, 4) || '-' ||
    substr(date_of_last_ascent, 4, 2) || '-' ||
    substr(date_of_last_ascent, 1, 2);
 
-- Update date of first ascent and last ascent strings as they don't follow the pattern 'DD MM YYYY'   
UPDATE climbers
SET date_of_first_ascent = '1978-05-08'
WHERE id = '1103'; 

UPDATE climbers
SET date_of_last_ascent = '1978-05-08'
WHERE id = '1103'; 

--- Replace the prefix Sir by space
UPDATE climbers
SET climber_name = REPLACE(climber_name, 'Sir', '')
WHERE id = '1107';

select * from climbers;




