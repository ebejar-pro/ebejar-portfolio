import pandas as pd
import matplotlib.pyplot as plt
from pathlib import Path

# -----------------------------
# Paths
# -----------------------------
BASE_DIR = Path.cwd().parent
DATA_DIR = BASE_DIR / "data"

# -----------------------------
# Load data
# -----------------------------

products = pd.read_csv(DATA_DIR / "products.csv")
sales = pd.read_csv(DATA_DIR / "sales.csv", parse_dates=["sale_date"])
suppliers = pd.read_csv(DATA_DIR / "suppliers.csv")

# -----------------------------
# Put tables in data frames
# -----------------------------

products = pd.DataFrame(products)

sales = pd.DataFrame(sales)

suppliers = pd.DataFrame(suppliers) 

# -----------------------------
# Merge Sales with Suppliers    
# -----------------------------
supplier_revenue = sales_profit.merge(suppliers, on="supplier_id", how="left")


# -----------------------------
# Aggregate Profit by Supplier
# -----------------------------
profit_by_supplier = (
    supplier_revenue.groupby("name")["total_profit"]
    .sum()
    .reset_index()
    .sort_values(by="total_profit", ascending=False)
)

print(profit_by_supplier)

# -----------------------------
# Visualization
# -----------------------------
plt.figure(figsize=(8, 5))
plt.bar(profit_by_supplier["name"], profit_by_supplier["total_profit"], color="skyblue")
plt.title("Top Suppliers by Profitability")
plt.xlabel("Supplier Name")
plt.ylabel("Total Profit ($)")
plt.xticks(rotation=45)
plt.tight_layout()
plt.show()