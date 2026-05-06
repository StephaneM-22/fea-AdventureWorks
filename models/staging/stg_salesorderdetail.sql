with source as (
    select * from {{ source('adventure_works', 'sales_salesorderdetail') }}
),

renamed as (
    select
        salesorderid,
        salesorderdetailid,
        productid,
        orderqty,
        unitprice,
        unitpricediscount
    from source
)

select * from renamed