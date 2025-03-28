{{ config(
    materialized = 'table',
    schema = 'dw_samssubs'
) }}

SELECT
    e.EventKey,
    s.SourceKey,
    w.WebpageKey,
    sc.event_timestamp as TimeStamp,
    sc.User_Email as UserEmail,
    sc._line as InteractionCount

FROM {{ source('web_traffic_landing', 'web_traffic_events') }} as sc
INNER JOIN {{ ref('sams_dim_eventname') }} e ON e.EventName = sc.event_name
INNER JOIN {{ ref('sams_dim_trafficsource') }} s ON s.SourceName = sc.traffic_source
INNER JOIN {{ ref('sams_sim_webpage') }} w ON w.webpageurl = sc.page_url