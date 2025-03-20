{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
) }}

WITH date_series AS (
    SELECT 
        DATEADD(DAY, ROW_NUMBER() OVER () - 1, '1990-01-01') AS date_id
    FROM TABLE(GENERATOR(ROWCOUNT => 21916))  -- Generates dates from 1990-01-01 to 2050-12-31
)

SELECT
    TO_CHAR(date_id, 'YYYYMMDD')::INTEGER AS date_key,  -- Primary Key
    date_id,                                            -- Natural Key (Date)
    DAYOFWEEK(date_id) AS dayofweek,                    -- Day of the Week (1=Sun, 7=Sat)
    MONTH(date_id) AS month,                            -- Month Number (1-12)
    QUARTER(date_id) AS quarter,                        -- Quarter Number (1-4)
    YEAR(date_id) AS year                               -- Year
FROM date_series;
