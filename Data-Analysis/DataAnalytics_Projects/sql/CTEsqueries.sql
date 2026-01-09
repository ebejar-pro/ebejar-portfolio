--- Creating a CTE table
with sales_march_and_april as (
    select 
    sale_date,
    sale_amount
    from sales
    where strftime('%m', sale_date) = '03' or
            strftime('%m', sale_date) = 04
    )
--- Query the CTE table
select
    sum(sale_amount) as total_march_and_april_sales
from sales_march_and_april;

-- Querying CTEs with subqueries
with top_sales as (
        select sale_amount
        from sales
        order by sale_amount desc
        limit 3
         ),
bottom_sales as (
        select sale_amount
         from sales
         order by sale_amount asc
         limit 3
         )
-- Querying the two CTEs using subqueries
select 
        (select sum(sale_amount) from top_sales)
        as total_top_3_sales,
        (select sum(sale_amount) from bottom_sales)
        as total_bottom_3_sales

-- Nested CTEs
with average_sales as (
     -- Nested CTE to get top 3 sales amount
     with top_sales as (
         select sale_amount
         from sales
         order by sale_amount desc
         limit 3
     )
---------Outer CTE that calculates the average of the top 3 sales
     select avg(sale_amount) as top_3_average_sales
     from top_sales
)
-- Final query that converts the average sale amount to euros
select top_3_average_sales / 1.01 as top_3_average_sales_in_euros
from average_sales;