-- DAY 9: Growth Metrics

SELECT
    DATE(event_time) AS activity_date,
    COUNT(DISTINCT user_id) AS dau
FROM events_raw
GROUP BY DATE(event_time)
ORDER BY activity_date;

-- STEP 2 – Weekly Active Users (WAU) -----------------------------

SELECT
    DATE_TRUNC('month', event_time) AS activity_month,
    COUNT(DISTINCT user_id) AS mau
FROM events_raw
GROUP BY DATE_TRUNC('month', event_time)
ORDER BY activity_month;


-- STEP 3 – Stickiness (DAU / MAU) -----------------------------

WITH daily_users AS (
    SELECT
        DATE(event_time) AS activity_date,
        COUNT(DISTINCT user_id) AS dau
    FROM events_raw
    GROUP BY DATE(event_time)
),

monthly_users AS (
    SELECT
        DATE_TRUNC('month', event_time) AS activity_month,
        COUNT(DISTINCT user_id) AS mau
    FROM events_raw
    GROUP BY DATE_TRUNC('month', event_time)
)

SELECT
    d.activity_date,
    d.dau,
    m.mau,
    ROUND(d.dau::NUMERIC / m.mau * 100, 2) AS stickiness_pct
FROM daily_users d
JOIN monthly_users m
    ON DATE_TRUNC('month', d.activity_date) = m.activity_month
ORDER BY d.activity_date;



