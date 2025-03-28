{{ config(
    materialized = 'table',
    schema = 'dw_samssubs'
    )
}}

select
        {{ dbt_utils.generate_surrogate_key(['page_url']) }} as WebpageKey,
        page_url as Webpageurl
FROM {{ source('web_traffic_landing', 'web_traffic_events') }}