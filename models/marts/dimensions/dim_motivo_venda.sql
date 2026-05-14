with stg_salesreason as (
    select * from {{ ref('stg_salesreason') }}
),

final as (
    select
        {{ dbt_utils.generate_surrogate_key(['salesreasonid']) }} as motivo_venda_sk,
        salesreasonid                                              as sales_reason_id,
        nome_motivo,
        tipo_motivo
    from stg_salesreason
)

select * from final