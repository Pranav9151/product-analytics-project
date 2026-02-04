WITH session_metrics AS (
    SELECT
        user_session,

        MIN(event_time) AS session_start,
        MAX(event_time) AS session_end,

        COUNT(*) AS total_events,

        SUM(CASE WHEN event_type = 'view' THEN 1 ELSE 0 END) AS views,
        SUM(CASE WHEN event_type = 'cart' THEN 1 ELSE 0 END) AS carts,
        SUM(CASE WHEN event_type = 'purchase' THEN 1 ELSE 0 END) AS purchases

    FROM events_raw
    GROUP BY user_session
)

SELECT
    COUNT(*) AS total_sessions,

    AVG(total_events) AS avg_events_per_session,

    AVG(EXTRACT(EPOCH FROM (session_end - session_start))/60) 
        AS avg_session_duration_minutes,

    SUM(CASE WHEN purchases > 0 THEN 1 ELSE 0 END) AS purchase_sessions

FROM session_metrics;
