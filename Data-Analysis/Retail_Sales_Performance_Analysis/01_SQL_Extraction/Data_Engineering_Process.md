# 📄 Objective
We set up the tables needed for a Retail Sale Company to perform its business, establish the inter relationship between the tables and populate with dummy data. By looking at the business processes for a retail company selling products thru online or in retails shops we considered necesary to add extra columns to meet business requirements. Also we add more data for some of the tables to meet report requirements. We use PostgreSQL as develop tool to achieve the objectives of this part of the project.

## Schema Design & Integrity:

**Problem:** Required a reliable foundation for all analyses (fact/dimension tables).

**Solution:** Implemented the schema (Customers, Employees, Products, Suppliers, Sales, Sales Commission) using a Primary Key (PK) and Foreign Key (FK) structure to enforce data integrity (e.g., ensuring every sale links to an existing customer).

👉 **[Reference to table creation](./schemas/Retail_Company_Schema.sql>)**

## Schema Modification (Adding Dimensions):

**Problem:** The original sales table lacked essential business dimensions (sales_channel and dispatch_date) needed for supply chain analysis.

**Solution:** Used ALTER TABLE ADD COLUMN to append these fields, preparing the dataset for detailed reporting on fulfillment latency.

## Automated Commission Logic (Stored Procedure):

**Problem:** The business needed an auditable, automated way to calculate sales commissions (5% of sale value) while maintaining existing data integrity rules (e.g., avoiding double-calculation, temporarily excluding specific IDs 2, 3, 4).

**Solution:** Created the record_sale_commission Stored Procedure. This logic is called automatically by a Trigger on the sales table.

👉 **[Reference the record_sale_commission](./stored_procedures/Procedure_RecordSale_Commission.sql>)**

👉 **[Reference the trigger_record_commission()](./stored_procedures/Function_TriggerRecord_Commission.sql>)**

## Data Population & Validation:

**Problem:** Initial data was sparse (15 sales, few customers), which would lead to poor demographic and trend analysis.

**Solution:** Created a PostgreSQL function (generate_sales_data()) to programmatically insert 200+ sales and 40+ customers with randomized, yet realistic, dates and ages to ensure adequate data volume and variance for the analysis.

👉 **[Reference to data population & validation](./stored_procedures/Procedure_Generate_SalesData.sql>)**

# Business Scenarios

## Scenario 1: Employee Incentive & Performance

**Business Question:** How effective is the sales team, and how is their commission distributed across different sales channels?

**Focus**: 
Commission Payout   - Total commission earned by each salesperson.
Performance Rank    - A ranked list of salesperson by total revenue generated.
Sales Channel Split - Percentage of each salesperson's total sales that came from 'Retail' vs 'Online'.

👉 **[Reference for Employee Performance](./queries/1_Employee_Performance.sql>)**

## Scenario 2: Product & Inventory Efficiency

**Business Question:** Which products are the most profitable, and which suppliers are impacting our inventory levels and costs?
**Focus**: 
Profit Margin        - Calculated net profit and gross margin percentage per product. 
Stock Turnover       - List of products where stock_level is below a set threshold (e.g., < 50), flagging potential re-order needs.
Supplier Reliability - Ranking suppliers based on the total number of items sold. (More advanced: Flagging suppliers based on fulfillment latency if you enrich your sales table).

👉 **[Reference for Inventory Efficiency](./queries/2_Inventory_Efficiency.sql>)**

## Scenario 3: Customer Segmentation & Demographics

**Business Question:** Who are our most valuable customers, and what are their demographic characteristics (age groups)?
**Focus**: 
Age Buckets         - Defining age categories like '18-30 (Young)', '31-55 (Core)', '56+ (Senior)'.
Top Customers (RFM) - Revenue: Top 10 customers by total spend. Frequency: Customers with the highest number of purchases.
Segment Revenue     - Total revenue grouped by the new age_segment to identify which demographic is most profitable.

👉 **[Reference for Customer Demographics](./queries/3_Customer_Demographics.sql>)**


# 👤 Author
**Edmundo Bejar** - Data Analyst & Test Analyst  
(https://www.linkedin.com/in/edmundo-bejar-3400691b) | (https://github.com/ebejar-pro)