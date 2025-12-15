# 📊 Python Business Intelligence Project

This project demonstrates how Python can be used to deliver **end-to-end business insights** by integrating, cleaning, and analyzing data across multiple domains. It complements my SQL and Power BI portfolio projects, showcasing how technical workflows translate into **real-world business impact**.

---

## 🚀 Project Overview
- **Languages & Tools:** Python (Pandas, Matplotlib, Seaborn), Jupyter Notebook
- **Data Model:** Synthetic dataset designed to simulate a retail business environment
- **Objective:** Provide recruiter-facing case studies that highlight data preparation, analysis, and visualization skills

---

## 🧪 Test Scenarios

### 1. Data Preparation & Integrity Check
- **Goal:** Ingest raw tables, clean data, validate ETL logic, and build a dimensional model (star schema).
- **Steps:**
  - Handle missing values, duplicates, and inconsistent formats
  - Validate joins across tables (Products, Customers, Employees, Suppliers, Sales, Sales Commission)
  - Reconcile key financial metrics with SQL project outputs
- **Business Impact:** Ensures reliable data foundation for all subsequent analyses.

---

### 2. Profitability Analysis by Product
- **Goal:** Identify products with the highest profit margins and overall contribution to revenue.
- **Steps:**
  - Calculate profit margin = `price - cost_price`
  - Aggregate total profit by product
  - Visualize top products with bar charts
- **Business Impact:** Guides pricing strategy and inventory prioritization.

---

### 3. Employee Performance & Commission
- **Goal:** Evaluate employee sales performance and commission relative to salary.
- **Steps:**
  - Merge sales, products, and commission tables
  - Calculate total sales and commission per employee
  - Compare salary vs. commission vs. sales in grouped bar charts
- **Business Impact:** Supports HR in assessing incentive structures and compensation fairness.

---

### 4. Customer Demographics & Sales Trends
- ** This scenario focuses on understanding customer behavior by segmenting the customer base into distinct age groups and analyzing their purchasing preferences across different sales channels (Online vs. Retail).
- **Goal:** To determine which demographic segments generate the highest revenue and identifying preferred shopping channels for each age group to inform targeted marketing strategies.
- **Steps:**
  - Converted the continuous age variable into categorical "buckets" to make the data analysable.
  - Segments Defined (Used Pandas pd.cut() function for dynamic binning) :
    . 18-29 (Young Adults)
    . 30-39 (Early Career)
    . 40-49 (Mid-Career)
    . 50-59 (Pre-Retirement)
    . 60+ (Seniors) - Visualize demographic trends

- **Business Impact:** Enables targeted marketing and channel optimization.

---

### 5. Supplier Contribution & Risk Management
- **Goal:** Assess supplier dependency and contribution to overall revenue.
- **Steps:**
  - Join suppliers with sales
  - Aggregate revenue by supplier
  - Visualize supplier share with pie charts
- **Business Impact:** Identifies supply chain risks and diversification opportunities.

---

### 6. Sales Fulfillment & Dispatch Efficiency
- **Goal:** Measure dispatch delays and compare efficiency across sales channels.
- **Steps:**
  - Calculate dispatch delay = `dispatch_date - sale_date`
  - Flag delays > 7 days
  - Compare average delays by channel
- **Business Impact:** Improves logistics planning and customer satisfaction.

---

## 📈 Example Visualizations
- **Profitability Analysis:** Bar chart of top products by profit
- **Employee Performance:** Grouped bar chart comparing salary, commission, and sales
- **Customer Trends:** Line chart of sales volume by age group
- **Supplier Risk:** Pie chart of revenue share by supplier
- **Dispatch Efficiency:** Histogram of dispatch delays

---

## 🗂 Project Structure

├── data/                # Synthetic datasets ├── notebooks/           # Jupyter notebooks for each scenario ├── visuals/             # Saved charts and plots ├── README.md            # Project documentation


---

## 🎯 Key Takeaways
- Demonstrates **Python workflow automation** and **business storytelling with data**
- Complements SQL and Power BI projects by showing **cross-platform consistency**
- Provides recruiter-facing case studies with **clear business relevance**

---

## 📬 Contact
**Edmundo**  
Data Analyst | Business Intelligence | Python, SQL, Power BI  