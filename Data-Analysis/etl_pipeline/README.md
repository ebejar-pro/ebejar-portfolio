
---

## 📌 ETL Pipeline: Data Cleaning, Validation & Enrichment (Python + Pandas)

A production‑grade ETL pipeline implementing Medallion Architecture, international data standards, and a full Data Quality framework.

---

### 🚀 Project Overview

This project demonstrates a complete end‑to‑end ETL pipeline built in Python to process messy, real‑world CSV data.
The dataset includes:

- malformed rows

- inconsistent date formats

- invalid phone numbers

- corrupted address fields

- missing values

- duplicate records

- unrealistic ages

- non‑ISO country names

The pipeline uses a Bronze → Silver → Gold Medallion Architecture and includes:

- Data ingestion with error tolerance

- Data cleaning & standardisation

- International standards (E.164, ISO 3166‑1)

- Data Quality validation

- Quarantine of invalid records

- Business enrichment (age, salary band)

This project showcases your strengths in:

- Data Engineering

- Data Quality & Validation

- ETL Pipeline Design

- Python (Pandas, Regex, phonenumbers, pycountry)

- Real‑world messy data remediation

- Analytics‑ready dataset creation
---


### 🏗️ Architecture

```
etl_python_sql/
│
├── data/
│   ├── raw/          # Original CSV (Bronze input)
│   ├── bronze/       # Raw ingested data
│   ├── silver/       # Cleaned & standardized data
│   ├── gold/         # Enriched, analytics-ready data
│   └── quarantine/   # Invalid rows flagged by DQ rules
│
├── etl/
│   ├── extract.py    # Ingestion logic
│   ├── validate.py   # Data quality rules (E.164, ISO, age)
│   ├── transform.py  # Cleaning & standardisation
│   ├── load.py       # Enrichment & output
│
└── main.py           # Pipeline orchestrator
└── README.md         # Project overview

```

---

### 🟫 Bronze Layer — Extraction

The pipeline ingests the raw CSV exactly as received, using:
 
- tolerant parsing (on_bad_lines='warn')

- all fields loaded as strings

- no schema enforcement

This ensures ingestion never fails, even with corrupted rows.

---

### 🥈 Silver Layer — Cleaning & Standardisation

This layer applies transformations such as:

- lower‑casing and normalising column names

- trimming whitespace

- fixing multi‑line addresses

- converting date formats (dd/mm/yyyy → ISO 8601)

- converting salary to numeric

- removing duplicates

- normalising phone numbers

- validating country names

---

### 🧪 Data Quality Framework

The validation module enforces:

✔ Completeness
- Required fields must be present

✔ Validity
- Email regex validation

- Phone number validation using E.164

- Country validation using ISO 3166‑1

- Date validation (supports dd/mm/yyyy and yyyy-mm-dd)

- Salary must be numeric

✔ Plausibility
- Age must be between 0 and 110 years

✔ Consistency
- Address must not contain embedded records

- Phone numbers must be normalised

✔ Uniqueness
- Email must be unique

Invalid rows are written to the quarantine folder for review.
---

### 🥇 Gold Layer — Enrichment

The cleaned dataset is enriched with:

- Age (derived from Date of Birth)

- Salary Band (Low / Medium / High / Very High)

- Standardised phone numbers (E.164)

- ISO‑validated country names

The Gold dataset is analytics‑ready and suitable for dashboards, reporting, or SQL ingestion.

### 📊 Technologies Used

- Python 3.12

- Pandas

- NumPy

- phonenumbers (E.164 validation)

- pycountry (ISO 3166‑1 validation)

- Regex

- VS Code / Jupyter

### ▶️ How to Run the Pipeline
Install dependencies:

> pip install -r requirements.txt

Run ETL:

> python main.py

Ouputs will be generated:

data/bronze/

data/silver/

data/gold/

data/quarantine/


### 📈 Data Quality Summary (Example)
After running the pipeline, you may see something like:

| Stage | Row Count |
| --- | --- |
| Raw | 300 |
| Bronze | 300 |
| Silver | 240 |
| Gold | 230 |
| Quarantine | 70 |

### 🎯 Why This Project Matters
This project simulates real‑world challenges found in:

- CRM data ingestion

- Customer master data cleanup

- Legacy system migrations

- Data warehouse onboarding

- Regulatory reporting

- Data quality remediation

It demonstrates your ability to:

- handle messy real‑world data

- design robust ETL pipelines

- enforce international data standards

- produce clean, reliable datasets

- build scalable, modular code

### 📌 Author

**Edmundo Bejar** 
Data Engineer Data Quality Analyst & Test Analyst  
📍 Sydney, Australia
📧 Email: ebejar@gmail.com

---
