PRAGMA table_info (sales);

-- Checking for duplicates
SELECT * FROM sales
WHERE (sales_person, sale_amount, sale_date) IN (
    SELECT sales_person, sale_amount, sale_date
    FROM sales
    GROUP BY sales_person, sale_amount, sale_date
    HAVING COUNT(*) > 1
)
ORDER BY sales_person, sale_date;

-- Remove duplicates
DELETE FROM sales
WHERE sales_id NOT IN (
    SELECT MIN(sales_id)
    FROM sales
    GROUP BY sales_person, sale_amount, sale_date
);

select
    case
        when exists (select 1
                     from sales
                     group by sales_id, sales_person, sale_amount, sale_date
                     having count(*) > 1)
        then 'Duplicates in the table'
        else 'No duplicates in the table'
        end as duplicates_check;

-- Select oldest record for each person
with duplicates as (
    select sales_id
    from sales
    where sales_id not in (
        select min(sales_id)
        from sales
        group by sales_person
        )
)              
-- Delete oldest records for each person
delete from sales
where sales_id in (select sales_id from duplicates);
