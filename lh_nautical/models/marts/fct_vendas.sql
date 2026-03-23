with vendas_join as(
    select * from {{ ref('int_vendas__join') }}
)

select
    ven_pk as venda_id,
    data_vend,
    client_pk as client_id,
    product_pk as product_id,
    quant_vend,
    total_vend
from vendas_join
