with source_custos AS (
    select *
    from {{ source('nautical','custos_importacao') }}
)

, renamed AS (
    select
    cast(product_id as bigint) AS product_pk,
    cast(category as text) AS product_category,
    cast(product_name as text) AS product_name,
    historic_data
    from source_custos
)

, formatted AS (
    SELECT
    product_pk,
    upper(product_category) AS product_category,
    upper(product_name) AS product_name,
    
    jsonb_array_elements(
        replace(historic_data, '''', '"')::jsonb
    ) AS json_element

    FROM renamed
)

, normalized AS (
    SELECT
    product_pk,
    product_category,
    product_name,
    (json_element ->> 'start_date')::date AS start_date,
    (json_element ->> 'usd_price')::numeric AS usd_price

    FROM formatted
)

SELECT * FROM normalized