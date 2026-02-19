-- DAY 9: Growth Metrics

SELECT
    DATE(event_time) AS activity_date,
    COUNT(DISTINCT user_id) AS dau
FROM events_raw
GROUP BY DATE(event_time)
ORDER BY activity_date;
