

# 🧍 Customer Demographics & Sales Behaviour Dashboard  

This section provides insights into **operational efficiency**, including shipping performance, dispatch timelines, supplier contribution, and stock-movement risk.
Built using **Power BI**, the dashboard focuses on evaluating how effectively the business moves products from supplier → warehouse → customer.

---
## 🔍 Key Business Questions Answered
- How quickly customer orders are processed and dispatched?
- Which sales channel performs better in fulfilling orders?
- Which suppliers contribute the most value?
- How are the indicators for product depletion, stock issues, and replenishment needs
- What are the products requiring urgent replenishment?
---

## 🚚 **5.1. Order-to-Dispatch Performance**

### **Business Purpose**

Measure how quickly customer orders are processed and dispatched.

### **Key Metrics**

* **Dispatch Latency (Days):** Difference between sale date and dispatch date
* **Average Dispatch Latency by Month**
* **Channel comparison:** Online vs Retail

### **Visuals**

* **Line Chart:** Avg dispatch latency over time
* **Legend:** Online / Retail

---

## 🎯 **5.2. Fulfillment Channel Efficiency**

### **Business Purpose**

Evaluate which sales channel performs better in fulfilling orders.

### **Key Metrics**

* Total Orders
* Orders by Channel
* Orders Online % vs Orders Retail %

### **Visual**

* **Donut Chart:** Orders by channel

---

## 🏭 **5.3. Supplier Delivery Performance**

### **Business Purpose**

Identify which suppliers contribute the most value.

### **Key Metrics**

* Supplier Value = Σ (quantity × product price)
* Supplier Ranking

### **Visual**

* **Bar Chart:** Supplier Value
* **Sorted DESC**

---

## 📉 **5.4. Inventory Movement & Risk**

### **Business Purpose**

Monitor product depletion, stock issues, and replenishment needs.

### **Key Metrics**

* Units Sold per Product
* Stock Level % Sold
* Low Stock Risk
* Out of Stock Flag
* Days Until Out of Stock
* Reorder Needed

### **Visual**

* **Line Chart:** Stock Level % Sold
* **Conditional Color:** High depletion → red

---

## 🔁 **5.5. Replenishment Simulation**

### **Business Purpose**

Estimate future stock outages and identify products requiring urgent replenishment.

### **Key Metrics**

* Days Until Out of Stock
* Reorder Flag
* Overall Inventory Stability Score

---

# 📊 **Dashboard Mockup (Included in Project)**

The dashboard includes all visuals described above:

* Order-to-Dispatch Trend
* Fulfillment Efficiency Donut
* Supplier Delivery Performance
* Inventory Depletion Line Chart

---

# 🧠 **How to Use**

Data is sourced from:

* **PostgreSQL SQL project**
* Exported as **CSV**
* Loaded and modeled in Power BI
* Measures in **./DAX files** folder

---

# 🎯 **Outcome**

This section demonstrates my ability to perform:

* Operational analytics
* KPI-driven reporting
* DAX modeling
* Inventory and logistics insights
* Supplier performance evaluation


---

