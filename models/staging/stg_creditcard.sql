with source as (
    select * from {{ source('adventure_works', 'sales_creditcard') }}
),

renamed as (
    select
        creditcardid,
        trim(cardtype)      as tipo_cartao,
        expmonth            as mes_expiracao,
        expyear             as ano_expiracao
    from source
)

select * from renamed