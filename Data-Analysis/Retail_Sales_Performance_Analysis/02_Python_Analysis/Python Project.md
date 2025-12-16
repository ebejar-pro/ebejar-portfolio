# 📊 Python Business Intelligence Project

This project demonstrates how Python can be used to deliver **end-to-end business insights** by integrating, cleaning, and analyzing data across multiple domains. It complements my SQL and Power BI portfolio projects, showcasing how technical workflows translate into **real-world business impact**.

---

## 🚀 Project Overview
- **Languages & Tools:** Python V3.10.19 (Pandas, Matplotlib, Numpy, Seaborn), Jupyter Notebook V7.5.0
- **Data Model:** Synthetic dataset designed to simulate a retail business environment
- **Objective:** Provide recruiter-facing case studies that highlight data preparation, analysis, and visualization skills

---

## ⚙️ Quick Start
1.  Clone Repository
    git clone https://github.com/ebejar/python-bi-project.git
    cd python-bi-project

2.  Install dependencies:
    pip install -r requirements.txt

3.  Launch Jupyter Notebook
    jupyter notebook notebooks/

4.  Run the notebook cells in order to reproduce the analysis and visualisations.

## 📦 Requirements
pandas==2.2.2
numpy==1.26.4
matplotlib==3.9.0
seaborn==0.13.2
jupyter==1.0.0

Install with:
pip install -r requirements.txt

## 📂 Data Schema
Synthetic tables simulate a retail business environment:
• 	Customers: customer_id, name, age, email, age
• 	Employees: employee_id, name, salary, job_code, commission
• 	Products: product_id, product_name, price, supplier_id, stock_level, category
• 	Sales: sale_id, customer_id, product_id, sale_date, quantity, employee_id, supplier_id, sales_channel, dispatch_date
• 	Suppliers: supplier_id, name, contact_email, phone, country
• 	Sales_Commission: commission_id, employee_id, sale_id, commission_amount, created_at 

## 🧪 Test Scenarios

### 1. Data Preparation & Integrity Check

- **Goal:** Ingest raw tables, clean data, validate ETL logic, and build a dimensional model (star schema).
- **Steps:**
  - Tables to inspect: Customers, Employees, Products, Sales, Suppliers, and Sales_Commission
  - Handle missing values, duplicates, and inconsistent formats
  - Validate joins across tables (Products, Customers, Employees, Suppliers, Sales, Sales Commission)
  - Reconcile key financial metrics with SQL project outputs
- **Business Impact:** Ensures reliable data foundation for all subsequent analyses.

---

### 2. Profitability Analysis by Product

- **Goal:** Identify products with the highest profit margins and overall contribution to revenue.
- **Steps:**
  - Merge sales, and products
  - Calculate profit margin = `price - cost_price`
  - Calculate total profit = 'profit margin' * 'quantity'
  - Aggregate total profit by product
  - Visualize bar chart of top products by profit
- **Business Impact:** Guides pricing strategy and inventory prioritization.

---

### 3. Employee Performance & Commission

- **Goal:** Evaluate employee sales performance (employees with job_code='SALES') and commission relative to salary.
- **Steps:**
  - Merge employees, sales, products, and commission tables
  - Calculate total sales and commission by employee
  - Calculate total sales by employee 
  - Calculate salary and commission by employee
  - Calculate commission as % of sales
  - Visualise scatter chart of sales vs commission
  - Visualise bar chart of total sales by employee
  - Visualise stacked column chart of salary and commission by employee
  - Visualise bar charts of commission as % of sales  
- **Business Impact:** Supports HR in assessing incentive structures and compensation fairness.

---

### 4. Customer Demographics & Sales Trends

- **Goal:** To determine which demographic segments generate the highest revenue and identifying preferred shopping channels for each age group to inform targeted marketing strategies.
- **Steps:**
  - Merge sales, customers, products. and employees
  - Convert the age variable into categorical "buckets" to make the data analysable.
  - Calculate revenue by product 
  - Define customer segments (Used Pandas pd.cut() function for dynamic binning) :
    . 18-29 (Young Adults)
    . 30-39 (Early Career)
    . 40-49 (Mid-Career)
    . 50-59 (Pre-Retirement)
    . 60+ (Seniors)
  - Visualise stacked bar chart of total revenue by age group and sales channel ('Online or 'Retail')
- **Business Impact:** Enables targeted marketing and channel optimization.

---

### 5. Supplier Contribution & Risk Management
- **Goal:** Assess supplier dependency and contribution to overall revenue.
- **Steps:**
  - Merge suppliers, sales, and products
  - Aggregate revenue, profit, number of sales, and average of fulfillment days by supplier
  - Categorised fulfillment risk by supplier
  - Rank supplier by revenue contribution
  - Visualise pie chart of supplier revenue contribution
  - Visualise stacked bar chart of supplier average order fulfillment time
- **Business Impact:** Identifies supply chain risks and diversification opportunities.

---

## 🗂 Project Structure

```
02_Phyton_Analysis/
│
├── python project.md
├── requirements.txt
├── notebooks/
├── data/
├── src/

---

## 🎯 Key Takeaways
- Demonstrates **Python workflow automation** and **business storytelling with data**
- Complements SQL and Power BI projects by showing **cross-platform consistency**
- Provides recruiter-facing case studies with **clear business relevance**

---

## 📬 Contact
**Edmundo Bejar**  
Data Analyst | Business Intelligence | Python, SQL, Power BI  | ebejar3@gmail.com | http://www.linkedin.com/in/edmundo-bejar-3400691b