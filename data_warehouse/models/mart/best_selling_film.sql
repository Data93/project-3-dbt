{{ config(
    materialized="table",
    schema="mart"
) }}


WITH rental_data AS (
    SELECT
        f.title AS movie_title,
        COUNT(r.rental_id) AS total_rentals
    FROM
        {{ ref('dim_rental') }} r
    JOIN
        {{ ref('dim_inventory') }} i ON r.inventory_id = i.inventory_id
    JOIN
        {{ ref('dim_film') }} f ON i.film_id = f.film_id
    GROUP BY
        f.title
)

SELECT
    movie_title,
    total_rentals
FROM
    rental_data
ORDER BY
    total_rentals DESC
