import functions_framework
from google.cloud import bigquery

@functions_framework.http
def predict_fire_risk(request):
    """
    Final Winning Version:
    - Correctly initializes the client inside the function.
    - Creates the same smart features the model was trained on.
    - Points to the final production model.
    """
    headers = {'Access-Control-Allow-Origin': '*'}
    if request.method == 'OPTIONS':
        cors_headers = {
            'Access-Control-Allow-Origin': '*',
            'Access-Control-Allow-Methods': 'POST',
            'Access-Control-Allow-Headers': 'Content-Type',
            'Access-Control-Max-Age': '3600'
        }
        return ('', 204, cors_headers)

    client = bigquery.Client()

    # Validate the incoming request
    request_json = request.get_json(silent=True)
    if not request_json or 'latitude' not in request_json or 'longitude' not in request_json or 'month' not in request_json:
        return ({"error": "Invalid request. Please provide 'latitude', 'longitude', and 'month'."}, 400, headers)

    # Extract data from the request
    lat = request_json['latitude']
    lon = request_json['longitude']
    month = request_json['month']

    # creates the smart grid cell for the prediction
    # and points to the final production model.
    sql_query = f"""
    SELECT
      predicted_fire_detected,
      predicted_fire_detected_probs[OFFSET(1)].prob AS probability_fire
    FROM
      ML.PREDICT(MODEL `nexus-firewatch.nexus_firewatch_data.fire_model_production`,
        (
          SELECT
            CAST(FLOOR({lat} * 10) AS INT64) as lat_grid,
            CAST(FLOOR({lon} * 10) AS INT64) as lon_grid,
            {month} AS acq_month
        ));
    """

    try:
        query_job = client.query(sql_query)
        results = query_job.result()
        for row in results:
            prediction = {
                "predicted_label": row.predicted_fire_detected,
                "probability_fire": row.probability_fire
            }
            return (prediction, 200, headers)
    except Exception as e:
        return ({"error": str(e)}, 500, headers)

    return ({"error": "No prediction result returned from the model."}, 500, headers)