with source as (
    select * from {{ source('adventure_works', 'person_countryregion') }}
),

renamed as (
    select
        upper(trim(countryregioncode))      as countryregioncode,
        trim(name)                          as nome_pais
    from source
)

select * from renamed