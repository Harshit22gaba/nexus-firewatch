-- This query is used to evaluate the performance of the trained production model.
-- The resulting 'accuracy' score is displayed on the frontend.
SELECT
  *
FROM
  ML.EVALUATE(MODEL `nexus-firewatch.nexus_firewatch_data.fire_model_production`)
