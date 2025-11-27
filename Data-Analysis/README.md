# Project Title: Retail Sales Performance Analysis

# 🛒 End-to-End Retail Sales Performance Analysis

## 📄 Executive Summary
This project analyses sales data for a global retail company to optimize supply chain decisions and restructure employee incentive programs. 

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

### Phase 1: Data Extraction & Logic (SQL)
* **Challenge:** The raw database lacked a "Revenue" column and had inconsistent shipping dates.
* **Solution:** * Created `v_supplier_revenue` view to aggregate total spend.
    * Wrote `record_sale_commission` stored procedure to automate payouts while blocking specific IDs (2, 3, 4).
    * See code: [SQL Scripts Folder](./01_SQL_Extraction/queries)

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
[www.linkedin.com/in/edmundo-bejar-3400691b] | [https://github.com/ebejar-pro/ebejar-portfolio]