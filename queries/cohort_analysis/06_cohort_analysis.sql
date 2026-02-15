-- DAY 6: Cohort Analysis

WITH user_cohort AS (
    SELECT
        user_id,
        DATE_TRUNC('month', MIN(event_time)) AS cohort_month
    FROM events_raw
    GROUP BY user_id
)
SELECT * FROM user_cohort LIMIT 100;
