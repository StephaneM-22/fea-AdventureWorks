with stg_salesorderheader as (
    select * from {{ ref('stg_salesorderheader') }}
),

stg_salesorderdetail as (
    select * from {{ ref('stg_salesorderdetail') }}
),

dim_data as (
    select * from {{ ref('dim_data') }}
),

dim_cliente as (
    select * from {{ ref('dim_cliente') }}
),

dim_entregas as (
    select * from {{ ref('dim_entregas') }}
),

dim_cartao as (
    select * from {{ ref('dim_cartao') }}
),

fct as (
    select
        {{ dbt_utils.generate_surrogate_key([
            'sod.salesorderid',
            'sod.salesorderdetailid'
        ]) }}                                                   as fct_vendas_sk,

        -- chaves naturais
        sod.salesorderid,
        sod.salesorderdetailid,

        -- foreign keys
        dd.data_sk,
        dc.cliente_sk,
        de.entregas_sk,
        dca.cartao_sk,
        {{ dbt_utils.generate_surrogate_key(['sod.productid']) }} as produto_sk,

        -- métricas
        sod.orderqty,
        sod.unitprice,
        sod.unitpricediscount,
        soh.status,
        soh.status_descricao,

        -- métricas calculadas
        sod.unitprice * sod.orderqty                            as valor_bruto,
        sod.unitprice * sod.orderqty * 
            (1 - sod.unitpricediscount)                         as valor_liquido

    from stg_salesorderdetail sod
    inner join stg_salesorderheader soh
        on sod.salesorderid = soh.salesorderid
    left join dim_data dd
        on soh.orderdate = dd.order_date
    left join dim_cliente dc
        on soh.customerid = dc.customer_id
    left join dim_entregas de
        on soh.shiptoaddressid = de.address_id
    left join dim_cartao dca
        on soh.creditcardid = dca.credit_card_id
)

select * from fct