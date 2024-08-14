{{ config(
    materialized="table",
    schema="mart"
) }}

SELECT
    sum(amount) as total_revenue,
    payment_date
FROM {{ ref('fact_payment') }}
GROUP BY payment_date