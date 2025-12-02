
# 📊 Power BI Retail Analytics Dashboard

**Retail Sales • Employee Performance • Inventory Management • Customer Insights**

This Power BI project is built from the Retail Company SQL database (see ER Diagram in repository).
It demonstrates your end-to-end BI capability across data extraction, modeling, visualization, and storytelling.

---

## 🗂️ Project Overview

This dashboard answers real-world business questions used in retail companies:

### **1. Sales Performance**

* Total revenue, quantity, and average order value
* Sales by date, product, and customer
* Year-over-year sales trends
* Top products by revenue and quantity

### **2. Employee Performance (Sales Team)**

* Commission earned
* Revenue contribution per salesperson
* Online vs. Retail channel performance
* Ranking using DAX measures

### **3. Inventory Efficiency**

* Stock level monitoring
* Days of inventory remaining
* Low-stock alerts using conditional formatting
* Supplier-level breakdown

### **4. Customer Demographics**

* Age groups & segmentation
* New vs. returning customers
* Customer lifetime revenue
* Purchase behavior analysis

### **5. Delivery & Operations (Optional)**

* Average dispatch time
* Fulfilment delays
* Product lead time trends

---

## 📁 Data Sources (CSV Format)

All data used in this dashboard comes from the underlying PostgreSQL database in your SQL project.
For convenience, all tables have been exported to **CSV format**.

### **Available CSV Files**

Found under:

```
PowerBI/Data/
```

Includes:

* `products.csv`
* `sales.csv`
* `sales_commission.csv`
* `employees.csv`
* `customers.csv`
* `suppliers.csv`

### ✔ Why CSV Files?

* Easy and quick to load into Power BI
* No PostgreSQL installation required
* Portable for reviewers (agencies, hiring managers)
* Data schema matches the SQL project

**Note:** You can also connect Power BI directly to PostgreSQL if preferred, but CSV ensures the project is self-contained.

---

## 🔧 Data Model

The dataset follows the same schema used in your SQL project:

* Fact table: **sales**
* Dimensions: products, customers, employees, suppliers
* Calculated fact: **sales_commission**
* Metadata view: `vw_sales_summary`

This model supports:

* Star schema
* One-to-many relationships
* Clean, optimized Power BI modeling

---

## 📐 DAX Measures Used

Example measures included in this project:

```DAX
Total Revenue = SUM(sales[quantity] * RELATED(products[price]))

Total Commission = SUM(sales_commission[commission_amount])

Average Order Value = [Total Revenue] / DISTINCTCOUNT(sales[sale_id])

Top Product Rank = RANKX(ALL(products), [Total Revenue], , DESC)
```

(Additional DAX measures are inside the `.pbix` file.)

---

## 📊 Dashboards Included

### **1️⃣ Sales Performance Dashboard**

* Revenue trends
* Top 10 products
* Best customers
* Channel performance (Online vs Retail)

### **2️⃣ Employee Performance Dashboard**

* Total commission
* Revenue per salesperson
* Channel breakdown
* Ranking table

### **3️⃣ Inventory & Supplier Dashboard**

* Stock levels
* Low-stock heatmap
* Supplier contribution
* Inventory value

### **4️⃣ Customer Demographics Dashboard**

* Age distribution
* Customer segments
* Repeat purchase patterns

---

## ▶️ How to Use

1. Download `Retail_Analytics.pbix`
2. Open in **Power BI Desktop**
3. Ensure that the CSV files are in the correct relative path (`PowerBI/Data/`)
4. Refresh the model if needed

---

## 📝 Project Purpose

This project demonstrates your capability in:

* Transforming SQL model into BI-ready datasets
* Crafting business-ready dashboards
* Using DAX for calculations
* Applying star schema design
* Building real retail analytics for employers

---

