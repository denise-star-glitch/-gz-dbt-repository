WITH campaigns AS (

    SELECT *
    FROM {{ ref('int_campaigns') }}

),daily_campaigns AS (

    SELECT
        date_date,
        SUM(ads_cost) AS ads_cost,
        SUM(impression) AS ads_impression,
        SUM(click) AS ads_clicks
    FROM campaigns
    GROUP BY date_date

)

SELECT
    date_date,
    ads_cost,
    ads_impression,
    ads_clicks
FROM daily_campaigns
ORDER BY date_date DESC