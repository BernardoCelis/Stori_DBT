{{ config(
    materialized='table' 
) }}

select date_trunc('month',order_date) as order_date, count(order_id) as n_orders
from bronze.sales_data.sales
group by 1
