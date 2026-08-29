{{ config(
    materialized='table'
) }}

WITH finance AS (

    SELECT *
    FROM {{ ref('finance_days') }}

),

campaigns AS (

    SELECT *
    FROM {{ ref('int_campaigns_day') }}

)

SELECT
    finance.date_date AS date,
    COALESCE(finance.operational_margin, 0)
        - COALESCE(campaigns.ads_cost, 0) AS ads_margin,
    finance.average_basket,
    finance.operational_margin,
    COALESCE(campaigns.ads_cost, 0) AS ads_cost,
    COALESCE(campaigns.ads_impression, 0) AS ads_impression,
    COALESCE(campaigns.ads_clicks, 0) AS ads_clicks,
    finance.quantity,
    finance.revenue,
    finance.purchase_cost,
    finance.margin,
    finance.shipping_fee,
    finance.logcost,
    finance.ship_cost
FROM finance
LEFT JOIN campaigns
    ON finance.date_date = campaigns.date_date
ORDER BY finance.date_date DESC