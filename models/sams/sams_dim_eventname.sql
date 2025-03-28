{{ config(
    materialized = 'table',
    schema = 'dw_samssubs'
    )
}}

select
        {{ dbt_utils.generate_surrogate_key(['event_name']) }} as EventKey,
        Event_name as EventName
FROM {{ source('web_traffic_landing', 'web_traffic_events') }}