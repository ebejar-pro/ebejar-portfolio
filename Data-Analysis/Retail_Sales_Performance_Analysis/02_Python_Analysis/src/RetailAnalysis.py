import pandas as pd
import numpy as np

# --- 1. CONFIGURATION ---
# Define the file paths for your five CSV files.
# ASSUMPTION: These files are in the same directory as this script.
FILES = {
    'sales': 'sales.csv',
    'customers': 'customers.csv',
    'employees': 'employees.csv',
    'products': 'products.csv',
    'sales_commission': 'sales_commission.csv'
}

def load_data(files: dict) -> dict:
    """Loads all CSV files into a dictionary of pandas DataFrames."""
    data_frames = {}
    print("--- 1. Loading DataFrames ---")
    for name, path in files.items():
        try:
            # We assume sales_date and dispatch_date are present in sales.csv
            if name == 'sales':
                data_frames[name] = pd.read_csv(path, parse_dates=['sale_date', 'dispatch_date'])
            else:
                data_frames[name] = pd.read_csv(path)
            print(f"✅ Loaded {name}: {len(data_frames[name]):,} rows.")
        except FileNotFoundError:
            print(f"❌ ERROR: File not found at path: {path}")
            return None # Exit if critical file is missing
    return data_frames

def clean_and_inspect_data(dfs: dict):
    """Checks for nulls, duplicates, and verifies data types."""
    print("\n--- 2. Data Cleaning and Inspection ---")
    for name, df in dfs.items():
        print(f"\n[Table: {name}]")
        
        # Check for Nulls
        null_count = df.isnull().sum().sum()
        if null_count > 0:
            print(f"⚠️ Warning: Found {null_count} total null values.")
            # Optional: Impute or drop nulls here if necessary
        else:
            print("✅ No null values found.")

        # Check for Duplicates (based on all columns)
        duplicate_count = df.duplicated().sum()
        if duplicate_count > 0:
            print(f"⚠️ Warning: Found {duplicate_count} duplicate rows. Dropping them.")
            dfs[name] = df.drop_duplicates()
        else:
            print("✅ No exact duplicate rows found.")
        
        # Display Data Types
        print("Data Types:")
        print(df.dtypes)

def merge_data(dfs: dict) -> pd.DataFrame:
    """
    Merges all relevant tables into a single master analysis DataFrame.
    Uses the Star Schema joins (Fact table `sales` to Dimension tables).
    """
    print("\n--- 3. Merging DataFrames (Star Schema Join) ---")

    # 1. Merge Sales (Fact) with Products and Employees (Dimensions)
    # We start with sales as the central fact table
    master_df = dfs['sales'].merge(
        dfs['products'][['product_id', 'product_name', 'price', 'cost_price', 'category']],
        on='product_id',
        how='left',
        suffixes=('_sales', '_product')
    )
    
    # 2. Merge with Employees
    master_df = master_df.merge(
        dfs['employees'][['employee_id', 'name', 'department']],
        on='employee_id',
        how='left'
    ).rename(columns={'name': 'employee_name'}) # Rename 'name' to avoid confusion

    # 3. Merge with Customers
    master_df = master_df.merge(
        dfs['customers'][['customer_id', 'first_name', 'last_name', 'age', 'city']],
        on='customer_id',
        how='left'
    ).rename(columns={'first_name': 'customer_first_name', 'last_name': 'customer_last_name'})

    # 4. Optional: Merge Sales Commission (Use this later for validation)
    # For now, we keep the main analysis DF focused on the core transaction details
    
    print(f"✅ Final Master DataFrame created with {len(master_df):,} rows.")
    print("Columns in Master DF (Ready for calculation):")
    print(master_df.columns.tolist())
    return master_df

def feature_engineer_financials(df: pd.DataFrame) -> pd.DataFrame:
    """Creates core financial columns (Revenue, COGS, Profit) using NumPy/Pandas vectorization."""
    print("\n--- 4. Feature Engineering: Financial Metrics ---")
    
    # Calculate Total Revenue for each sale row
    # Price is the selling price
    df['Revenue'] = df['quantity'] * df['price']
    
    # Calculate Total Cost of Goods Sold (COGS)
    # cost_price is the cost to the retailer
    df['COGS'] = df['quantity'] * df['cost_price']
    
    # Calculate Total Profit (Gross Margin)
    df['Profit'] = df['Revenue'] - df['COGS']
    
    # Calculate the Fulfillment Latency (same as your calculated column in Power BI)
    df['Fulfillment_Days'] = (df['dispatch_date'] - df['sale_date']).dt.days

    print("✅ New columns created: Revenue, COGS, Profit, Fulfillment_Days.")
    
    # Display quick summary of new columns
    print("\nQuick Financial Summary:")
    print(f"Total Revenue: ${df['Revenue'].sum():,.2f}")
    print(f"Total Profit: ${df['Profit'].sum():,.2f}")
    print(f"Avg Profit per Sale: ${df['Profit'].mean():,.2f}")
    
    return df

# --- 5. MAIN EXECUTION BLOCK ---
if __name__ == "__main__":
    # Load all data
    dfs = load_data(FILES)

    if dfs:
        # Inspect and clean (drop duplicates)
        clean_and_inspect_data(dfs)

        # Merge into a single analysis table
        master_df = merge_data(dfs)

        # Create financial calculation columns
        final_df = feature_engineer_financials(master_df)

        # The final_df is now ready for Scenario 2 & 3 Analysis!
        
        # Display the first few rows of the final dataset
        print("\n--- 5. Final Master Data Preview ---")
        print(final_df[['sale_id', 'sale_date', 'employee_name', 'product_name', 'Revenue', 'Profit', 'Fulfillment_Days']].head())