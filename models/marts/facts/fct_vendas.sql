with stg_salesorderheader as (
    select * from {{ ref('stg_salesorderheader') }}
),

stg_salesorderdetail as (
    select * from {{ ref('stg_salesorderdetail') }}
),

stg_order_salesreason as (
    select * from {{ ref('stg_order_salesreason') }}
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

dim_motivo_venda as (
    select * from {{ ref('dim_motivo_venda') }}
),

fct as (
    select
        md5(cast(sod.salesorderid as string) || '-' || cast(sod.salesorderdetailid as string)) as fct_vendas_sk,

        -- chaves naturais
        sod.salesorderid,
        sod.salesorderdetailid,

        -- foreign keys
        dd.data_sk,
        dc.cliente_sk,
        de.entregas_sk,
        dca.cartao_sk,
        dmv.motivo_venda_sk,
        md5(cast(sod.productid as string))  as produto_sk,

        -- métricas
        sod.orderqty,
        sod.unitprice,
        sod.unitpricediscount,
        soh.status,
        soh.status_descricao,

        -- métricas calculadas
        round(sod.unitprice * sod.orderqty, 2)                as valor_bruto,
        round(sod.unitprice * sod.orderqty * 
            (1 - sod.unitpricediscount), 2)                   as valor_liquido

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
    left join stg_order_salesreason osr
        on soh.salesorderid = osr.salesorderid
    left join dim_motivo_venda dmv
        on osr.salesreasonid = dmv.sales_reason_id
)

select * from fct