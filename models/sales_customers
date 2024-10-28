{{ config(
    materialized='table' 
) }}

select customer_id, sum(amount) as total_amount
from bronze.sales_data.sales
group by 1
