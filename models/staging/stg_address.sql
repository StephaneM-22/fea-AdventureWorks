with source as (
    select * from {{ source('adventure_works', 'person_address') }}
),

renamed as (
    select
        addressid,
        trim(addressline1)                  as addressline1,
        coalesce(trim(addressline2), '')    as addressline2,
        trim(city)                          as cidade,
        stateprovinceid,
        trim(postalcode)                    as postalcode
    from source
)

select * from renamed