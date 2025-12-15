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

## Only employees with job_code 'SALES' sales and raise commissions
sales_employees = employees[employees["job_code"] == "SALES"]

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
    perf = sales_employees.merge(sales_totals, on="employee_id", how="left")
    perf = perf.merge(commission_totals, on="employee_id", how="left")

    return perf.fillna(0)

# -----------------------------
# Run analysis
# -----------------------------
sales_with_products = calculate_sales_value(sales, products)

performance_sales = performance.merge(
    sales_employees[["employee_id"]],
    on="employee_id",
    how="inner"
)

## sales performance only apply employees with job code 'SALES' 
assert (performance_sales["job_code"] == "SALES").all()

performance_sales = calculate_employee_performance(employees, sales_with_products, sales_commission)

print(performance_sales)

# -------------------------------------------------------------
# Visualization 1: Sales vs Commission per Employee 
# -------------------------------------------------------------
plt.figure(figsize=(10, 6))

plt.scatter(
    performance_sales["sales_value"],
    performance_sales["commission_amount"],
    s=100
)

for _, row in performance_sales.iterrows():
    plt.annotate(
        row["name"],
        (row["sales_value"], row["commission_amount"]),
        textcoords="offset points",
        xytext=(5,5)
    )

plt.title("Sales vs Commission by Employee")
plt.xlabel("Total Sales Value ($)")
plt.ylabel("Total Commission ($)")
plt.grid(True)
plt.show()

# -------------------------------------------------------------
# Visualization 2: Total Sales by Employee
# -------------------------------------------------------------
perf_sorted = performance_sales.sort_values("sales_value", ascending=False)

plt.figure(figsize=(10, 6))
plt.bar(perf_sorted["name"], perf_sorted["sales_value"])
plt.title("Total Sales Value by SALES Employees")
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
