mport pandas as pd
import numpy as np

# --- 1. CONFIGURATION (Run this cell first) ---
# Define the file paths for your five CSV files.
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
                # Error handling for the case where date columns might not exist yet or are incorrectly formatted
                try:
                    # Attempt to parse dates for sales.csv
                    data_frames[name] = pd.read_csv(path, parse_dates=['sale_date', 'dispatch_date'])
                except Exception:
                    # Fallback if date parsing fails
                    data_frames[name] = pd.read_csv(path)
                    print(f"⚠️ Warning: Could not parse dates automatically for {name}. Data types need verification.")
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
        else:
            print("✅ No null values found.")

        # Check for Duplicates
        duplicate_count = df.duplicated().sum()
        if duplicate_count > 0:
            print(f"⚠️ Warning: Found {duplicate_count} duplicate rows. Dropping them.")
            dfs[name] = df.drop_duplicates()
        else:
            print("✅ No exact duplicate rows found.")
        
        # Display Data Types
        print("Data Types:")
        print(df.dtypes)
        
        # CRITICAL INSPECTION: Print column names to confirm structure
        if name == 'products':
             print("\n!!! CRITICAL CHECK: PRODUCTS COLUMNS FOUND !!!")
             print(df.columns.tolist())


def merge_data(dfs: dict) -> pd.DataFrame:
    """
    Merges all relevant tables into a single master analysis DataFrame.
    """
    print("\n--- 3. Merging DataFrames (Star Schema Join) ---")

    # --- FIX FOR MISSING 'CATEGORY' COLUMN ---
    # Since 'category' is missing, we add a placeholder column to the products DataFrame
    # so downstream analysis (like grouping) can still proceed without KeyError.
    if 'category' not in dfs['products'].columns:
        dfs['products']['category'] = 'Uncategorized'
        print("⚠️ WARNING: 'category' column was missing in products.csv. Added 'Uncategorized' placeholder column to proceed.")
    # --- END FIX ---
    
    # 1. Merge Sales (Fact) with Products (Dimensions)
    # Now we can safely select 'category' (which is now guaranteed to exist)
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
    ).rename(columns={'name': 'employee_name'}) 

    # 3. Merge with Customers
    master_df = master_df.merge(
        dfs['customers'][['customer_id', 'first_name', 'last_name', 'age', 'city']],
        on='customer_id',
        how='left'
    ).rename(columns={'first_name': 'customer_first_name', 'last_name': 'customer_last_name'})
    
    print(f"✅ Final Master DataFrame created with {len(master_df):,} rows.")
    return master_df

def feature_engineer_financials(df: pd.DataFrame) -> pd.DataFrame:
    """Creates core financial columns (Revenue, COGS, Profit, Fulfillment Days)."""
    print("\n--- 4. Feature Engineering: Financial Metrics ---")
    
    # Calculate Total Revenue for each sale row
    df['Revenue'] = df['quantity'] * df['price']
    
    # Calculate Total Cost of Goods Sold (COGS)
    df['COGS'] = df['quantity'] * df['cost_price']
    
    # Calculate Total Profit (Gross Margin)
    df['Profit'] = df['Revenue'] - df['COGS']
    
    # Calculate the Fulfillment Latency
    df['Fulfillment_Days'] = (df['dispatch_date'] - df['sale_date']).dt.days

    print("✅ New columns created: Revenue, COGS, Profit, Fulfillment_Days.")
    
    # Display quick summary of new columns
    print("\nQuick Financial Summary:")
    print(f"Total Revenue: ${df['Revenue'].sum():,.2f}")
    print(f"Total Profit: ${df['Profit'].sum():,.2f}")
    
    return df

# --- 5. EXECUTION BLOCK (Run this cell last) ---
if __name__ == "__main__":
    # Load all data
    dfs = load_data(FILES)

    if dfs:
        # Inspect and clean 
        clean_and_inspect_data(dfs)

        # Merge into a single analysis table
        master_df = merge_data(dfs)

        # Create financial calculation columns
        final_df = feature_engineer_financials(master_df)

        # Display the first few rows of the final dataset
        print("\n--- 5. Final Master Data Preview ---")
        # Note: 'sale_name' column was likely a typo in the original prompt, replacing with 'product_name' for safety
        print(final_df[['sale_id', 'sale_date', 'employee_name', 'product_name', 'category', 'Revenue', 'Profit', 'Fulfillment_Days']].head())