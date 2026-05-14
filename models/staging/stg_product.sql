with source as (
    select * from {{ source('adventure_works', 'production_product') }}
),

renamed as (
    select
        productid,
        trim(name)                                      as nome_produto,
        trim(productnumber)                             as numero_produto,
        coalesce(trim(color), 'N/A')                    as cor,
        coalesce(trim(size), 'N/A')                     as tamanho,
        listprice                                       as preco_lista,
        cast(productsubcategoryid   as int)             as productsubcategoryid
    from source
)

select * from renamed