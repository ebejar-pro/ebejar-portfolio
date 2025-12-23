-- Predict High Value Customers
-- This query predicts high value customers using a pre-trained machine learning model.
SELECT
  customer_id,
  predicted_is_high_value,
  -- Extracting the probability of the '1' (High Value) label
  predicted_is_high_value_probs[OFFSET(1)].prob as probability_high_value,
  total_spend,
  total_transactions
FROM
  ML.PREDICT(MODEL `bq-analysis-04.retail_silver.customer_value_model`,
    (
    SELECT
      customer_id,
      store_id,
      SUM(total_amount) as total_spend,
      COUNT(transaction_id) as total_transactions
    FROM
      `bq-analysis-04.retail_silver.sales_fact`
    GROUP BY
      customer_id, store_id
    ))
ORDER BY probability_high_value DESC;
