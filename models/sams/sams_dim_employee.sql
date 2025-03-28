{{ config(
    materialized = 'table',
    schema = 'dw_samssubs'
    )
}}

select
        {{ dbt_utils.generate_surrogate_key(['employeeid']) }} as EmployeeKey,
        Employeeid as EmployeeID,
        EmployeeFName, 
        EmployeeLName, 
        employeebday as EmployeeBirthDate
FROM {{ source('subs_source_landing', 'employee') }}