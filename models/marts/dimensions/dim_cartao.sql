with stg_creditcard as (
    select * from {{ ref('stg_creditcard') }}
),

final as (
    select
        {{ dbt_utils.generate_surrogate_key(['creditcardid']) }} as cartao_sk,
        creditcardid                                              as credit_card_id,
        tipo_cartao,
        mes_expiracao,
        ano_expiracao
    from stg_creditcard
)

select * from final