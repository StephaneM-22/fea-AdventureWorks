with source as (
    select * from {{ source('adventure_works', 'person_person') }}
),

renamed as (
    select
        businessentityid,
        upper(trim(persontype))             as persontype,
        trim(firstname)                     as firstname,
        coalesce(trim(middlename), '')      as middlename,
        trim(lastname)                      as lastname,
        concat(
            trim(firstname), ' ', trim(lastname)
        )                                   as nome_completo
    from source
)

select * from renamed