with vendas_join as(
    select * from {{ ref('int_vendas__join') }}
)
,custos_join as (
    select * from {{ ref('int_custos__join') }}
)

select
    CAST(v.ven_pk AS TEXT) as venda_id,
    v.data_vend,
    CAST(v.client_pk AS TEXT) as client_id,
    CAST(v.product_pk AS TEXT) as product_id,
    v.quant_vend,
    v.total_vend,
    v.quant_vend * c.product_cost_brl as custo_total_brl,
    (v.total_vend - v.quant_vend*c.product_cost_brl) as lucro_estimado_brl

from vendas_join as v
left join custos_join as c on v.product_pk = c.product_pk

