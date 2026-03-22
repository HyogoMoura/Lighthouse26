with source_produtos AS (
    select *
    from {{ source('nautical','produtos_raw') }}
)

, renamed AS (
    select
    cast(code as bigint) AS client_pk,
    cast(email as text) AS client_email,
    cast(full_name as text) AS client_name,
    cast(location as text) AS client_location
    from source_produtos
)

, fromatted AS (
    SELECT
    client_pk,
    REPLACE(client_email,'#', '@') AS client_email,
    UPPER(client_name) AS client_name,
    
    CASE
        WHEN client_location ~ '^[A-Z]{2}' 
            THEN TRIM(regexp_replace(client_location, '^([A-Z]{2}).*', '\1'))
        ELSE
            TRIM(regexp_replace(client_location, '.*([A-Z]{2})$', '\1'))
    END AS client_estado,
    TRIM(regexp_replace(client_location, '(^[A-Z]{2}\W*|\W*[A-Z]{2}$)', '')) AS client_cidade
    FROM renamed
)

SELECT * FROM fromatted