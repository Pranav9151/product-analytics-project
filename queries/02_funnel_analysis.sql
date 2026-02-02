-- DAY 2: Funnel Analysis (User-level)

WITH user_funnel AS (
    SELECT
        user_id,
        MAX(CASE WHEN event_type = 'view' THEN 1 ELSE 0 END) AS did_view,
        MAX(CASE WHEN event_type = 'cart' THEN 1 ELSE 0 END) AS did_cart,
        MAX(CASE WHEN event_type = 'purchase' THEN 1 ELSE 0 END) AS did_purchase
    FROM events_raw
    GROUP BY user_id
),

funnel_counts AS (
    SELECT
        SUM(CASE WHEN did_view = 1 THEN 1 ELSE 0 END) AS view_users,
        SUM(CASE WHEN did_cart = 1 THEN 1 ELSE 0 END) AS cart_users,
        SUM(CASE WHEN did_purchase = 1 THEN 1 ELSE 0 END) AS purchase_users
    FROM user_funnel
)

SELECT
    view_users,
    cart_users,
    purchase_users,
    ROUND(cart_users::NUMERIC / view_users * 100, 2) AS view_to_cart_pct,
    ROUND(purchase_users::NUMERIC / cart_users * 100, 2) AS cart_to_purchase_pct,
    ROUND(purchase_users::NUMERIC / view_users * 100, 2) AS view_to_purchase_pct
FROM funnel_counts;

