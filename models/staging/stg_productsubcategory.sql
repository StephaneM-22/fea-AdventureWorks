with source as (
    select * from {{ source('adventure_works', 'production_productsubcategory') }}
),

renamed as (
    select
        productsubcategoryid,
        productcategoryid,
        trim(name)      as nome_subcategoria
    from source
)

select * from renamed