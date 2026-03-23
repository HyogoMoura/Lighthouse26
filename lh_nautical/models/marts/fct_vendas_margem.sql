with vendas_custos as (
    select *
    from {{ ref('int_vendas__custos') }}
)

select
    CAST(ven_pk AS TEXT) as venda_id,
    data_vend,
    CAST(product_pk AS TEXT) as product_id,
    quant_vend,
    total_vend,
    product_cost_usd,
    product_cost_brl, 
    (quant_vend * product_cost_usd) as custo_total_usd,
    (quant_vend * product_cost_brl) as custo_total_brl,
    ((total_vend/4.97) - (quant_vend * product_cost_usd)) as lucro_estimado_usd,
    (total_vend - (quant_vend * product_cost_brl)) as lucro_estimado_brl
from vendas_custos