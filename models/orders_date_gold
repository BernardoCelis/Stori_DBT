{{ config(
    materialized='table' 
) }}

select order_date, count(order_id) as n_orders_inc
from  ANALYTICS.DBT_LCELISPEREZ.orders_date_silver
group by order_date
