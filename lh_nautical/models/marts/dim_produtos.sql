
select distinct
    product_pk,
    product_name,
    product_category,
    product_price
from {{ ref('stg_nautical_produtos') }}
