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
employees = pd.read_csv(DATA_DIR / "employees.csv")
products = pd.read_csv(DATA_DIR / "products.csv")
sales = pd.read_csv(DATA_DIR / "sales.csv", parse_dates=["sale_date"])
sales_commission = pd.read_csv(DATA_DIR / "sales_commission.csv", parse_dates=["created_at"])

# -----------------------------
# Processing functions
# -----------------------------
def calculate_sales_value(sales, products):
    df = sales.merge(products, on="product_id", how="left")
    df["sales_value"] = df["quantity"] * df["price"]
    return df

def calculate_employee_performance(employees, sales, commissions):
    sales_totals = sales.groupby("employee_id")["sales_value"].sum().reset_index()
    commission_totals = commissions.groupby("employee_id")["commission_amount"].sum().reset_index()

    perf = employees.merge(sales_totals, on="employee_id", how="left")
    perf = perf.merge(commission_totals, on="employee_id", how="left")

    return perf.fillna(0)

# -----------------------------
# Run analysis
# -----------------------------
sales_with_products = calculate_sales_value(sales, products)
performance = calculate_employee_performance(employees, sales_with_products, sales_commission)

print(performance)

# -------------------------------------------------------------
# Visualization 1: Sales vs Commission per Employee 
# -------------------------------------------------------------
plt.figure(figsize=(10, 6))

plt.scatter(
    performance["sales_value"],
    performance["commission_amount"],
    s=100
)

for _, row in performance.iterrows():
    plt.text(
        row["sales_value"],
        row["commission_amount"],
        row["name"],
        fontsize=9,
        ha="right"
    )

plt.title("Sales vs Commission by Employee")
plt.xlabel("Total Sales Value ($)")
plt.ylabel("Total Commission ($)")
plt.grid(True)
plt.show()

# -------------------------------------------------------------
# Visualization 2: Total Sales by Employee
# -------------------------------------------------------------
plt.figure(figsize=(10, 6))

plt.bar(
    performance["name"],
    performance["sales_value"]
)

plt.title("Total Sales Value by Employee")
plt.xlabel("Employee")
plt.ylabel("Sales Value ($)")
plt.xticks(rotation=45)
plt.tight_layout()
plt.show()


# -------------------------------------------------------------
# Visualization 3: Salary vs Commission   
# -------------------------------------------------------------
plt.figure(figsize=(10, 6))

plt.bar(performance["name"], performance["salary"], label="Salary")
plt.bar(
    performance["name"],
    performance["commission_amount"],
    bottom=performance["salary"],
    label="Commission"
)

plt.title("Employee Compensation Structure")
plt.xlabel("Employee")
plt.ylabel("Amount ($)")
plt.xticks(rotation=45)
plt.legend()
plt.tight_layout()
plt.show()

# -------------------------------------------------------------
# Visualization 4: Commission as % of Sales
# -------------------------------------------------------------
performance["commission_ratio"] = (
    performance["commission_amount"] / performance["sales_value"]
).fillna(0)

plt.figure(figsize=(10, 6))
plt.bar(
    performance["name"],
    performance["commission_ratio"] * 100
)

plt.title("Commission as % of Sales")
plt.xlabel("Employee")
plt.ylabel("Commission (%)")
plt.xticks(rotation=45)
plt.tight_layout()
plt.show()
