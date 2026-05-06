with source as (
    select * from {{ source('adventure_works', 'person_stateprovince') }}
),

renamed as (
    select
        stateprovinceid,
        trim(stateprovincecode)             as stateprovincecode,
        upper(trim(countryregioncode))      as countryregioncode,
        trim(name)                          as nome_estado
    from source
)

select * from renamed