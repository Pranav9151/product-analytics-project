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

-- STEP 2 – Create User Dimension---------------------------------

CREATE TABLE dim_users AS
SELECT DISTINCT
    user_id
FROM events_raw;

CREATE INDEX idx_dim_users_id
ON dim_users(user_id);


-- STEP 3 – Create Product Dimension---------------------------------

CREATE TABLE dim_product AS
SELECT DISTINCT
    product_id,
    category_code,
    brand
FROM events_raw;

CREATE INDEX idx_dim_product_id
ON dim_product(product_id);

-- STEP 4 – Create Session Dimension---------------------------------

CREATE TABLE dim_session AS
SELECT DISTINCT
    user_session,
    user_id
FROM events_raw;

CREATE INDEX idx_dim_session_id
ON dim_session(user_session);

-- STEP 5 – Create Fact Table---------------------------------

CREATE TABLE fact_events AS
SELECT
    user_id,
    user_session,
    product_id,
    DATE(event_time) AS event_date,
    event_type,
    price
FROM events_raw;

CREATE INDEX idx_fact_user
ON fact_events(user_id);

CREATE INDEX idx_fact_date
ON fact_events(event_date);

CREATE INDEX idx_fact_product
ON fact_events(product_id);


