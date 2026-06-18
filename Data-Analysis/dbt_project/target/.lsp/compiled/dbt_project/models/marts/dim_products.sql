-- models/marts/dim_products.sql

select
    p.product_id,
    p.name as product_name,
    p.price,
    p.current_stock_level,
    p.minimum_stock_level
from "retail"."main"."stg_products" as p
