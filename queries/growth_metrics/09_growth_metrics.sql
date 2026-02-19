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



