with vendas as(
    select * from {{ ref('stg_nautical_vendas') }}
)
, clientes as (
    select * from {{ ref('stg_nautical_clientes') }}
)
, produtos as (
    select * from {{ ref('stg_nautical_produtos') }}
)

select
    v.ven_pk,
    v.data_vend,
    v.quant_vend,
    v.total_vend,

    c.client_pk,
    c.client_estado,
    c.client_cidade,

    p.product_pk,
    p.product_name,
    p.product_category,
    p.product_price

from vendas AS v
left join clientes AS  c
    on v.client_fk = c.client_pk
left join produtos AS  p
    on v.product_fk = p.product_pk