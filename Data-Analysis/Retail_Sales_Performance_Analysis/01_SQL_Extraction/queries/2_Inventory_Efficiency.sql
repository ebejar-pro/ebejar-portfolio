-- =============================================
-- SCENARIO 2: PRODUCT & INVENTORY EFFICIENCY
-- =============================================

-- 1. Product Profitability Analysis
-- Calculates Gross Margin for each product
SELECT 
    p.product_name,
    p.price AS selling_price,
    p.cost_price,
    (p.price - p.cost_price) AS profit_per_unit,
    ROUND(((p.price - p.cost_price) / p.price) * 100, 2) AS margin_percentage,
    SUM(s.quantity) AS total_units_sold
FROM products p
LEFT JOIN sales s ON p.product_id = s.product_id
GROUP BY p.product_id, p.product_name, p.price, p.cost_price
ORDER BY margin_percentage DESC;

-- 2. Low Stock Alert
-- Flags products that need re-ordering (Stock < 50)
SELECT 
    p.product_name,
    s.name AS supplier_name,
    p.stock_level,
    CASE 
        WHEN p.stock_level = 0 THEN 'Out of Stock - Urgent'
        WHEN p.stock_level < 30 THEN 'Critical Low'
        WHEN p.stock_level < 50 THEN 'Reorder Soon'
        ELSE 'Healthy'
    END AS stock_status
FROM products p
JOIN suppliers s ON p.supplier_id = s.supplier_id
WHERE p.stock_level < 50
ORDER BY p.stock_level ASC;


-- 3. Ranking Suppliers based on total number of items sold
-- Ranks suppliers on  by the total revenue they generated
SELECT 
    sp.name as supplier_name, 
    SUM(s.quantity) AS total_items_supplied,
    SUM(s.quantity * p.cost_price) AS total_items_cost
FROM suppliers sp
JOIN sales s ON s.supplier_id = sp.supplier_id
JOIN products p ON s.supplier_id = p.supplier_id
GROUP BY sp.name
ORDER by total_items_cost DESC;

select * from products;

select * from sales;

select * from suppliers;