# 📊 Retail Data Pipeline: Cloud Analytics & ML on BigQuery

This project demonstrates a production-grade data pipeline that automates the ingestion, transformation, and analysis of retail transaction data. It moves data from a synthetic Python-based "source" into Google BigQuery, applies data modeling best practices, and delivers predictive insights via BigQuery ML.

----
## 🛠️ Tech Stack
- Ingestion: Python (Pandas, Faker API)

- Data Warehouse: Google BigQuery

- Transformation: SQL (DDL, DML, MERGE statements)

- Predictive Analytics: BigQuery ML (Logistic Regression / Time-Series)

- Visualization: Power BI (DirectQuery connection)

----
## 🏗️ Data Architecture
1. Bronze Layer (Raw): Landing zone for raw JSON/CSV data streamed via Python. Includes full history and ingestion timestamps.

2. Silver Layer (Cleaned): De-duplicated and validated data. SQL MERGE is used here to handle updates and inserts (Upserts).

3. Gold Layer (Business Ready): Final reporting layer. Features "Nested and Repeated" fields for optimized querying of transaction line items.

4. ML Layer: Logistic Regression model predicting customer lifetime value.

----
## 🚀 Project Phases
**Phase 1: Automated Ingestion**
- A Python script generates synthetic retail data (orders, customers, stores) and streams it directly to BigQuery using the google-cloud-bigquery library.

**Phase 2: SQL Modeling & Deduplication**
- Implemented a robust MERGE logic to ensure the Silver layer remains the "Single Source of Truth."

- Partitioning: Tables are partitioned by transaction_date to optimize cost and performance.

- Clustering: Clustered by store_id for faster filtering in regional reports.

**Phase 3: Machine Learning (Predictive Analytics)**
- Using only SQL, I trained a BigQuery ML model to predict customer churn risk based on purchasing frequency and total spend.

**Phase 4: Interactive Dashboard**
Connected **Power BI** to the Gold layer to visualize:
- Real-time sales performance vs. Forecast.
- Customer segment health (using ML churn scores).
- Store-level inventory alerts.
----

## 🔒 Security & Architecture: BigQuery + Power BI Integration
Rather than using a personal user login, this project implements a Service Account architecture to manage data flow between the Google Cloud Gold Layer and the Power BI Desktop environment.

### 🏛️ Architecture Overview
- **Data Source:** BigQuery View (retail_gold.v_executive_summary)

- **Connection Method:** Power BI BigQuery Connector (Import Mode)

- **Authentication:** JSON Service Account Key

- **Permissions (IAM):**

    - BigQuery Data Viewer: Ability to read the view's schema and data.

    - BigQuery Job User: Ability to execute the SQL queries required to refresh the report.

### 🛡️ Why This Matters
1. **Non-Interactive Refresh:** By using a Service Account, the dashboard can be updated in the Power BI Service without requiring a user to be physically logged in or MFA-challenged.

2. **Credential Isolation:** The project code includes a .gitignore to prevent the key.json from ever being pushed to public repositories, ensuring that project secrets are never exposed.

3. **Governance:** Permissions are restricted only to the retail_gold dataset, following the Principle of Least Privilege.

----

## 🧭 Dashboard User Guide: Executive Insights
The Retail Gold Dashboard is designed for Store Managers and Executives to identify high-value opportunities at a glance.

1. **Identifying "VIP Potential" (Growth)**
    - Visual: Scatter Chart (Revenue vs. AI Probability)

    - How to use: Focus on the bottom-right quadrant. These are customers with a high AI Confidence Score but low current spend.
 
    - Action: Export this list for a targeted "VIP Welcome" email campaign.

2. **Monitoring Regional Performance**
    - Visual: Map / Slicer (State/Store Type)

    - How to use: Select "NSW" or "Suburban" from the slicers.

    - Action: Observe if the AI Confidence Score drops. A lower confidence score in specific regions suggests those stores need a different marketing strategy.

3. **Understanding Value Drivers**
    - Visual: Key Influencers AI Visual

    - How to use: Click on "What influences Predicted_is_High_Value to be 1".

    - Action: This reveals which store types or locations are most likely to breed high-value customers, guiding future store expansion plans.

----

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

