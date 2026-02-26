-- STEP 1 – Create Materialized View-----------------------------------------------------------

CREATE MATERIALIZED VIEW mv_daily_product_metrics AS
SELECT
event_date,
product_id,
COUNT(*) FILTER (WHERE event_type = 'view') AS views,
COUNT(*) FILTER (WHERE event_type = 'cart') AS carts,
COUNT(*) FILTER (WHERE event_type = 'purchase') AS purchases,
SUM(CASE WHEN event_type = 'purchase' THEN price ELSE 0 END) AS revenue
FROM fact_events
GROUP BY event_date, product_id;

-- STEP 2 – Add Index (VERY IMPORTANT)-----------------------------------------------------------

CREATE INDEX idx_mv_product_date
ON mv_daily_product_metrics (event_date, product_id);

-- STEP 3 – Query It (Lightning Fast ⚡)-----------------------------------------------------------

SELECT *
FROM mv_daily_product_metrics
ORDER BY revenue DESC
LIMIT 10;

-- STEP 4 – Refresh Strategy-----------------------------------------------------------------------

REFRESH MATERIALIZED VIEW mv_daily_product_metrics;