with source as (
    select * from {{ source('adventure_works', 'sales_salesreason') }}
),

renamed as (
    select
        salesreasonid,
        trim(name)          as nome_motivo,
        trim(reasontype)    as tipo_motivo
    from source
)

select * from renamed