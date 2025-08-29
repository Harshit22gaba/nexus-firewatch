-- This query creates the final, intelligent production model.
-- It uses a powerful BOOSTED_TREE_CLASSIFIER and is trained on
-- smart, engineered "grid cell" features for higher accuracy.

CREATE OR REPLACE MODEL `nexus-firewatch.nexus_firewatch_data.fire_model_production`
OPTIONS(
    model_type='BOOSTED_TREE_CLASSIFIER',
    input_label_cols=['fire_detected']
) AS
-- Create a subquery to generate our smart "grid cell" features
WITH training_data_with_features AS (
  SELECT
    -- This is the key: we create regional cells instead of using raw coordinates.
    CAST(FLOOR(latitude * 10) AS INT64) as lat_grid,
    CAST(FLOOR(longitude * 10) AS INT64) as lon_grid,
    acq_month,
    fire_detected
  FROM
    `nexus-firewatch.nexus_firewatch_data.fire_training_data`
)
-- Select the new smart features to train the model
SELECT
  *
FROM
  training_data_with_features;
