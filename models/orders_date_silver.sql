{{ config(
    materialized='incremental',
    unique_key='order_id' 
) }}

with ordered_data as (
    select 
        DATE_TRUNC('month', order_date) AS order_date,
        order_id,
        row_number() over (partition by order_id order by order_date desc) as row_num 
    from
        bronze.sales_data.sales
    {% if is_incremental() %}
        where order_date > (select max(order_date) from {{ this }}) 
    {% endif %}
)

select order_date, order_id
from ordered_data
where row_num = 1
group by order_date, order_id
