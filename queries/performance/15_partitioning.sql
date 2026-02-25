-- STEP 1 – Drop Old Fact Table (If Safe)------------------------------------------

DROP TABLE IF EXISTS fact_events CASCADE;

-- STEP 2 – Create Partitioned Parent Table ------------------------------------------

CREATE TABLE fact_events (
    user_id BIGINT,
    user_session TEXT,
    product_id BIGINT,
    event_date DATE,
    event_type TEXT,
    price NUMERIC
) PARTITION BY RANGE (event_date);

-- STEP 3- Create Year-Based Partitions---------------------------------------------------

CREATE TABLE fact_events_2023
PARTITION OF fact_events
FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

CREATE TABLE fact_events_2024
PARTITION OF fact_events
FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

-- STEP 4 – Insert Data From events_raw----------------------------------------------------------

INSERT INTO fact_events
SELECT
    user_id,
    user_session,
    product_id,
    DATE(event_time),
    event_type,
    price
FROM events_raw;

-- STEP 5 - Add Indexes on Partitions----------------------------------------------------------

CREATE INDEX idx_fact_user_date
ON fact_events(user_id, event_date);

CREATE INDEX idx_fact_product
ON fact_events(product_id);