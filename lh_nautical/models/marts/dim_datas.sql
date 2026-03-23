
with vendas as(
    select * from {{ ref('stg_nautical_vendas') }}
)

,dates as (

    select
        generate_series(
            (select min(data_vend) from vendas),
            (select max(data_vend) from vendas),
            interval '1 day'
        )::date as date_day
)

select
    date_day,

    extract(day from date_day) as day,
    extract(month from date_day) as month,
    extract(year from date_day) as year,

    extract(dow from date_day) as day_of_week_num,
    to_char(date_day, 'Day') as day_of_week_name,

    extract(week from date_day) as week_of_year,
    extract(quarter from date_day) as quarter,

    case 
        when extract(dow from date_day) in (0,6) then true 
        else false 
    end as is_weekend

from dates