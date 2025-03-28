{{ config(
    materialized = 'table',
    schema = 'dw_samssubs'
    )
}}

select
        {{ dbt_utils.generate_surrogate_key(['traffic_source']) }} as SourceKey,
        traffic_source as SourceName
FROM {{ source('web_traffic_landing', 'web_traffic_events') }}