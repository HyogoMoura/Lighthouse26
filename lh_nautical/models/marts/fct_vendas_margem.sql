select
    ven_pk as venda_id,
    data_vend,
    client_pk as client_id,
    product_pk as product_id,
    quant_vend,
    total_vend,
    product_cost_usd,
    (quant_vend * product_cost_usd) as custo_total,
    (total_vend - (quant_vend * product_cost_usd)) as lucro_estimado

from {{ ref('int_vendas__custos') }}