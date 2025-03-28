{{ config(
    materialized = 'table',
    schema = 'dw_samssubs'
) }}

SELECT
    o.OrderNumber,
    DATE(od.OrderDate) AS DateKey,
    e.EmployeeKey,
    s.StoreKey,
    p.ProductKey,
    c.CustomerKey,
    o.OrderLineQTY AS Quantity,
    o.OrderLinePrice AS OrderLineTotal,
    (o.OrderLinePrice / o.OrderLineQTY) AS ProductCost,
    om.OrderMKey,
    o.PointsEarned
FROM {{ source('subs_source_landing', 'orderdetails') }} o
INNER JOIN {{ source('subs_source_landing', '"ORDER"') }} od ON od.ordernumber = o.ordernumber
INNER JOIN {{ source('subs_source_landing', 'employee') }} em ON em.employeeid = od.employeeid
INNER JOIN {{ ref('sams_dim_product') }} p ON p.productid = o.productid
INNER JOIN {{ ref('sams_dim_ordermethod')}} om ON om.ordermethod = od.ordermethod
INNER JOIN {{ ref('sams_dim_employee')}} e ON e.EmployeeID = od.Employeeid
INNER JOIN {{ ref('sams_dim_customer')}} c ON c.CustomerID = od.customerid
INNER JOIN {{ ref('sams_dim_store')}} s ON s.StoreID = em.storeid