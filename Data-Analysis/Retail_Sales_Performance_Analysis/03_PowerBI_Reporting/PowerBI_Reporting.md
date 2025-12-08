
---

# 📊 Power BI Retail Analytics Dashboard

### *Retail Sales • Employee Performance • Inventory Management • Customer Insights • Delivery and Operations*

This Power BI project is built on top of the SQL-based Retail Company database created in **Chapter 01 – SQL Extraction**.
It demonstrates end-to-end capability across **data modeling, ETL, DAX, visualisation, and business storytelling**.

[🔗 View ER Diagram](../01_SQL_Extraction/schemas/er_diagram.png)

---

## 🗂️ Project Overview

The dashboards emulate real-world retail analytics used by operational managers, sales leads, inventory teams, and customer experience departments.

This Power BI solution answers five core business domains:

---
# 📊 Dashboards Included

## 1️⃣ Sales Performance

* Total revenue, quantity sold, and average order value
* Monthly sales trends
* Top-selling products by revenue & quantity
* Channel performance (Retail vs Online)
* *Power BI Desktop Document  ./dashboards/sales performance/1_Sales_Performance.pbix*
* *Insights documented in ./dashboards/sales performance/1_Sales_Performance_Insights.md*


---

## 2️⃣ Salesperson Performance

* Total sales by salesperson
* Revenue contribution per salesperson
* Total commission earned by salesperson
* Sales breakdown by channel
* Salesperson ranking via DAX window functions
* *Power BI Desktop Document  ./dashboards/salesperson performance/2_Salesperson_Performance.pbix*
* *Insights documented in ./dashboards/salesperson performance/2_Salesperson_Performance_Insights.md*

---

## 3️⃣ Inventory Efficiency

* Stock level per product
* Inventory value per product
* KPI cards: Total inventory value, Total units in stock, Inventory turnover ratio, Cost of goods sold
* Low-stock product alerts
* Total units sold by product
* *Power BI Desktop Document  ./dashboards/inventory efficiency/3_Inventory_Efficiency.pbix*
* *Insights documented in ./dashboards/inventory efficiency/3_Inventory_Efficiency_Insights.md*

---

## 4️⃣ Customer Demographics

* Customer age segmentation
* Revenue by age group
* Customer revenue and units bought 
* Revenue by customer over time
* *Power BI Desktop Document  ./dashboards/customer demographics/4_Customer_Demographics.pbix*
* *Customer insights documented in ./dashboards/customer demographics/4_Customer_Demographics_Insights.md*

---

## 5️⃣ Delivery And Operations

* Order dispatch performance
* Supplier delivery performance
* Fulfillment channel efficiency
* Inventory movement - stock level % of units sold
* *Power BI Desktop Document  ./dashboards/delivery operations/5_Delivery_Operations.pbix*
* *Delivery insights documented in ./dashboards/delivery operations/5_Delivery_And_Operations_Insights.md*

---

# 📁 Data Sources (CSV Format)

This folder includes all data necessary to run Power BI independently—**no PostgreSQL connection required**.

📂 Folder:
`../03_PowerBI_Reporting/data/`

### **CSV Files Included**

* `products.csv`
* `sales.csv`
* `sales_commission.csv`
* `employees.csv`
* `customers.csv`
* `suppliers.csv`

### ✔ Why CSV?

* Fastest way to load Power BI
* Portable for hiring managers
* No database setup required
* Perfect for GitHub-hosted BI projects

📌 Optional:
A full PostgreSQL backup is available here:
`./Data/Retail_Sales_Data_Backup.sql`

---

# 🔧 Data Model in Power BI

The model replicates the SQL star schema:

**Fact Table**

* `sales`

**Dimension Tables**

* `products`
* `customers`
* `employees`
* `suppliers`

**Fact Extension / Derived**

* `sales_commission`

**Model Highlights**

* Clean one-to-many relationships
* Surrogate keys aligned with PostgreSQL
* Fully optimized for reporting
* No bi-directional filters

This ensures strong performance and intuitive reporting.

---

# 📐 Core DAX Measures

[🔗 View DAX Measures text files](./DAX files)
1_Order_to_Dispatch_Measures.txt
2_Fulfillment_Channel_Measures.txt
3_Supplier_Performance_Measures.txt
4_Stock_Risk_Measures.txt
5_Replenishment_Measures.txt

Below are examples of key measures used throughout the dashboards:

```DAX
Total Revenue = SUM(sales[quantity] * RELATED(products[price]))

Total Commission = SUM(sales_commission[commission_amount])

Average Order Value = 
    DIVIDE([Total Revenue], DISTINCTCOUNT(sales[sale_id]))

Top Product Rank =
    RANKX(ALL(products), [Total Revenue], , DESC)
```

More DAX measures can be viewed inside the `.pbix` file in the dashboards folder.

---

# ▶️ How to Use This Project

### **Step 1 — Download the PBIX File**

Files: `Sales_Performance.pbix`, `Salesperson_Performance.pbix`, `Inventory_Efficiency.pbix`, `Customer_Demographics.pbix`, and `Delivery_And_Operations.pbix`

### **Step 2 — Ensure Data Folder Exists**

CSV files must stay in:

```
03_PowerBI_Reporting/data/
```

### **Step 3 — Open in Power BI Desktop each pbix file**

The model should load instantly.

### **Step 4 — Refresh if Needed**

Power BI will read the CSVs automatically.

---

# 📝 Project Purpose

This project demonstrates my ability to:

* Transform raw SQL data into BI-ready models
* Build professional industry dashboards
* Create DAX-driven KPIs
* Apply best practices in star schema modeling
* Communicate insights that matter to business leaders
* Present a fully integrated analytics project end-to-end

---

