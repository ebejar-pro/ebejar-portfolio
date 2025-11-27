This Data Dictionary details tables and its elements containing the data for a ficticious retail company.  

---

# 📘 **Data Dictionary ABC Retail Company**

## 1. **Overview**

| Field                     | Description                                                                                                            |
| ------------------------- | ---------------------------------------------------------------------------------------------------------------------- |
| **Project Name**          | Retail Sales Analytics Database                                                                                        |
| **System/Database**       | PostgreSQL                                                                                                             |
| **Prepared By**           | *Edmundo Bejar*                                                                                                          |
| **Last Updated**          | *2025-11-27*                                                                                                           |
| **Purpose**               | To support retail performance analytics and commission calculation |
| **Key Business Areas**    | Sales, Customer Management, Inventory, Supplier Management                                                             |
| **Confidentiality Level** | Internal / Public / Restricted                                                                                         |

---

## 2. **Table Summary**

| Table Name       | Description                    | Primary Key   | Row Count | Notes                           |
| ---------------- | ------------------------------ | ------------- | --------- | ------------------------------- |
| products         | List of saleable products      | product_id    | ~13       | Includes price and supplier     |
| suppliers        | Supplier details               | supplier_id   | ~12       | Local and international vendors |
| customers        | Customer details               | customer_id   | ~8        | Retail customers                |
| employees        | Employee records               | employee_id   | ~11       | Used for commissions            |
|                  | (sales staff job_code='SALES') |               | ~5
| sales            | Sales transactions             | sale_id       | ~400      | Fact table                      |
| sales_commission | Commission records             | commission_id | ~200      | Linked to employees             |

---

## 3. **Column-Level Data Dictionary**

### **Table: sales**

| Field        | Type          | Nullable | Description         | Example           | Notes |
| ------------ | ------------- | -------- | ------------------- | ----------------- | ----- |
| sale_id      | INT           | No       | Unique sale code    | 100               | PK    |
| customer_id  | INT           | No       | Unique customer id  | 35                | FK    |
| product_id   | INT           | No       | Unique product id   | 23                | FK    |
| sale_date    | Date          | No       | Sale date           | 2025-09-20        |       |
| quantity     | INT           | No       | Number of units sold| 3                 |       |
| employee_id  | INT           | No       | Unique employee id  | 10                | FK    |
| supplier_id  | INT           | No       | Supplier reference  | 8                 | FK    |
| sales_channel| VAR(20)       | No       | Sale channel        | Online            |       |
| dispatch_date| Date          | No       | Sale dispatch date  | 2025-09-22        |       |

### **Table: products**

| Field        | Type          | Nullable | Description         | Example           | Notes |
| ------------ | ------------- | -------- | ------------------- | ----------------- | ----- |
| product_id   | INT           | No       | Unique product code | 8                 | PK    |
| product_name | VARCHAR(100)  | No       | Product description | "Air Conditioner" |       |
| price        | DECIMAL(10,2) | No       | Unit price          | 1199.00           |       |
| supplier_id  | INT           | No       | Supplier reference  | 8                 | FK    |
| cost_price   | DECIMAL(10,2) | No       | product cost price  | 235.50            |       |
| stock_level  | INT           | No       | Stock level         | 25                |       |



### **Table: customers**

| Field        | Type          | Nullable | Description         | Example             | Notes |
| ------------ | ------------- | -------- | ------------------- | -----------------   | ----- |
| customer_id  | INT           | No       | Unique customer code| 8                   | PK    |
| name         | VARCHAR(100)  | No       | Customer name       | Bob Smith           |       |
| email        | VARCHAR(100)  | No       | Customer email      | bobsmith@example.com|       |
| age          | INT           | No       | Customer age        | 38                  |       |


### **Table: employees**

| Field        | Type          | Nullable | Description         | Example             | Notes |
| ------------ | ------------- | -------- | ------------------- | -----------------   | ----- |
| employee_id  | INT           | No       | Unique employee code| 8                   | PK    |
| name         | VARCHAR(100)  | No       | Employee name       | Eric Law            |       |
| salary       | DECIMAL(10,2) | No       | Employee salary     | $85,000.00          |       |
| job_code     | VARCHAR(20)   | No       | Job code            | "MGR", "SALES"      |       |
| commission   | DECIMAL(10,2) | No       | Sales commission    | $120.50             |       |


### **Table: suppliers**

| Field        | Type          | Nullable | Description         | Example               | Notes |
| ------------ | ------------- | -------- | ------------------- | -----------------     | ----- |
| supplier_id  | INT           | No       | Unique supplier code| 12                    | PK    |
| name         | VARCHAR(100)  | No       | Supplier name       | TechSource Ltd        |       |
| contact_email| VARCHAR(100)  | No       | Supplier email      | contact@techsource.com|       |       
| phone        | VARCHAR(20)   | No       | Supplier phone      | 111-222-333           |       |
| country      | VARCHAR(50)   | No       | Supplier country    | USA                   |       |



### **Table: sales commissions**

| Field            | Type          | Nullable | Description         | Example             | Notes |
| ------------     | ------------- | -------- | ------------------- | -----------------   | ----- |
| commission_id    | INT           | No       | Unique commission id| 10                  | PK    |
| employee_id      | INT           | No       | Employee name       | 15                  | FK    |
| sale_id          | INT           | No       | Employee salary     | 35                  | FK    |
| commission_amount| DECIMAL(10,2) | No       | Job code            | $125.60             |       |
| created_at       | TIMESTAMP     | No       | Record created      | 2024-11-01          |       |

---

## 4. **Business Rules & Data Quality**

| Rules                                                                               | Description |
| ----------------------------------------------------------------------------------- | ----------- |
| Quantity must be between 1 and 5.                                                   |             |
| A sale must reference an existing product and employee.                             |             |
| A product must always have a valid supplier.                                        |             |
| Sale date cannot be in the future.                                                  |             |
| Sale dispatch cannot less than sale date.                                           |             |  
| Sale channel can be "Retail" or "Online".                                           |             |
| Commission only applies to valid employee sales records (job_code = "SALES").       |             |
| Duplicate customer records must be avoided (use email or mobile number validation). |             |

---

## 5. **Data Relationships (High Level)**

```
suppliers → products → sales ← customers
                   ↓
             sales_commission ← employees
```

## 6. **Entity Relationship Diagram**

See below the ER Diagram or you can click to open it in new tab.

![Entity Relationship Diagram](Schemes/er_diagram.png)

🔗 [Open diagram in new tab](Schemes/er_diagram.png)

---

## 7. **ETL & Transformation Notes**

| Process                    | Description                                | Frequency  |
| -------------------------- | ------------------------------------------ | ---------- |
| Historical sales data load | Generated synthetically for simulation     | One-off    |
| Price update sync          | Manually adjusted based on product updates | Ad hoc     |
| Commission calculation     | Calculated as soon the sale is committed   | Each sale  |
| Data clean-up              | Ensure no NULL foreign keys                | Continuous |

---

## 8. **Metadata & Technical Considerations**

| Aspect            | Details                                          |
| ----------------- | ------------------------------------------------ |
| Database engine   | PostgreSQL 15                                    |
| Backup retention  | Daily snapshots (for GitHub project copy only)   |
| Performance index | Yes, on `sale_date`, `product_id`, `employee_id` |
| Security          | Not applicable (sample data only)                |
| Data Volume       | Small (training/demo only)                       |

---
