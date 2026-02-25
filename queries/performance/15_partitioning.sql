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

