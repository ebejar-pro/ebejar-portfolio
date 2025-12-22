# 📊 Retail Data Engineering & ML Pipeline
##   Tools: Python, Google BigQuery, BigQuery ML, Power BI

## Architecture: Medallion (Bronze, Silver, Gold)

# 🏗️ Project Architecture
## Bronze Layer: Raw synthetic sales data uploaded via Python.

## Silver Layer: Cleaned and deduplicated tables partitioned by date.

## Gold Layer: Business-ready views joined with Store and Product metadata.

## ML Layer: Logistic Regression model predicting customer lifetime value.

# 🚀 How to Run
## Run upload_sales.py to push raw data to BigQuery.

# Execute transformations.sql to build the Silver and Gold layers.

## Open dashboard.pbix to view live insights.

graph LR
    A[Python Script] -->|ETL / Ingestion| B[(BigQuery)]
    B -->|BigQuery ML| C[Gold View: Executive Summary]
    C -->|Secure Service Account| D[Power BI Desktop]
    D -->|Data Visualization| E[Stakeholder Dashboard]

    style C fill:#f9f,stroke:#333,stroke-width:2px
    style B fill:#dfd,stroke:#333

