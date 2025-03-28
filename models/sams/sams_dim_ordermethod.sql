{{ config( 
    materialized = 'table', 
    schema = 'dw_samssubs' 
) 
}} 

select 
{{ dbt_utils.generate_surrogate_key(['ordermethod']) }} AS OrderMKey, 

Ordermethod AS OrderMethod 

FROM {{ source('subs_source_landing', '"ORDER"') }} 