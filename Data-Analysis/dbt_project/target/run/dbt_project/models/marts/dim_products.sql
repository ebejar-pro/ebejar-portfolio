
  
    
    

    create  table
      "retail"."main"."dim_products__dbt_tmp"
  
    as (
      

select
    product_id,
    product_name,
    price,
    current_stock_level,
    minimum_stock_level
from "retail"."main"."stg_products"
    );
  
  