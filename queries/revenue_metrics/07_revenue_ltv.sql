-- DAY 7: Revenue & LTV Analysis 

SELECT
    SUM(price) AS total_revenue
FROM events_raw
WHERE event_type = 'purchase';

-- STEP 2 – Daily Revenue--------------------------------------------------------

SELECT
    DATE(event_time) AS revenue_date,
    SUM(price) AS daily_revenue
FROM events_raw
WHERE event_type = 'purchase'
GROUP BY DATE(event_time)
ORDER BY revenue_date;

-- STEP 3 – Revenue Per User (User LTV Base) -------------------------------------------------------

WITH user_revenue AS (
    SELECT
        user_id,
        SUM(price) AS user_total_revenue
    FROM events_raw
    WHERE event_type = 'purchase'
    GROUP BY user_id
)

SELECT
    COUNT(*) AS paying_users,
    AVG(user_total_revenue) AS avg_revenue_per_paying_user,
    SUM(user_total_revenue) AS total_revenue
FROM user_revenue;

-- STEP 4 – Basic ARPU (All Users) -------------------------------------------------------

WITH total_users AS (
    SELECT COUNT(DISTINCT user_id) AS users
    FROM events_raw
),

total_revenue AS (
    SELECT SUM(price) AS revenue
    FROM events_raw
    WHERE event_type = 'purchase'
)

SELECT
    revenue,
    users,
    revenue / users AS arpu
FROM total_users, total_revenue;

-- STEP 5 – Customer Lifetime Value (Simple Version)---------------------------------------------

WITH user_revenue AS (
    SELECT
        user_id,
        SUM(price) AS lifetime_value
    FROM events_raw
    WHERE event_type = 'purchase'
    GROUP BY user_id
)

SELECT
    MIN(lifetime_value) AS min_ltv,
    MAX(lifetime_value) AS max_ltv,
    AVG(lifetime_value) AS avg_ltv
FROM user_revenue;



