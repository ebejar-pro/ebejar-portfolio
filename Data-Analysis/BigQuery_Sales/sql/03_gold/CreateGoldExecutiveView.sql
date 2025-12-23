-- Create the Gold Executive View
CREATE OR REPLACE VIEW `bq-analysis-04.retail_gold.v_executive_summary` AS
WITH customer_predictions AS (
  SELECT
    customer_id,
    predicted_is_high_value,
    -- Probability of being High Value (label '1')
    predicted_is_high_value_probs[OFFSET(1)].prob as high_value_prob
  FROM
    ML.PREDICT(MODEL `bq-analysis-04.retail_silver.customer_value_model`,
      (SELECT customer_id, store_id, SUM(total_amount) as total_spend, COUNT(transaction_id) as total_transactions 
       FROM `bq-analysis-04.retail_silver.sales_fact` 
       GROUP BY customer_id, store_id))
)
SELECT 
    s.transaction_id,
    s.transaction_timestamp,
    s.customer_id,
    s.total_amount as revenue,
    st.store_name,
    st.state,
    st.store_type,
    p.predicted_is_high_value,
    p.high_value_prob,
    -- Flagging transactions from potential VIPs
    CASE WHEN p.high_value_prob > 0.85 THEN 'VIP Alert' ELSE 'Standard' END as customer_segment
FROM `bq-analysis-04.retail_silver.sales_fact` s
LEFT JOIN `bq-analysis-04.retail_silver.dim_stores` st ON s.store_id = st.store_id
LEFT JOIN customer_predictions p ON s.customer_id = p.customer_id;