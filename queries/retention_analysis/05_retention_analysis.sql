-- DAY 5: Retention Analysis

WITH user_first_activity AS (
    SELECT
        user_id,
        MIN(DATE(event_time)) AS first_date
    FROM events_raw
    GROUP BY user_id
)

SELECT * FROM user_first_activity
LIMIT 100;


-------------------------------------------------------------------

WITH user_first_activity AS (
    SELECT
        user_id,
        MIN(DATE(event_time)) AS first_date
    FROM events_raw
    GROUP BY user_id
),

daily_activity AS (
    SELECT
        user_id,
        DATE(event_time) AS activity_date
    FROM events_raw
    GROUP BY user_id, DATE(event_time)
)

SELECT
    f.first_date,
    COUNT(DISTINCT f.user_id) AS new_users,
    COUNT(DISTINCT d.user_id) AS returning_users
FROM user_first_activity f
LEFT JOIN daily_activity d
    ON f.user_id = d.user_id
    AND d.activity_date > f.first_date
GROUP BY f.first_date
ORDER BY f.first_date;

------------------------------Day-1 Retention--------------------------------------


WITH user_first_activity AS (
    SELECT
        user_id,
        MIN(DATE(event_time)) AS first_date
    FROM events_raw
    GROUP BY user_id
),

next_day_activity AS (
    SELECT
        user_id,
        DATE(event_time) AS activity_date
    FROM events_raw
    GROUP BY user_id, DATE(event_time)
)

SELECT
    COUNT(DISTINCT f.user_id) AS total_new_users,

    COUNT(DISTINCT n.user_id) AS day1_return_users,

    ROUND(
        COUNT(DISTINCT n.user_id)::NUMERIC /
        COUNT(DISTINCT f.user_id) * 100, 2
    ) AS day1_retention_pct

FROM user_first_activity f
LEFT JOIN next_day_activity n
    ON f.user_id = n.user_id
    AND n.activity_date = f.first_date + INTERVAL '1 day';






