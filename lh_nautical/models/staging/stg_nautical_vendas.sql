with source_vendas AS (
    select *
    from {{ source('nautical','vendas_2023_2024') }}
)

, renamed AS (
    select
    cast(id as bigint) AS ven_pk,
    cast(id_client as bigint) AS client_fk,
    cast(id_product as bigint) AS product_fk,
    cast(qtd as numeric(20,1)) AS quant_vend,
    cast(total as numeric(30,2)) AS total_vend,
    sale_date AS date_vend_raw
    from source_vendas
)

, formatted AS (
    select
    ven_pk,
    client_fk,
    product_fk,
    quant_vend,
    total_vend,
    CASE
        WHEN date_vend_raw ~ '^\d{4}-\d{2}-\d{2}$'
            THEN date_vend_raw::date
        WHEN date_vend_raw ~ '^\d{2}-\d{2}-\d{4}$'
            THEN to_date(date_vend_raw, 'DD-MM-YYYY')
        ELSE NULL
    END AS data_vend
    FROM renamed
)

, removenull AS (
    select *
    from formatted
    where ven_pk IS NOT NULL
)
SELECT * FROM removenull