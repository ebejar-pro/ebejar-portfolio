-- Create Product Dimension (Corrected Column Count)
CREATE OR REPLACE TABLE `bq-analysis-04.retail_silver.dim_products` AS
SELECT 'PROD-001' as product_id, 'Espresso Machine' as product_name, 'Appliances' as category, 299.00 as cost UNION ALL
SELECT 'PROD-002', 'Coffee Grinder', 'Kitchenware', 89.00 UNION ALL -- Fixed: category and cost
SELECT 'PROD-003', 'Aeropress', 'Kitchenware', 45.00;