-- DAY 10: Category Adoption Analysis

SELECT
    category_code,

    COUNT(*) AS total_events,

    SUM(CASE WHEN event_type = 'view' THEN 1 ELSE 0 END) AS total_views,

    SUM(CASE WHEN event_type = 'cart' THEN 1 ELSE 0 END) AS total_carts,

    SUM(CASE WHEN event_type = 'purchase' THEN 1 ELSE 0 END) AS total_purchases,

    SUM(CASE WHEN event_type = 'purchase' THEN price ELSE 0 END) AS total_revenue

FROM events_raw
GROUP BY category_code
ORDER BY total_revenue DESC;


-- STEP 2 – Category Conversion Rate

WITH category_metrics AS (
    SELECT
        category_code,

        SUM(CASE WHEN event_type = 'view' THEN 1 ELSE 0 END) AS views,

        SUM(CASE WHEN event_type = 'purchase' THEN 1 ELSE 0 END) AS purchases

    FROM events_raw
    GROUP BY category_code
)

SELECT
    category_code,
    views,
    purchases,

    ROUND(purchases::NUMERIC / NULLIF(views, 0) * 100, 2) AS conversion_pct

FROM category_metrics
ORDER BY conversion_pct DESC;

-- STEP 3 – Brand Revenue Leaders

SELECT
    brand,

    SUM(CASE WHEN event_type = 'purchase' THEN price ELSE 0 END) AS total_revenue,

    SUM(CASE WHEN event_type = 'purchase' THEN 1 ELSE 0 END) AS total_purchases

FROM events_raw
GROUP BY brand
ORDER BY total_revenue DESC
LIMIT 20;