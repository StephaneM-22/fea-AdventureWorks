with source as (
    select * from {{ source('adventure_works', 'sales_customer') }}
),

renamed as (
    select
        customerid,
        cast(personid       as int)     as personid,
        cast(storeid        as int)     as storeid,
        territoryid
    from source
)

select * from renamed