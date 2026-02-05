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



