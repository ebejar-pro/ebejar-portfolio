📖 Data Dictionary: v_executive_summary
This view serves as the Gold Layer source for the Power BI dashboard, combining raw transactional data with Machine Learning predictions.

| Field Name       | Data Type | Description                                              | Example                  |
|------------------|-----------|----------------------------------------------------------|--------------------------|
| transaction_id   | STRING    | Unique identifier for each retail sale.                 | TXN-992834               |
| transaction_dt   | TIMESTAMP | The exact date and time the purchase occurred.          | 2025-12-20 14:00:00      |
| customer_id      | STRING    | Unique ID for the shopper (Primary Key for CRM).        | CUST_774                 |
| revenue          | FLOAT64   | Total transaction value in AUD after discounts.         | 154.50                   |
| store_name       | STRING    | The name of the physical retail location.               | North Kellyville Plaza   |
| state            | STRING    | Australian state where the store is located.            | NSW                      |
| store_type       | STRING    | Categorization of the store size/format.                | Flagship                 |
| is_high_value    | INT64     | (ML Prediction) 1 = High Value, 0 = Standard.           | 1                        |
| high_value_prob  | FLOAT64   | (ML Probability) Confidence score (0.0–1.0).            | 0.89                     |
| segment          | STRING    | (ML Cluster) Customer group based on behavior.          | Frequent Buyer           |