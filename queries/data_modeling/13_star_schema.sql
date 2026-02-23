-- STEP 1 – Create Date Dimension---------------------------------

-- Create Date Dimension

CREATE TABLE dim_date AS
SELECT DISTINCT
    DATE(event_time) AS full_date,
    EXTRACT(YEAR FROM event_time) AS year,
    EXTRACT(MONTH FROM event_time) AS month,
    EXTRACT(DAY FROM event_time) AS day
FROM events_raw;

CREATE INDEX idx_dim_date_full_date
ON dim_date(full_date);


