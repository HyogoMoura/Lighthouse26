with vendas_join as(
    select * from {{ ref('int_vendas__join') }}
)
,custos_join as (
    select * from {{ ref('int_custos__avg') }}
)

select
    CAST(v.ven_pk AS TEXT) as venda_id,
    v.data_vend,
    CAST(v.client_pk AS TEXT) as client_id,
    v.client_name,
    CAST(v.product_pk AS TEXT) as product_id,
    v.product_name,
    v.quant_vend,
    v.total_vend_usd,
    v.quant_vend * c.avg_cost as custo_total_usd,
    (v.total_vend_usd - v.quant_vend*c.avg_cost) as lucro_estimado_usd

from vendas_join as v
left join custos_join as c on v.product_pk = c.product_pk

