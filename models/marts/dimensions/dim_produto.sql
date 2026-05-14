with stg_product as (
    select * from {{ ref('stg_product') }}
),

stg_productsubcategory as (
    select * from {{ ref('stg_productsubcategory') }}
),

stg_productcategory as (
    select * from {{ ref('stg_productcategory') }}
),

final as (
    select
        {{ dbt_utils.generate_surrogate_key(['p.productid']) }} as produto_sk,
        p.productid                                             as product_id,
        p.nome_produto,
        p.numero_produto,
        p.cor,
        p.tamanho,
        p.preco_lista,
        ps.nome_subcategoria                                    as subcategoria,
        pc.nome_categoria                                       as categoria
    from stg_product p
    left join stg_productsubcategory ps
        on p.productsubcategoryid = ps.productsubcategoryid
    left join stg_productcategory pc
        on ps.productcategoryid = pc.productcategoryid
)

select * from final