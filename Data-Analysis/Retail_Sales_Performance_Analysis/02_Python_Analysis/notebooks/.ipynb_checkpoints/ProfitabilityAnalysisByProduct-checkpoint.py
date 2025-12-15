import pandas as pd
import matplotlib.pyplot as plt

# -----------------------------
# 1. Sample Products Table
# -----------------------------
products_data = {
    "product_id": [1, 2, 3, 4],
    "product_name": ["Laptop", "Phone", "Tablet", "Headphones"],
    "price": [1200.00, 800.00, 400.00, 150.00],
    "cost_price": [700.00, 450.00, 250.00, 80.00],
    "stock_level": [25, 43, 60, 100],
    "category": ["Electronics", "Electronics", "Electronics", "Accessories"]
}
products = pd.DataFrame(products_data)

# -----------------------------
# 2. Sample Sales Table
# -----------------------------
sales_data = {
    "sale_id": [101, 102, 103, 104, 105],
    "product_id": [1, 2, 2, 3, 4],
    "quantity": [2, 3, 1, 5, 10],
    "sale_date": pd.to_datetime(["2025-09-12", "2025-09-13", "2025-09-14", "2025-09-15", "2025-09-16"])
}
sales = pd.DataFrame(sales_data)

# -----------------------------
# 3. Calculate Profit Margin
# -----------------------------
products["profit_margin"] = products["price"] - products["cost_price"]

# -----------------------------
# 4. Merge Sales with Products
# -----------------------------
sales_profit = sales.merge(products, on="product_id", how="left")

# -----------------------------
# 5. Compute Total Profit
# -----------------------------
sales_profit["total_profit"] = sales_profit["profit_margin"] * sales_profit["quantity"]

# -----------------------------
# 6. Aggregate Profit by Product
# -----------------------------
profit_by_product = (
    sales_profit.groupby("product_name")["total_profit"]
    .sum()
    .reset_index()
    .sort_values(by="total_profit", ascending=False)
)

print(profit_by_product)

# -----------------------------
# 7. Visualization
# -----------------------------
plt.figure(figsize=(8, 5))
plt.bar(profit_by_product["product_name"], profit_by_product["total_profit"], color="skyblue")
plt.title("Top Products by Profitability")
plt.xlabel("Product")
plt.ylabel("Total Profit ($)")
plt.xticks(rotation=45)
plt.tight_layout()
plt.show()