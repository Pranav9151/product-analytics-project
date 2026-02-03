-- DAY 3: Daily Conversion Trends

WITH daily_events AS (
    SELECT
        DATE(event_time) AS event_date,

        SUM(CASE WHEN event_type = 'view' THEN 1 ELSE 0 END) AS views,
        SUM(CASE WHEN event_type = 'cart' THEN 1 ELSE 0 END) AS carts,
        SUM(CASE WHEN event_type = 'purchase' THEN 1 ELSE 0 END) AS purchases

    FROM events_raw
    GROUP BY DATE(event_time)
)

SELECT
    event_date,
    views,
    carts,
    purchases,

    ROUND(carts::NUMERIC / NULLIF(views, 0) * 100, 2) AS view_to_cart_pct,

    ROUND(purchases::NUMERIC / NULLIF(carts, 0) * 100, 2) AS cart_to_purchase_pct,

    ROUND(purchases::NUMERIC / NULLIF(views, 0) * 100, 2) AS view_to_purchase_pct

FROM daily_events
ORDER BY event_date;
