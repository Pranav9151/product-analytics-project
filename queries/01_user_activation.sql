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



