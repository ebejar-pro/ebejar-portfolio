

select
    oi.order_item_id,
    o.order_id,
    o.customer_id,
    o.order_date,
    o.sales_channel,
    o.total_order,
    oi.product_id,
    oi.quantity,
    p.price,
    oi.quantity * p.price as line_total
from "retail"."main"."stg_order_items" oi
left join "retail"."main"."stg_orders" o
    on oi.order_id = o.order_id
left join "retail"."main"."stg_products" p
    on oi.product_id = p.product_id