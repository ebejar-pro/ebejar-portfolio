-- Create costs table
create table if not exists costs(
    cost_id integer primary key,
    sales_person text,
    cost_amount real,
    sales_id integer not null,
    foreign key (sales_id) references sales (sales_id)
    );
    
-- Display table structure
PRAGMA table_info(costs);

-- Populate costs table from sales table
INSERT INTO costs (sales_person, cost_amount, sales_id)
SELECT
    sales_person,
    sale_amount * 0.30 AS cost_amount,
    sales_id
FROM sales;

select * from costs;

-- join costs and sales
SELECT
    s.sales_id,
    s.sales_person,
    s.sale_amount,
    c.cost_amount
FROM sales s
JOIN costs c ON s.sales_id = c.sales_id;

--Prevent duplicagtes
INSERT INTO costs (sales_person, cost_amount, sales_id)
SELECT
    s.sales_person,
    ROUND(s.sale_amount * 0.30,2)as cost_amount,
    s.sales_id
FROM sales s
WHERE NOT EXISTS (
    SELECT 1
    FROM costs c
    WHERE c.sales_id = s.sales_id
);

update sales
set sale_amount = ROUND(sale_amount,2);

update costs
set cost_amount = ROUND(cost_amount,2);


select * from sales;

select * from costs;