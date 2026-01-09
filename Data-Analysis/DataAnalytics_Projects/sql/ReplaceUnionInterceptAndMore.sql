select sales_person 
from sales
where sales_person in ('Anja MAAAller', 'JAAArgen Schneider');

-- Replace characters in sales person name

update sales
set sales_person = replace (sales_person, 'AAA', 'u')
where sales_person in ('Anja MAAAller', 'JAAArgen Schneider');

select sales_person 
from sales
where sales_person in ('Anja Muller', 'Jurgen Schneider');

-- Union of 2 queris
select sales_person, sale_amount
from sales
where sales_person = 'Anja Muller' and strftime('%m', sale_date) = '06'

union all -- Using union all to combine results

select sales_person, sale_amount
from sales
where sales_person = 'Jurgen Schneider' and strftime('%m', sale_date) = '06'

-- Intersect of 2 queries
SELECT strftime('%m', sale_date) AS common_sales_month
FROM sales
WHERE sales_person = 'Yuki Nakamura' 
  AND strftime('%Y', sale_date) = '2023'

INTERSECT

SELECT strftime('%m', sale_date) AS common_sales_month
FROM sales
WHERE sales_person = 'Giovanni Rossi' 
  AND strftime('%Y', sale_date) = '2023'
ORDER BY common_sales_month;

-- Unipon of 2 queries
select sales_person, sale_amount
from sales
where sales_person = 'Yuki Nakamura' and strftime('%m', sale_date) = '06'

union all -- Using union all to combine results

select sales_person, sale_amount
from sales
where sales_person = 'Jurgen Schneider' and strftime('%m', sale_date) = '06'


-- Months Yuki sold in that Giovanni did NOT
SELECT strftime('%m', sale_date) FROM sales WHERE sales_person = 'Wei Zhang'
EXCEPT
SELECT strftime('%m', sale_date) FROM sales WHERE sales_person = 'Anja Muller';

SELECT strftime('%m', sale_date) FROM sales WHERE sales_person = 'Wei Zhang'
Order BY strftime('%m', sale_date);

select 
    sales_person,
    round(sale_amount / (
        select avg(NULLIF(sale_amount, 0))
        from sales) * 100, 2
        ) as sales_to_average_percentage
from sales
group by sales_person;

select 
    sales_person,
    coalesce(sale_amount, 0) as sales_amount_minus_null_values
from sales;

select 
    coalesce(sale_person, 'Unknown') as sales_person_update
from sales;