-- DAY 11: Window Functions & Ranking

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



