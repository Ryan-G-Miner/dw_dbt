{{ config(
    materialized = 'table',
    schema = 'dw_samssubs'
    )
}}

select
        {{ dbt_utils.generate_surrogate_key(['customerid']) }} as CustomerKey,
        Customerid as CustomerID,
        CustomerFName, 
        CustomerLName, 
        customerbday as CustomerBirthDate,
        CustomerPhone
FROM {{ source('subs_source_landing', 'customer') }}