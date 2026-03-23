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
    upper(product_name) AS product_cost_name,
    upper(unaccent(product_category)) AS product_cost_category,
    jsonb_array_elements(
        replace(historic_data, '''', '"')::jsonb
    ) AS json_element

    FROM renamed
)

, normalized AS (
    SELECT
    product_pk,
    product_cost_name,
    product_cost_category,
    to_date(json_element ->> 'start_date','DD/MM/YYYY') AS start_date,
    (json_element ->> 'usd_price')::numeric AS usd_price
    FROM formatted
)

SELECT * FROM normalized
--where start_date between '01-01-2023' and '01-01-2025'