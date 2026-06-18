-- models/staging/stg_order_items.sql

with source as (
    select * from "retail"."main"."order_items"
),

renamed as (
    select
        id as order_item_id,
        order_id,
        product_id,
        quantity
    from source
)

select * from renamed