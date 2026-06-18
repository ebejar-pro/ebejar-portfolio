import pandas as pd
import numpy as np

# Customers
customers = pd.DataFrame({
    "id": range(1, 101),
    "name": [f"Customer {i}" for i in range(1, 101)],
    "email": [f"customer{i}@example.com" for i in range(1, 101)],
    "phone": ["0400000000"] * 100,
    "address": ["123 Example St"] * 100,
    "suburb": ["Sydney"] * 100,
    "state": ["NSW"] * 100,
    "postcode": ["2000"] * 100
})
customers.to_csv("customers.csv", index=False)

# Products
products = pd.DataFrame({
    "id": range(1, 51),
    "name": [f"Product {i}" for i in range(1, 51)],
    "price": np.random.uniform(5, 500, 50).round(2),
    "current_stock_level": np.random.randint(0, 500, 50),
    "minimum_stock_level": np.random.randint(5, 50, 50)
})
products.to_csv("products.csv", index=False)

# Orders
orders = pd.DataFrame({
    "id": range(1, 201),
    "customer_id": np.random.randint(1, 101, 200),
    "date": pd.date_range("2024-01-01", periods=200).astype(str),
    "sales_channel": np.random.choice(["Online", "Store", "Phone"], 200),
    "total_order": np.random.uniform(20, 1000, 200).round(2)
})
orders.to_csv("orders.csv", index=False)

# Order Items
order_items = pd.DataFrame({
    "id": range(1, 501),
    "order_id": np.random.randint(1, 201, 500),
    "product_id": np.random.randint(1, 51, 500),
    "quantity": np.random.randint(1, 10, 500)
})
order_items.to_csv("order_items.csv", index=False)
