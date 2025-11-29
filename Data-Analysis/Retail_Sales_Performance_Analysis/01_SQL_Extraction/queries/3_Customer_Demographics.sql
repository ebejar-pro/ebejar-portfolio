-- =============================================
-- SCENARIO 3: CUSTOMER SEGMENTATION
-- =============================================

-- 1. Revenue by Age Group
-- Groups customers into buckets to find the most profitable demographic
SELECT 
    CASE 
        WHEN c.age BETWEEN 18 AND 30 THEN '18-30 (Young Adults)'
        WHEN c.age BETWEEN 31 AND 55 THEN '31-55 (Core Consumers)'
        WHEN c.age >= 56 THEN '56+ (Seniors)'
        ELSE 'Unknown'
    END AS age_group,
    COUNT(DISTINCT c.customer_id) AS customer_count,
    SUM(s.quantity * p.price) AS total_revenue
FROM customers c
JOIN sales s ON c.customer_id = s.customer_id
JOIN products p ON s.product_id = p.product_id
GROUP BY 1
ORDER BY total_revenue DESC;

-- 2. Top 10 High-Value Customers (RFM Proxy)
-- Finds customers with high spend and frequency
SELECT 
    c.name,
    c.email,
    COUNT(s.sale_id) AS purchase_frequency,
    SUM(s.quantity * p.price) AS total_lifetime_value
FROM customers c
JOIN sales s ON c.customer_id = s.customer_id
JOIN products p ON s.product_id = p.product_id
GROUP BY c.customer_id, c.name, c.email
ORDER BY total_lifetime_value DESC
LIMIT 10;