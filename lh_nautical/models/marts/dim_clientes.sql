select distinct
    CAST(client_pk AS TEXT) as client_pk,
    client_email,
    client_name,
    client_estado,
    client_cidade
from {{ ref('stg_nautical_clientes') }}