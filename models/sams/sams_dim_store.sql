{{ config(
    materialized = 'table',
    schema = 'dw_samssubs'
    )
}}

select
        {{ dbt_utils.generate_surrogate_key(['storeid']) }} as StoreKey,
        storeid as StoreID, 
        address as StoreAddress,
        city as StoreCity,
        state as StoreState,
        zip as StoreZip
FROM {{ source('subs_source_landing', 'store') }}