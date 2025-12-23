-- Re-creating the Store Dimension with 20 Australian locations
CREATE OR REPLACE TABLE `bq-analysis-04.retail_silver.dim_stores` AS
SELECT 1 as store_id, 'Sydney CBD' as store_name, 'NSW' as state, 'Urban' as store_type UNION ALL
SELECT 2, 'North Kellyville', 'NSW', 'Suburban' UNION ALL
SELECT 3, 'Melbourne Central', 'VIC', 'Urban' UNION ALL
SELECT 4, 'Parramatta', 'NSW', 'Suburban' UNION ALL
SELECT 5, 'Chatswood', 'NSW', 'Urban' UNION ALL
SELECT 6, 'Fortitude Valley', 'QLD', 'Urban' UNION ALL
SELECT 7, 'Surfers Paradise', 'QLD', 'Urban' UNION ALL
SELECT 8, 'Adelaide Hills', 'SA', 'Suburban' UNION ALL
SELECT 9, 'Perth City', 'WA', 'Urban' UNION ALL
SELECT 10, 'Hobart Waterfront', 'TAS', 'Urban' UNION ALL
SELECT 11, 'Canberra Centre', 'ACT', 'Urban' UNION ALL
SELECT 12, 'Geelong West', 'VIC', 'Suburban' UNION ALL
SELECT 13, 'Bondi Junction', 'NSW', 'Urban' UNION ALL
SELECT 14, 'Cronulla Beach', 'NSW', 'Suburban' UNION ALL
SELECT 15, 'Brisbane City', 'QLD', 'Urban' UNION ALL
SELECT 16, 'Freemantle', 'WA', 'Suburban' UNION ALL
SELECT 17, 'Darwin City', 'NT', 'Urban' UNION ALL
SELECT 18, 'Newcastle North', 'NSW', 'Suburban' UNION ALL
SELECT 19, 'Woollongong', 'NSW', 'Urban' UNION ALL
SELECT 20, 'Richmond', 'VIC', 'Suburban';