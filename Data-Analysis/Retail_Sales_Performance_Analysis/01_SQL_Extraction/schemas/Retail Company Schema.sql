-- ====================================================================
-- RETAIL COMPANY DATA MODEL - SCHEMA CREATION SCRIPT
-- Based on the provided ER Diagram and Table Properties
-- ====================================================================

-- 1. DROP TABLES (Safety feature for re-running the script)
-- Drop tables in reverse order of dependency to avoid foreign key errors
DROP TABLE IF EXISTS sales_commission;
DROP TABLE IF EXISTS sales;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS suppliers;
DROP VIEW IF EXISTS vw_sales_summary;


-- ====================================================================
-- CORE DIMENSION TABLES
-- ====================================================================

-- Table: suppliers
CREATE TABLE suppliers (
    supplier_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    contact_email VARCHAR(100),
    phone VARCHAR(20),
    country VARCHAR(50)
);

-- Table: customers
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    age INT,
    -- Constraint: Ensure age is reasonable
    CONSTRAINT chk_customer_age CHECK (age >= 18 AND age <= 120)
);

-- Table: employees
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    salary NUMERIC(10, 2) NOT NULL,
    job_code VARCHAR(20),
    commission NUMERIC(10, 2) DEFAULT 0.00,
    
    -- Constraint: Enforce specific job codes as seen in your data
    CONSTRAINT employees_job_code_check CHECK (job_code IN ('MGR', 'ADMIN', 'TECH', 'SALES'))
);

-- Table: products
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price NUMERIC(10, 2) NOT NULL,
    supplier_id INT NOT NULL,
    cost_price NUMERIC(10, 2),
    stock_level INT,
    
    -- Foreign Key to Suppliers
    CONSTRAINT fk_supplier
        FOREIGN KEY (supplier_id)
        REFERENCES suppliers (supplier_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
        
    -- Constraint: Price must be greater than zero
    CONSTRAINT chk_product_price CHECK (price > 0)
);


-- ====================================================================
-- FACT/TRANSACTION TABLES
-- ====================================================================

-- Table: sales
CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    sale_date DATE NOT NULL,
    quantity INT NOT NULL,
    employee_id INT NOT NULL,
    supplier_id INT NOT NULL,
    sales_channel VARCHAR(20),
    dispatch_date DATE,
    
    -- Foreign Keys
    CONSTRAINT sales_customer_id_fkey
        FOREIGN KEY (customer_id)
        REFERENCES customers (customer_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT sales_product_id_fkey
        FOREIGN KEY (product_id)
        REFERENCES products (product_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
        
    CONSTRAINT fk_sales_employee
        FOREIGN KEY (employee_id)
        REFERENCES employees (employee_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
        
    -- NOTE: Though supplier_id is in sales, it's often better practice 
    -- to link sales -> product -> supplier, but we include it here 
    -- as per your diagram/data structure.
    CONSTRAINT fk_sales_supplier
        FOREIGN KEY (supplier_id)
        REFERENCES suppliers (supplier_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    -- Constraint: Dispatch date cannot be before sale date
    CONSTRAINT chk_dispatch_date CHECK (dispatch_date IS NULL OR dispatch_date >= sale_date)
);

-- Table: sales_commission (The table previously discussed)
CREATE TABLE sales_commission (
    commission_id SERIAL PRIMARY KEY,
    employee_id INT NOT NULL,
    sale_id INT NOT NULL UNIQUE,
    commission_amount NUMERIC(10, 2) NOT NULL,
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,

    -- Constraints
    CONSTRAINT fk_commission_employee
        FOREIGN KEY (employee_id)
        REFERENCES employees (employee_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT, 

    CONSTRAINT fk_commission_sale
        FOREIGN KEY (sale_id)
        REFERENCES sales (sale_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE 
);


-- ====================================================================
-- VIEW FOR REPORTING (vw_sales_summary)
-- ====================================================================

-- This view joins key tables to provide a flattened summary for analysis
CREATE VIEW vw_sales_summary AS
SELECT
    c.name AS customer,
    p.product_name,
    e.name AS salesperson,
    s.quantity,
    s.sale_date
FROM
    sales s
JOIN
    customers c ON s.customer_id = c.customer_id
JOIN
    products p ON s.product_id = p.product_id
JOIN
    employees e ON s.employee_id = e.employee_id;