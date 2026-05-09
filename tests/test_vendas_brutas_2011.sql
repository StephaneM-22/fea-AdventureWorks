-- Teste de auditoria solicitado pelo CEO Carlos Silveira
-- Valida que as vendas brutas de 2011 totalizam exatamente $12.646.112,16
-- O teste FALHA se retornar linhas (diferença maior que $0,01)

with fct as (
    select * from {{ ref('fct_vendas') }}
),

dim as (
    select * from {{ ref('dim_data') }}
)

select
    sum(fct.valor_bruto)    as total_calculado,
    12646112.16             as total_esperado,
    abs(sum(fct.valor_bruto) - 12646112.16) as diferenca
from fct
inner join dim on fct.data_sk = dim.data_sk
where dim.ano = 2011
having abs(sum(fct.valor_bruto) - 12646112.16) > 0.01