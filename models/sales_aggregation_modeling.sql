{{ config(
    materialized='incremental',
    unique_key='order_date' 
) }}

select 
    DATE_TRUNC('month', order_date) AS order_date,
    COUNT(order_id) AS n_orders
from 
    bronze.sales_data.sales

{% if is_incremental() %}
    where order_date > (select max(order_date) from {{ this }}) 
{% endif %}

group by 
    order_date
