-- Total rows
SELECT COUNT(*) AS total_events
FROM events_raw;

-- Distinct users
SELECT COUNT(DISTINCT user_id) AS total_users
FROM events_raw;

-- Distinct sessions
SELECT COUNT(DISTINCT user_session) AS total_sessions
FROM events_raw;

-- Event type distribution
SELECT
    event_type,
    COUNT(*) AS event_count
FROM events_raw
GROUP BY event_type
ORDER BY event_count DESC;

---Time range & daily activities----

-- Time range
SELECT
    MIN(event_time) AS start_time,
    MAX(event_time) AS end_time
FROM events_raw;

-- Events per day
SELECT
    DATE(event_time) AS event_date,
    COUNT(*) AS events_per_day
FROM events_raw
GROUP BY DATE(event_time)
ORDER BY event_date;

--NULL values check

-- Null checks for key fields
SELECT
    SUM(CASE WHEN user_id IS NULL THEN 1 ELSE 0 END) AS null_user_id,
    SUM(CASE WHEN user_session IS NULL THEN 1 ELSE 0 END) AS null_user_session,
    SUM(CASE WHEN event_type IS NULL THEN 1 ELSE 0 END) AS null_event_type,
    SUM(CASE WHEN event_type = 'purchase' AND price IS NULL THEN 1 ELSE 0 END) AS null_purchase_price
FROM events_raw;


-- Events per session distribution
SELECT
    MIN(event_count) AS min_events_per_session,
    MAX(event_count) AS max_events_per_session,
    CAST(AVG(event_count) AS INTEGER) AS avg_events_per_session
FROM (
    SELECT
        user_session,
        COUNT(*) AS event_count
    FROM events_raw
    GROUP BY user_session
) AS session_events;


-- Sessions with single event
SELECT
    COUNT(*) AS single_event_sessions
FROM (
    SELECT
        user_session
    FROM events_raw
    GROUP BY user_session
    HAVING COUNT(*) = 1
) AS single_sessions;


 



