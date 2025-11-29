🛠️ Phase 1: Data Engineering & Logic

📄 Objective

The primary objective of this phase was to architect a scalable Relational Database Management System (RDBMS) for a retail organization. This involved designing the Entity-Relationship (ER) model, establishing constraints to ensure data integrity, and generating synthetic data to simulate real-world reporting scenarios.

We leveraged PostgreSQL to handle complex logic, including stored procedures for automated commission calculations and schema modifications to support supply chain analysis (Online vs. Retail).

1. Schema Design & Integrity

Problem: The project required a reliable, normalized foundation for analysis (separating Fact and Dimension tables).

Solution: Designed and implemented a Star Schema architecture including Customers, Employees, Products, Suppliers, Sales, and Sales_Commission tables. We enforced Primary Keys (PK) and Foreign Keys (FK) to guarantee referential integrity (e.g., preventing "orphan" sales records).

👉 View Schema Creation Script

2. Schema Modification (Adding Dimensions)

Problem: The original raw data lacked essential business dimensions (sales_channel and dispatch_date) required to analyze supply chain efficiency.

Solution: Executed ALTER TABLE commands to append these fields, preparing the dataset for Fulfillment Latency and Channel Performance reporting.

3. Automated Commission Logic (Stored Procedure)

Problem: The business required an auditable, automated method to calculate sales commissions (5% of sale value) while adhering to complex business rules (e.g., preventing double-payments and handling exclusion lists for specific Employee IDs).

Solution: Developed the record_sale_commission Stored Procedure. This logic is triggered automatically upon new sales entries to ensure real-time payroll accuracy.

👉 View Stored Procedure Logic

👉 View Trigger Function

4. Data Population & Validation

Problem: The initial dataset was too sparse (only 15 records) to perform meaningful demographic or trend analysis.

Solution: Engineered a PostgreSQL function (generate_sales_data()) to programmatically insert 200+ sales records and 40+ new customers. The function utilized randomization logic to create realistic age distributions and purchase dates, ensuring a robust dataset for Power BI.

👉 View Data Generation Script

📊 Business Scenarios Solved

Scenario 1: Employee Incentive & Performance

Business Question: How effective is the sales team, and how is their commission distributed across different sales channels?

Commission Payout: Calculated total commission earned per salesperson.

Performance Rank: Ranked salespeople by total revenue generated using Window Functions.

Sales Channel Split: Analyzed the % of sales via 'Retail' vs. 'Online' for each employee.

👉 View Employee Performance Queries

Scenario 2: Product & Inventory Efficiency

Business Question: Which products are the most profitable, and which suppliers are impacting our inventory levels?

Profit Margin: Calculated Net Profit and Gross Margin % per product.

Stock Turnover: Identified products with stock_level < 50 to flag re-order needs.

Supplier Reliability: Ranked suppliers by volume and fulfillment speed.

👉 View Inventory Efficiency Queries

Scenario 3: Customer Segmentation & Demographics

Business Question: Who are our most valuable customers, and what are their demographic characteristics?

Age Buckets: Segmented customers into '18-30 (Young)', '31-55 (Core)', and '56+ (Senior)'.

Top Customers (RFM): Identified top 10 customers by Revenue and Frequency.

Segment Revenue: Aggregated total revenue by Age Segment to find the most profitable demographic.

👉 View Customer Demographic Queries

👤 Author

Edmundo Bejar - Data Analyst & Test Analyst

LinkedIn Profile | GitHub Portfolio