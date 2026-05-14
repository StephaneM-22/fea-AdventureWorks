with stg_address as (
    select * from {{ ref('stg_address') }}
),

stg_stateprovince as (
    select * from {{ ref('stg_stateprovince') }}
),

stg_countryregion as (
    select * from {{ ref('stg_countryregion') }}
),

final as (
    select
        {{ dbt_utils.generate_surrogate_key(['a.addressid']) }} as entregas_sk,
        a.addressid                                             as address_id,
        a.cidade,
        sp.nome_estado                                          as estado,
        sp.countryregioncode                                    as codigo_pais,
        cr.nome_pais                                            as pais
    from stg_address a
    left join stg_stateprovince sp
        on a.stateprovinceid = sp.stateprovinceid
    left join stg_countryregion cr
        on sp.countryregioncode = cr.countryregioncode
)

select * from final