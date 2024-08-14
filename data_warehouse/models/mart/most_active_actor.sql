{{ config(
    materialized="table",
    schema="mart"
) }}

WITH actor_roles AS (
    SELECT
        a.actor_id,
        a.full_name AS actor_name,
        COUNT(fa.film_id) AS role_count
    FROM
        {{ ref('dim_actor') }} a
    JOIN
        {{ ref('dim_film_actor') }} fa ON a.actor_id = fa.actor_id
    JOIN
        {{ ref('dim_film') }} f ON fa.film_id = f.film_id
    GROUP BY
        a.actor_id, a.full_name
)

SELECT
    actor_name,
    role_count
FROM
    actor_roles
ORDER BY
    role_count DESC

