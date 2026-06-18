-- models/staging/stg_orders.sql

with source as (
    select * from "retail"."main"."orders"
),

renamed as (
    select
        id as order_id,
        customer_id,
        date,
        sales_channel,
        total_order
    from source
)

select * from renamed