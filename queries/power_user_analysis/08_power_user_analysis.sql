-- DAY 8: Power User Analysis

WITH user_metrics AS (
    SELECT
        user_id,

        COUNT(*) AS total_events,

        COUNT(DISTINCT user_session) AS total_sessions,

        SUM(CASE WHEN event_type = 'purchase' THEN price ELSE 0 END) AS total_revenue,

        SUM(CASE WHEN event_type = 'purchase' THEN 1 ELSE 0 END) AS total_purchases

    FROM events_raw
    GROUP BY user_id
)

SELECT * FROM user_metrics
ORDER BY total_revenue DESC
LIMIT 100;


-- STEP 2 – Define Power Users (Revenue Based) -----------------------------

WITH user_metrics AS (
    SELECT
        user_id,
        SUM(CASE WHEN event_type = 'purchase' THEN price ELSE 0 END) AS total_revenue
    FROM events_raw
    GROUP BY user_id
)

SELECT
    user_id,
    total_revenue
FROM user_metrics
WHERE total_revenue > (
    SELECT PERCENTILE_CONT(0.90) 
    WITHIN GROUP (ORDER BY total_revenue)
    FROM user_metrics
)
ORDER BY total_revenue DESC;



