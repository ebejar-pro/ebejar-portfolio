-- Create or update the Silver table
CREATE OR REPLACE TABLE `bq-analysis-04.retail_silver.sales_fact`
PARTITION BY DATE(transaction_timestamp)
CLUSTER BY store_id, customer_id
AS
WITH base_data AS (
  SELECT 
    *,
    -- Identify the most recent record for each transaction ID
    ROW_NUMBER() OVER(
      PARTITION BY transaction_id 
      ORDER BY transaction_timestamp DESC
    ) as record_rank
  FROM `bq-analysis-04.retail_bronze.raw_sales`
)
SELECT
  transaction_id,
  -- Cast strings to proper Timestamps
  TIMESTAMP(transaction_timestamp) as transaction_timestamp,
  CAST(store_id AS INT64) as store_id,
  customer_id,
  CAST(total_amount AS FLOAT64) as total_amount
FROM base_data
WHERE record_rank = 1; -- Only keep the unique/latest record