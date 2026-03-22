with source_produtos AS (
    select *
    from {{ source('nautical','produtos_raw') }}
)

, renamed AS (
    select
    cast(code as bigint) AS product_pk,
    cast(name as text) AS product_name,
    cast(actual_category as text) AS product_category,
    price AS product_price
    from source_produtos
)

, fromatted AS (
    SELECT
    product_pk,
    upper(product_name) AS product_name,
    upper(unaccent(regexp_replace(product_category,'[^a-zA-Z]+', '', 'g'))) AS product_category,
    replace(regexp_replace(product_price, '[^0-9\,\.]', '', 'g'), ',', '.')::numeric(12,2) AS product_price
    FROM renamed
)

, standardized AS (
    SELECT
    product_pk,
    product_name,
    CASE
        WHEN product_category LIKE '%ELE%' THEN 'ELETRONICOS'
        WHEN product_category LIKE '%PROP%' THEN 'PROPULSAO'
        WHEN product_category LIKE  '%ANC%' 
        OR product_category LIKE '%ENC%' 
        THEN 'ANCORAGEM'
        ELSE 'OUTROS'
    END AS product_category,
    product_price
    FROM fromatted
)

SELECT * FROM standardized