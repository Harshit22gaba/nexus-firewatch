-- This query creates the balanced dataset used for model training.
-- It includes an equal number of positive (fire) and negative (no-fire) examples.
CREATE OR REPLACE TABLE `nexus-firewatch.nexus_firewatch_data.fire_training_data` AS (
  -- Select all the REAL fire data and label it '1'
  SELECT
    latitude,
    longitude,
    EXTRACT(MONTH FROM acq_date) AS acq_month, -- Extract the month
    confidence,
    1 AS fire_detected
  FROM
    `nexus-firewatch.nexus_firewatch_data.historical_fires`

  UNION ALL
  SELECT
    (RAND() * (60 - 30)) + 30 AS latitude,
    (RAND() * (-70 - (-120))) - 120 AS longitude,
    CAST(FLOOR(RAND() * 12) + 1 AS INT64) AS acq_month,
    0 AS confidence,
    0 AS fire_detected
  FROM
    `nexus-firewatch.nexus_firewatch_data.historical_fires`
);
