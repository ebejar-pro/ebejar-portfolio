
---

# 📊 Power BI Retail Analytics Dashboard

### *Retail Sales • Employee Performance • Inventory Management • Customer Insights*

This Power BI project is built on top of the SQL-based Retail Company database created in **Chapter 01 – SQL Extraction**.
It demonstrates end-to-end capability across **data modeling, ETL, DAX, visualization, and business storytelling**.

[🔗 View ER Diagram](../01_SQL_Extraction/schemas/er_diagram.png)

---

## 🗂️ Project Overview

The dashboards emulate real-world retail analytics used by operational managers, sales leads, inventory teams, and customer experience departments.

This Power BI solution answers five core business domains:

---

## 1️⃣ Sales Performance

* Total revenue, quantity sold, and average order value
* Daily and monthly sales trends
* Top-selling products by revenue & quantity
* Channel performance (Retail vs Online)
* *Detailed commentary included in the Insights MD*

---

## 2️⃣ Employee Performance (Sales Team)

* Total commission earned
* Revenue contribution per salesperson
* Sales breakdown by channel
* Employee ranking via DAX window functions
* *Insights documented in Employee_Performance_Insights.md*

---

## 3️⃣ Inventory Efficiency

* Stock level overview with conditional formatting
* Low-stock product alerts
* Inventory days remaining
* Supplier-level dependency analysis
* *Additional narrative in Inventory_Insights.md*

---

## 4️⃣ Customer Demographics

* Age group distribution
* New vs returning customers
* Customer lifetime revenue
* Purchasing behaviour insights
* *Customer insights documented in Customer_Demographics_Insights.md*

---

## 5️⃣ Delivery & Operations (Optional Enhancement)

* Average dispatch time
* Fulfillment delays
* Lead-time patterns by product & supplier
* *This module is optional but ready for future extension*

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
`../data/Retail_Sales_Data_Backup.sql`

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

# 📊 Dashboards Included

### **1️⃣ Sales Performance Dashboard**

* Revenue trend
* Top 10 products
* Customer contribution
* Channel split

### **2️⃣ Employee Performance Dashboard**

* Total commission
* Revenue by staff
* Channel performance
* Salesperson ranking

### **3️⃣ Inventory & Supplier Dashboard**

* Stock levels
* Low-stock heatmap
* Inventory value
* Supplier distribution

### **4️⃣ Customer Demographics Dashboard**

* Age distribution
* Customer segmentation
* Purchase frequency

---

# ▶️ How to Use This Project

### **Step 1 — Download the PBIX File**

File: `Retail_Analytics.pbix`

### **Step 2 — Ensure Data Folder Exists**

CSV files must stay in:

```
03_PowerBI_Reporting/data/
```

### **Step 3 — Open in Power BI Desktop**

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

