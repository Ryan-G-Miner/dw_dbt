{{ config(
    materialized = 'table',
    schema = 'dw_samssubs'
    )
}}

with cte_date as (
    {{dbt_date.get_date_dimension("1990-01-01", "2050-12-31")}}
)
select
       
date_day as date_key,
date_day as Day,
day_of_week as DayofWeek,
month_of_year as Month,
quarter_of_year as quarter,
year_number as Year

from cte_date