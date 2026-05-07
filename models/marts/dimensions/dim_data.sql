with stg_salesorderheader as (
    select * from {{ ref('stg_salesorderheader') }}
),

final as (
    select distinct
        {{ dbt_utils.generate_surrogate_key(['orderdate']) }} as data_sk,
        orderdate                                             as order_date,
        year(orderdate)                                       as ano,
        month(orderdate)                                      as mes,
        case month(orderdate)
            when 1  then 'Janeiro'
            when 2  then 'Fevereiro'
            when 3  then 'Março'
            when 4  then 'Abril'
            when 5  then 'Maio'
            when 6  then 'Junho'
            when 7  then 'Julho'
            when 8  then 'Agosto'
            when 9  then 'Setembro'
            when 10 then 'Outubro'
            when 11 then 'Novembro'
            when 12 then 'Dezembro'
        end                                                   as nome_mes,
        quarter(orderdate)                                    as trimestre,
        case when month(orderdate) <= 6 then 1 else 2 end    as semestre,
        date_format(orderdate, 'yyyy-MM')                     as ano_mes
    from stg_salesorderheader
)

select * from final