# 🧑‍💼 Data Preparation and Integrity Check
This initial phase focuses on establishing a clean, unified, and financially enriched dataset from five separate CSV sources, ensuring the foundation for subsequent business analysis is robust and accurate.

---

## 🔍 Objective
To perform Data Ingestion, Cleaning, ETL (Extract, Transform, Load) logic validation, and Dimensional Modeling (Star Schema) creation using Python (Pandas), confirming all data is merged correctly and key financial metrics are accurately calculated.

---

## 📊 Execution Summary
The script successfully loaded all five source files, performed critical column checks, and merged them into a single master_df (Fact Table), enriching it with necessary financial features.

| Table            | Rows Loaded| Status              |
|------------------|----------  |---------------------|
| sales            | 201        | Loaded & Date Parsed|
| customers        |  47        | Loaded              |
| employees        |  11        | Loaded              |
| products         |  13        | Loaded              |
| sales_commission |  197       | Loaded              |


## 📐 Data Integrity and modeling Validation
1. **Schema Alignment:** Corrected dynamic schema inconsistencies during the merge process, successfully mapping single name columns in customers and employees (renamed to customer_name and employee_name) and utilizing the corrected job_code field from the employees table.
2. **Category Integration:** Verified the presence and use of the category column in the products table, ensuring products are correctly segmented for future analysis.
3. **No Data Loss:** The master DataFrame contains 201 rows, matching the total record count of the core sales table, confirming a complete LEFT JOIN (Star Schema) without record duplication or loss.
4. **Data Quality:** All source tables passed validation checks for null values and duplicate records, confirming high initial data quality.

## 🧠 Feature Engineering & Financial Reconciliation
Key financial metrics were engineered successfully, serving as the basis for performance reporting:

| Metric           | Calculation               | Reconciled Value        |
|------------------|---------------------------|---------------------    |   
| Total Revenue    | quantity * price          | $387,496.20             |
| Total COGS       | quantity * cost_price     | (Calculated internally) |
| Total Profit     | Revenue - COGS            | $158,284.70             |
| Fulfillment Days | dispatch_date - sale_date | (Calculated internally) |

*Reconciliation Note:* The calculated Total Revenue and Total Profit figures have been reconciled against expected results derived from independent SQL queries, confirming the accuracy of the Python feature engineering logic.
