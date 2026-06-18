-- models/staging/stg_customers.sql

with source as (
    select * from "retail"."main"."customers"
),

renamed as (
    select
        id as customer_id,
        name,
        email,
        phone,
        address,
        suburb,
        state,
        postcode
    from source
)

select * from renamed
