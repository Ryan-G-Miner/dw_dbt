{{ config(
    materialized = 'table',
    schema = 'dw_samssubs'
    )
}}

select
        {{ dbt_utils.generate_surrogate_key(['p.productid']) }} as ProductKey,
        p.productid as ProductID, 
        p.ProductType,
        p.ProductName,
        p.ProductCalories,
        s.length as SandwichLength,
        s.BreadType

FROM {{ source('subs_source_landing', 'product') }} as p
LEFT JOIN {{ source('subs_source_landing', 'sandwich') }} as s 
    on p.productid=s.productid