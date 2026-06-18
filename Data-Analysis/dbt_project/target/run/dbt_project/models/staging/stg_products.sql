
  
  create view "retail"."main"."stg_products__dbt_tmp" as (
    -- models/staging/stg_products.sql

with source as (
    select * from "retail"."main"."products"
),

renamed as (
    select
        id as product_id,
        name,
        price,
        current_stock_level,
        minimum_stock_level
    from source
)

select * from renamed
  );
