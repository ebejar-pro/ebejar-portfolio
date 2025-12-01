
# Scenario 2: Product & Inventory Efficiency

## 🎯 Business Question
Which products are the most profitable, and which suppliers are impacting our inventory levels?

## 2.1 Profit Margin Report
Calculated net profit and gross margin percentage per product.

### 🧠 SQL Logic Used
```sql

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
```

### 📊 Gross Marging By Product 

|product_name|selling_price|cost_price|profit_per_unit|margin_percentage|total_units_sold|
|------------|-------------|----------|---------------|-----------------|----------------|
|Kitchen Mixer|249.00|110.00|139.00|55.82|39|
|Vacuum Cleaner|199.50|90.00|109.50|54.89|54|
|Electric Shaver|99.50|45.50|54.00|54.27|45|
|Smart TV 55"|899.50|500.00|399.50|44.41|48|
|Phone|800.00|450.00|350.00|43.75|67|
|Coffee Machine|349.50|200.00|149.50|42.78|41|
|Air Conditioner|1199.00|700.00|499.00|41.62|60|
|Microwave Oven|169.00|100.00|69.00|40.83|30|
|Gaming Console|579.00|350.00|229.00|39.55|39|
|Electric Scooter|899.00|550.00|349.00|38.82|45|
|Wireless Speaker|129.90|80.50|49.40|38.03|48|
|Washing Machine|799.00|500.00|299.00|37.42|52|
|Laptop|1200.00|800.00|400.00|33.33|53|

### 💡 Insights

- **Kitchen Mixer** provides the highest margin profit percentage by product (55.82%).

- **Laptop** provides the lowest margin profit percentage (33.33%) although is the item with highest profit by unit ($400.00).

- **Phone** is the highest items sold (67).


## 2.2 Stock Turnover Report
List of products where stock_level is below a set threshold (e.g., < 50), flagging potential re-order needs.

### 🧠 SQL Logic Used
```sql

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
```

### 📊 Stock Levels for Re-Ordering Report

|product_name|supplier_name|stock_level|stock_status|
|------------|-------------|-----------|------------|
|Air Conditioner|ConsultingMBNP|0|Out of Stock - Urgent|
|Electric Shaver|GadgetWorld|5|Critical Low|
|Gaming Console|ElectronicsLim|6|Critical Low|
|Kitchen Mixer|Express Ltd|21|Critical Low|
|Smart TV 55"|ConsultingABC|22|Critical Low|
|Microwave Oven|LabTechUltimo Ltd|30|Reorder Soon|
|Washing Machine|LabTechnos Ltd|32|Reorder Soon|
|Vacuum Cleaner|ConsultingXYZ|36|Reorder Soon|
|Phone|TechSource Ltd|43|Reorder Soon|


### 💡 Insights

- **Air Conditioner** is Out of Stock requieres urgent re-ordering (0).

- There are 4 products (Electric Shaver, Gaming Console, Kitchen Mixer, and Smart TV 55") with stock level 'Critical Low'.

- There are 4 products (Microwave Oven, Washing Machine, Vacuum Cleaner, and Phone) with stock level 'Reorder Soon'.


## 2.3 Supplier Reliability Report
Ranked suppliers by total volume supplied and cost price.

### 🧠 SQL Logic Used
```sql

SELECT 
    sp.name as supplier_name, 
    SUM(s.quantity) AS total_items_supplied,
    SUM(s.quantity * p.cost_price) AS total_items_cost
FROM suppliers sp
JOIN sales s ON s.supplier_id = sp.supplier_id
JOIN products p ON s.supplier_id = p.supplier_id
GROUP BY sp.name
ORDER by total_items_cost DESC;

```

### 📊 Total Items Supplied and Total Cost Report

|supplier_name|total_items_supplied|total_items_cost|
|-------------|--------------------|----------|
|TechSource Ltd|70|43750.00|
|ConsultingABC|69|34500.00|
|TelcoABC|55|30250.00|
|ConsultingMBNP|38|26600.00|
|ElectronicsLim|66|23100.00|
|LabTechnos Ltd|44|22000.00|
|UTSTech Ltd|54|10800.00|
|LabTechUltimo Ltd|64|6400.00|
|LabTech Ltd|64|5152.00|
|Express Ltd|40|4400.00|
|ConsultingXYZ|38|3420.00|
|GadgetWorld|54|2457.00|


### 💡 Insights

- **TechSource Ltd** is the supplier with the highest total items cost and volume of items supplied.

- **GadgetWorld** is the supplier with the lowest total items cost.
