with custos as (
    select * from {{ ref('stg_nautical_custos') }}
),

stg AS (
    SELECT 
        product_pk,
        product_cost_name,    
        product_cost_category,    
        start_date,
        usd_price as product_cost_usd
    FROM stg_nautical_custos
    where start_date between '01-01-2020' and '01-01-2026'
)

SELECT
    product_pk,
    product_cost_name,    
    product_cost_category,    
    round(AVG(product_cost_usd), 2) AS avg_cost
FROM stg
GROUP BY 
    product_pk,
    product_cost_name,
    product_cost_category