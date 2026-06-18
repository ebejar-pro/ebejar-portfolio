
  
    
    

    create  table
      "retail"."main"."dim_customers__dbt_tmp"
  
    as (
      

select
    customer_id,
    customer_name,
    email,
    phone,
    address,
    suburb,
    state,
    postcode
from "retail"."main"."stg_customers"
    );
  
  