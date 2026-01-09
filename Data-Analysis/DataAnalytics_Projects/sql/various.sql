select DATE(sale_date) AS date
from sales;

SELECT 
    sales_id,
    sales_person,
    sale_amount,
    DATE(sale_date, '-6 months') AS updated_sales_date
FROM sales;

select julianday('2023-03-20') - julianday('2023-01-10') as diff_between_date;

select strftime('%d-%m-%Y', DATE(sale_date)) as newdate
from sales
order by newdate;

select * from sales;

select sales_person,
length(sales_person) AS number_of_characters
from sales
order by number_of_characters;

select strftime('%H:%M:%S', sale_date) as time
from sales
limit 2;


select strftime('%d-%m-%Y', sale_date) as date
from sales
limit 2;

select * from sales
where strftime('%Y-%m-%d', sale_date)
between date('2023-02-15') and date('2023-05-30');

select 
    sales_person,
    length(sales_person) as num_of_chars
from sales
order by num_of_chars;

select
    sales_person,
    length(trim(sales_person)) <> length(sales_person)
        as has_leading_trailing_whitespace
from 
sales;

select
    sales_person,
    length(sales_person) - length(trim(sales_person))
        as has_leading_trailing_whitespace
from 
sales;

select 
    lower(sales_person) as name_lowercase
from sales;

select 
    replace(sales_person, ' ', '') as name_with_no_space
from sales;

select 
    replace(sales_person, ' ', '-') as name_with_no_space
from sales;

select 
    trim(sales_person) || ' made sale of '|| sale_amount || ' on ' || 
    date(sale_date) 
    as sale_summary
from sales;

select instr(sales_person, 'Rossi')
    as position_of_rossi
from sales
where instr(sales_person, 'Rossi') > 0;

select sales_person,
    substr(sales_person, 4, 6)
    as substring
from sales;

select sales_person,
    printf("%30s", substr(trim(sales_person), instr(trim(sales_person), ' ') + 1))
    as last_name_of_seller
from sales;

