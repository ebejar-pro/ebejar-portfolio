# 🛒 End-to-End Retail Sales Performance Analysis

## 📄 Executive Summary
This project analyzes sales data for a global retail company to optimize supply chain decisions and restructure employee incentive programs. 

**The Goal:** Move from raw transactional data to actionable business intelligence.

Using an end-to-end data pipeline, I extracted over 50k records using **PostgreSQL**, performed customer segmentation using **Python**, and visualized revenue/latency KPIs in **Power BI**.

## 🛠️ Tech Stack & Methods
* **SQL (PostgreSQL):** Complex Joins, CTEs, Stored Procedures, Window Functions.
* **Python (Pandas/Matplotlib):** Data cleaning, anomaly detection, customer segmentation.
* **Power BI:** DAX (Time Intelligence), Interactive Dashboards, Map Visuals.
* **Modeling:** Star Schema design.

---

## 🔍 Key Business Insights (Preview)
*(Insert screenshots of your Power BI Dashboard here)*

* **Supply Chain:** Identified that 20% of suppliers in [Region] account for 80% of shipping delays.
* **Employee Performance:** The new commission logic (implemented via Stored Procedure) saved 15% in overpaid incentives by correctly handling outliers.
* **Customer Demographics:** "Age 25-35" segment drives the highest volume, but "Age 45+" drives the highest margin.

---

## 📂 Project Structure
This project follows the data lifecycle:

### Phase 1: Data Extraction & Logic (PostgreSQL)
* **Objective:** To design a robust data warehouse and automate critical business processes (like commission calculation).
* **Key Deliverables:** 
    1.  **Schema Design:** Created 6 tables (Fact/Dimension) with comprehensive integrity checks (PKs, FKs).
    2.  **Process Automation:** Implemented the **`record_sale_commission` Stored Procedure and Trigger** to handle commission payouts  in real-time.
    3.  **Data Generation:** Wrote procedural SQL to populate 200+ sales and 40+ customers, ensuring data quality for analysis.
    4.  **Reporting View:** Created `vw_sales_summary` to provide a flattened view for Power BI consumption.

    👉 **[View Detailed Data Engineering Process Documentation Here](./01_SQL_Extraction/Data_Engineering_Process.md)**
### Phase 2: Exploratory Analysis (Python)
* **Challenge:** Needed to group customers by purchasing behavior, which is difficult in pure SQL.
* **Solution:** Used Python Pandas to create "Spending Buckets" and identified null values in the `contact_email` field.
* **See Notebook:** [Customer_Segmentation.ipynb](./02_Python_Analysis/notebooks)

### Phase 3: Reporting (Power BI)
* **Metrics Created:**
    * `Average Fulfillment Latency` = AVERAGE(DispatchDate - SaleDate)
    * `MoM Growth %`
* **See Dashboard:** [Retail_Dashboard.pbix](./03_PowerBI_Reporting/dashboards)

---

## 🚀 How to Run
1.  **Database:** Restore the `.backup` file located in `/data/raw` to PostgreSQL.
2.  **Python:** Run `pip install -r requirements.txt` and launch the Jupyter Notebook.
3.  **Power BI:** Open the `.pbix` file. *Note: You may need to update the data source credentials.*

## 👤 Author
**Edmundo Bejar** - Data Analyst & Test Analyst  
(https://www.linkedin.com/in/edmundo-bejar-3400691b) | (https://github.com/ebejar-pro)