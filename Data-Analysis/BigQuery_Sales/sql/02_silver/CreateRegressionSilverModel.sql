-- Create a Logistic Regression model to predict High Value Customers.
-- Use a Window Function to label the top 20% of spenders as "High Value
CREATE OR REPLACE MODEL `bq-analysis-04.retail_silver.customer_value_model`
OPTIONS(model_type='logistic_reg', input_label_cols=['is_high_value']) AS
WITH aggregated_spend AS (
  SELECT
    customer_id,
    store_id,
    SUM(total_amount) as total_spend,
    COUNT(transaction_id) as total_transactions
  FROM `bq-analysis-04.retail_silver.sales_fact`
  GROUP BY customer_id, store_id
),
labeled_data AS (
  SELECT 
    *,
    -- Use NTILE to split data into 5 buckets; bucket 1 is the top 20%
    IF(NTILE(5) OVER(ORDER BY total_spend DESC) = 1, 1, 0) as is_high_value
  FROM aggregated_spend
)
SELECT * FROM labeled_data;
