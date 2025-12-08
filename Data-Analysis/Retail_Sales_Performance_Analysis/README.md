# 🛒 End-to-End Retail Sales Performance Analysis

## 📄 Executive Summary
This project analyzes sales data for a global retail company to optimise supply chain decisions and restructure employee incentive programs. 

**The Goal:** Move from raw transactional data to actionable business intelligence.

Using an end-to-end data pipeline, I created synthetic data 
using **PostgreSQL**, performed customer segmentation using **Python**, and visualised revenue/latency KPIs in **Power BI**.

## 🛠️ Tech Stack & Methods
* **SQL (PostgreSQL):** Complex Joins, CTEs, Stored Procedures, Window Functions.
* **Python (Pandas/Matplotlib):** Data cleaning, anomaly detection, customer segmentation.
* **Power BI:** DAX (Time Intelligence), Interactive Dashboards, Map Visuals.
* **Modeling:** Star Schema design.


## 📂 Project Structure
This project follows the data lifecycle:

### Phase 1: Data Extraction & Logic (PostgreSQL)
* **Objective:** To design a robust data warehouse and automate critical business processes (like commission calculation).
* **Key Deliverables:** 
    1.  **Schema Design:** Created 6 tables (Fact/Dimension) with comprehensive integrity checks (PKs, FKs).
    2.  **Process Automation:** Implemented the **`record_sale_commission` Stored Procedure and Trigger** to handle commission payouts  in real-time.
    3.  **Data Generation:** Wrote procedural SQL to populate 200+ sales and 40+ customers, ensuring data quality for analysis.
    4.  **Reporting View:** Exporting tables data into CSV format to use in PowerBI Reporting

### Phase 2: Exploratory Analysis (Python)
* **Challenge:** Needed to group customers by purchasing behaviour, which is difficult in pure SQL.
* **Solution:** Used Python Pandas to create "Spending Buckets" and identified null values in the `contact_email` field.
* **See Notebook:** [See Python code here](./02_Python_Analysis/notebooks)

### Phase 3: Reporting (Power BI)
* **Metrics Created:**
    * `Average Fulfillment Latency` = AVERAGE(DispatchDate - SaleDate)
    * `MoM Growth %`
 **[See Dasboards here](./03_PowerBI_Reporting/dashboards)

---

## 🚀 How to Run
1.  **Database:** Restore the `Retail_Sales_Data_Backup.SQL` [file located in here](./data) to PostgreSQL.
2.  **Python:** Run `pip install -r requirements.txt` and launch the Jupyter Notebook.
3.  **Power BI:** Open the `.pbix` file. **[View Reports (.pbix) here](./03_PowerBI_Reporting/dashboards/customer demographics/4_Customer_Demographics.pbix)

## 👤 Author
**Edmundo Bejar** - Data Analyst & Test Analyst  
(https://www.linkedin.com/in/edmundo-bejar-3400691b) | (https://github.com/ebejar-pro)