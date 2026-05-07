with stg_customer as (
    select * from {{ ref('stg_customer') }}
),

stg_person as (
    select * from {{ ref('stg_person') }}
),

final as (
    select
        {{ dbt_utils.generate_surrogate_key(['c.customerid']) }} as cliente_sk,
        c.customerid                                              as customer_id,
        c.personid                                                as person_id,
        p.nome_completo                                           as nome_cliente,
        p.persontype                                              as tipo_pessoa
    from stg_customer c
    left join stg_person p
        on c.personid = p.businessentityid
)

select * from final