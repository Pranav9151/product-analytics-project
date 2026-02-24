-- STEP 1 – Measure Query Performance----------------------------------------------------------

-- Take one of your heavy queries (example: revenue by date):
EXPLAIN ANALYZE
SELECT
    event_date,
    SUM(price) AS total_revenue
FROM fact_events
GROUP BY event_date
ORDER BY event_date;

-- STEP 2 – Improve with Proper Indexing -------------------------------------------------------

-- If you frequently do:
##WHERE event_date = '2024-01-01'

-- Create an index on event_date:
CREATE INDEX idx_fact_event_date
ON fact_events(event_date);

-- Now re-run the query to see the improvement:
EXPLAIN ANALYZE
SELECT *
FROM fact_events
WHERE event_date = '2024-01-01';

-- STEP 3 – Composite Index (Very Important) --------------------------------------------------

-- If your queries often filter like this:
WHERE user_id = 101
AND event_date = '2024-01-01'

-- Instead of 2 separate indexes, use:
CREATE INDEX idx_fact_user_date
ON fact_events(user_id, event_date);

-- STEP 4 – COUNT Optimization -----------------------------------------------------------------

-- Instead of:
SELECT COUNT(*)
FROM fact_events;

-- Better:
SELECT reltuples::BIGINT AS approximate_count
FROM pg_class
WHERE relname = 'fact_events';

-- STEP 5 – Avoid SELECT * ----------------------------------------------------------------------

-- Bad:
SELECT *
FROM fact_events;

-- Good:
SELECT user_id, event_date, price
FROM fact_events;

-- STEP 6 – Use Aggregated Tables for Heavy Dashboards--------------------------------------------------    

-- If dashboard runs this daily:
SELECT
    event_date,
    SUM(price)
FROM fact_events
GROUP BY event_date;

-- Create pre-aggregated table:
CREATE TABLE daily_revenue AS
SELECT
    event_date,
    SUM(price) AS total_revenue
FROM fact_events
GROUP BY event_date;

-- Index it:
CREATE INDEX idx_daily_revenue_date
ON daily_revenue(event_date);

