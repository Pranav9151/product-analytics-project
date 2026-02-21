-- DAY 11: Window Functions & Ranking

-- 1️ Rank Users by Revenue------------------------

WITH user_revenue AS (
    SELECT
        user_id,
        SUM(CASE WHEN event_type = 'purchase' THEN price ELSE 0 END) AS total_revenue
    FROM events_raw
    GROUP BY user_id
)

SELECT
    user_id,
    total_revenue,

    RANK() OVER (ORDER BY total_revenue DESC) AS revenue_rank,

    DENSE_RANK() OVER (ORDER BY total_revenue DESC) AS dense_rank,

    ROW_NUMBER() OVER (ORDER BY total_revenue DESC) AS row_number_rank

FROM user_revenue
ORDER BY revenue_rank
LIMIT 50;

-- 2️ Cumulative Revenue Over Time------------------------

WITH daily_revenue AS (
    SELECT
        DATE(event_time) AS revenue_date,
        SUM(CASE WHEN event_type = 'purchase' THEN price ELSE 0 END) AS daily_revenue
    FROM events_raw
    GROUP BY DATE(event_time)
)

SELECT
    revenue_date,
    daily_revenue,

    SUM(daily_revenue) OVER (ORDER BY revenue_date) AS cumulative_revenue

FROM daily_revenue
ORDER BY revenue_date;

-- 3️ Day-over-Day Revenue Growth------------------------

WITH daily_revenue AS (
    SELECT
        DATE(event_time) AS revenue_date,
        SUM(CASE WHEN event_type = 'purchase' THEN price ELSE 0 END) AS daily_revenue
    FROM events_raw
    GROUP BY DATE(event_time)
)

SELECT
    revenue_date,
    daily_revenue,

    LAG(daily_revenue) OVER (ORDER BY revenue_date) AS previous_day_revenue,

    daily_revenue - LAG(daily_revenue) 
        OVER (ORDER BY revenue_date) AS revenue_change

FROM daily_revenue
ORDER BY revenue_date;

-- 4️ Top Users Per Month (Partition Example)------------------------

WITH monthly_user_revenue AS (
    SELECT
        DATE_TRUNC('month', event_time) AS revenue_month,
        user_id,
        SUM(CASE WHEN event_type = 'purchase' THEN price ELSE 0 END) AS total_revenue
    FROM events_raw
    GROUP BY DATE_TRUNC('month', event_time), user_id
)

SELECT
    revenue_month,
    user_id,
    total_revenue,

    RANK() OVER (
        PARTITION BY revenue_month
        ORDER BY total_revenue DESC
    ) AS monthly_rank

FROM monthly_user_revenue
ORDER BY revenue_month, monthly_rank;


