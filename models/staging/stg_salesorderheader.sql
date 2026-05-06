with source as (
    select * from {{ source('adventure_works', 'sales_salesorderheader') }}
),

renamed as (
    select
        salesorderid,
        cast(customerid         as int)     as customerid,
        cast(creditcardid       as int)     as creditcardid,
        cast(shiptoaddressid    as int)     as shiptoaddressid,
        cast(orderdate          as date)    as orderdate,
        status,
        case status
            when 1 then 'In Process'
            when 2 then 'Approved'
            when 3 then 'Backordered'
            when 4 then 'Rejected'
            when 5 then 'Shipped'
            when 6 then 'Cancelled'
        end                                 as status_descricao
    from source
)

select * from renamed