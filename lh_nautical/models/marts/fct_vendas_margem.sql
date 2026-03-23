with vendas as (
    select *
    from {{ ref('int_vendas__join') }}
)
,custos as (
    select *
    from {{ ref('int_custos__avg') }}
)

select
    CAST(v.ven_pk AS TEXT) as venda_id,
    v.data_vend,
    CAST(v.product_pk AS TEXT) as product_id,
    v.product_name,
    v.quant_vend,
    v.total_vend_usd,
    c.avg_cost as avg_product_cost_usd, 
    (v.quant_vend * c.avg_cost) as custo_total_usd,
    ((v.total_vend_usd) - (v.quant_vend * c.avg_cost)) as lucro_estimado_usd
from vendas as v
left join custos as c on v.product_pk = c.product_pk