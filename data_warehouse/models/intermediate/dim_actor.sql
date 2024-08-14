{{ config(
    materialized="table",
    schema="intermediate"
) }}

SELECT
    actor_id,
    first_name || ' ' || last_name AS full_name
FROM
    {{ ref('actor') }}