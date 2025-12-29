
---

## 📊 DataAnalytics_Projects

A curated collection of real-world data analysis projects across multiple industries — including banking, retail, education, pharmaceuticals, and demographics. Each project demonstrates end-to-end business intelligence workflows using Python, SQLite, and Power BI.

---

### 🚀 Project Overview

This repository showcases how data analytics can drive insights and decision-making across diverse domains. Each dataset is explored through:

- **Data cleaning & transformation** (Python, Pandas)  
- **Structured storage** (SQLite)  
- **Interactive dashboards** (Power BI)  
- **Business storytelling** (Jupyter notebooks + visualizations)

---

### 🧰 Tech Stack

| Tool            | Purpose                                  |
|-----------------|------------------------------------------|
| Python 3.12     | Core data analysis & scripting           |
| Pandas, NumPy   | Data wrangling & numerical operations    |
| SQLite          | Lightweight relational database          |
| SQLAlchemy      | Python-SQL integration                   |
| Jupyter Notebook| Exploratory analysis & documentation     |
| Power BI        | Dashboarding & business storytelling     |
| Faker           | Synthetic data generation (where needed) |
| DuckDB, Polars  | Fast analytics for large datasets        |

Environment managed via Conda — see [`environment.yml`](./environment.yml) for reproducibility.

---

### 📁 Folder Structure

```
DataAnalytics_Projects/
│
├── data/
│   ├── raw/                # Original Excel/CSV files
│   ├── processed/          # Cleaned datasets
│   └── database.sqlite     # Central SQLite database
│
├── notebooks/
│   ├── 01_cleaning.ipynb   # Data cleaning & transformation
│   ├── 02_sql_load.ipynb   # SQLite integration
│   └── 03_analysis.ipynb   # Exploratory insights
│
├── dashboards/
│   └── project_name.pbix   # Power BI dashboards
│
├── src/
│   ├── etl.py              # ETL pipeline scripts
│   └── utils.py            # Helper functions
│
├── environment.yml         # Conda environment file
└── README.md               # Project overview
```

---

### 📦 Datasets Included

Projects span multiple industries and topics:

- **Banking**: `bank_churn`, `company_costs_data`  
- **Retail**: `Superstore_Sales`, `apple_iphone_revenue`  
- **Education**: `student_grades`, `college_admissions`  
- **Pharmaceutical**: `drug_trial_results`, `pharma_sales`  
- **Demographics**: `City_Crime_Rates`, `population_stats`  
- **Sports**: `players`, `team_performance`  
- **Social Media**: `social_media_behavior`  
- **Transportation**: `traffic_volume`, `ride_sharing_data`

Each dataset is explored with tailored business questions and visualizations.

---

### 📈 Sample Business Questions

- What factors drive customer churn in banking?  
- Which product categories generate the highest revenue in retail?  
- How do student performance trends vary across institutions?  
- What patterns emerge in city crime rates over time?  
- How can pharmaceutical trial data be visualized for clinical insights?

---

### 🧠 How to Use

1. Clone the repo  
2. Create the Conda environment:
   ```bash
   conda env create -f environment.yml
   conda activate DataAnalytics_Projects
   ```
3. Launch Jupyter:
   ```bash
   jupyter lab
   ```
4. Explore notebooks and dashboards

---

### 📌 Author

**Edmundo Bejar** — Data Analyst & BI Developer  
Focused on building recruiter-facing technical portfolios that showcase real-world business impact.

---
