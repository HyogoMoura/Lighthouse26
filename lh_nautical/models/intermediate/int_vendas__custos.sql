with vendas_join as (
    select * from {{ ref('int_vendas__join') }}
)
,custos_join as (
    select * from {{ ref('int_custos__join') }}
)

,custos_ranked as (
    select
        v.ven_pk,
        v.data_vend,
        v.product_pk,
        v.quant_vend,
        v.total_vend,
        c.product_cost_usd,
        c.cost_start_date,

        row_number() over (
            partition by v.ven_pk
            order by c.cost_start_date desc
        ) as rn

    from vendas_join v
    left join custos_join c
        on v.product_pk = c.product_pk
       and c.cost_start_date <= v.data_vend
)

select
    ven_pk,
    data_vend,
    product_pk,
    quant_vend,
    total_vend,
    product_cost_usd
from custos_ranked
where rn = 1