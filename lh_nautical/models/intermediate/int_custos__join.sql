with custos as (
    select * from {{ ref('stg_nautical_custos') }}
)
, produtos as (
    select * from {{ ref('stg_nautical_produtos') }}
)

select
    c.product_pk,
    p.product_name,
    p.product_category,

    c.product_cost_name,
    c.product_cost_category,

    c.start_date as cost_start_date,
    c.usd_price as product_cost_usd

from custos c
left join produtos p
    on c.product_pk = p.product_pk