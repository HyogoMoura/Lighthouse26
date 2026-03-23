with vendas as (
    select
        data_vend,
        count(distinct ven_pk) as qtd_vendas
    from {{ ref('int_vendas__join') }}
    group by data_vend
)

select
    d.day_of_week_name,
    avg(coalesce(v.qtd_vendas, 0)) as vendas_medias
from {{ ref('dim_datas') }} d
left join vendas v
    on d.date_day = v.data_vend
group by d.day_of_week_name
order by vendas_medias desc
