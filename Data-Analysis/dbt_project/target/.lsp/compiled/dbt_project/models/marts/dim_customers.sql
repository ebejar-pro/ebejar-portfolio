
-- models/marts/dim_customers.sql

select
    c.customer_id,
    c.name as customer_name,
    c.email,
    c.phone,
    c.address,
    c.suburb,
    c.state,
    c.postcode
from "retail"."main"."stg_customers" as c