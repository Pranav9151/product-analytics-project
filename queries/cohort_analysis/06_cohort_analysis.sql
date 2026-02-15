-- DAY 6: Cohort Analysis

-- Step 1 – Build User Cohorts-------------------------------------------------------

WITH user_cohort AS (
    SELECT
        user_id,
        DATE_TRUNC('month', MIN(event_time)) AS cohort_month
    FROM events_raw
    GROUP BY user_id
)
SELECT * FROM user_cohort LIMIT 100;


-- Step 2 – User Activity by Month------------------------------------------------------

WITH user_cohort AS (
    SELECT
        user_id,
        DATE_TRUNC('month', MIN(event_time)) AS cohort_month
    FROM events_raw
    GROUP BY user_id
),

user_activity AS (
    SELECT
        user_id,
        DATE_TRUNC('month', event_time) AS activity_month
    FROM events_raw
    GROUP BY user_id, DATE_TRUNC('month', event_time)
)

SELECT * FROM user_activity LIMIT 100;

-- Step 3 – Combine Cohort and Activity------------------------------------------------------

WITH user_cohort AS (
    SELECT
        user_id,
        DATE_TRUNC('month', MIN(event_time)) AS cohort_month
    FROM events_raw
    GROUP BY user_id
),

user_activity AS (
    SELECT
        user_id,
        DATE_TRUNC('month', event_time) AS activity_month
    FROM events_raw
    GROUP BY user_id, DATE_TRUNC('month', event_time)
),

cohort_activity AS (
    SELECT
        c.cohort_month,
        a.activity_month,
        COUNT(DISTINCT c.user_id) AS active_users
    FROM user_cohort c
    JOIN user_activity a
        ON c.user_id = a.user_id
    GROUP BY c.cohort_month, a.activity_month
)

SELECT
    cohort_month,
    activity_month,
    active_users
FROM cohort_activity
ORDER BY cohort_month, activity_month;


-- Step 4 – Add Month Number for Retention View

WITH user_cohort AS (
    SELECT
        user_id,
        DATE_TRUNC('month', MIN(event_time)) AS cohort_month
    FROM events_raw
    GROUP BY user_id
),

user_activity AS (
    SELECT
        user_id,
        DATE_TRUNC('month', event_time) AS activity_month
    FROM events_raw
    GROUP BY user_id, DATE_TRUNC('month', event_time)
),

cohort_activity AS (
    SELECT
        c.cohort_month,
        a.activity_month,
        COUNT(DISTINCT c.user_id) AS active_users
    FROM user_cohort c
    JOIN user_activity a
        ON c.user_id = a.user_id
    GROUP BY c.cohort_month, a.activity_month
)

SELECT
    cohort_month,
    activity_month,

    (EXTRACT(YEAR FROM activity_month) - EXTRACT(YEAR FROM cohort_month)) * 12 +
    (EXTRACT(MONTH FROM activity_month) - EXTRACT(MONTH FROM cohort_month)) 
        AS month_number,

    active_users

FROM cohort_activity
ORDER BY cohort_month, month_number;
