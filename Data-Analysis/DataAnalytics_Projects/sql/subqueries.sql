select
    trim(sales_person) as sales_person,
    (select avg(sale_amount) from sales)  --subquery
    as bonus_pay
from sales;

select 
    sales_month,
    sum(sale_amount) as monthly_sales,
    sum(sale_amount) / 1.01 as monthly_sales_euros
from
    -- subquery insiode from clause
    (select 
            sale_amount,
            strftime('%m', sale_date) as sales_month
     from sales)
     group by sales_month
     order by sales_month;

select * from sales;  

select
    -- this calculates the total sales of top 3 sales
    (select sum(sale_amount)
    from
        (select sale_amount
         from sales
         order by sale_amount desc
         limit 3) as top_sales) as total_top_3_sales,
     -- This calculates the total sales of bottom 3 sales
     (select sum(sale_amount)
     from
        (select sale_amount
         from sales
         order by sale_amount asc
         limit 3) as bottom_sales) as total_bottom_3_sales;
         
select
    sales_id,
    sales_person,
    sale_amount
from sales
where sale_amount = (select max(sale_amount) from sales);

select
    sales_person,
    sum(sale_amount) as total_sales
from sales
group by sales_person
having sum(sale_amount) > (select avg(sale_amount) from sales);

-- all sales that are above the average sales for their respective month
select 
    s1.sales_id,
    s1.sales_person,
    s1.sale_amount,
    strftime('%m', s1.sale_date) as month
from sales as s1
where s1.sale_amount > (
    select avg(s2.sale_amount)
    from sales as s2
    where strftime('%m', s2.sale_date) = strftime('%m', s1.sale_date)
    );
    
update sales
set 
    sales_person = trim(sales_person)
where 
    sales_id is not null;
    
SELECT 
    strftime('%m', sale_date) as Month, 
    SUM(sale_amount) as Monthly_Total
FROM sales
GROUP BY Month
ORDER BY Month;

-- Identify Sales Person with sales that are above the yearly average for the year 2023
SELECT sales_person, SUM(sale_amount) AS total_sales
FROM sales
WHERE strftime('%Y', sale_date) = '2023'
GROUP BY sales_person
HAVING SUM(sale_amount) >
       (SELECT AVG(person_total)
        FROM (
            SELECT SUM(sale_amount) AS person_total
            FROM sales
            WHERE strftime('%Y', sale_date) = '2023'
            GROUP BY sales_person
        ));