-- 1 – Create Daily Metrics Table------------------------

-- DAY 12: Create Aggregated Daily Metrics Table

CREATE TABLE daily_metrics AS

SELECT
    DATE(event_time) AS metric_date,

    COUNT(*) AS total_events,

    COUNT(DISTINCT user_id) AS total_users,

    COUNT(DISTINCT user_session) AS total_sessions,

    SUM(CASE WHEN event_type = 'view' THEN 1 ELSE 0 END) AS total_views,

    SUM(CASE WHEN event_type = 'cart' THEN 1 ELSE 0 END) AS total_carts,

    SUM(CASE WHEN event_type = 'purchase' THEN 1 ELSE 0 END) AS total_purchases,

    SUM(CASE WHEN event_type = 'purchase' THEN price ELSE 0 END) AS total_revenue

FROM events_raw
GROUP BY DATE(event_time);

