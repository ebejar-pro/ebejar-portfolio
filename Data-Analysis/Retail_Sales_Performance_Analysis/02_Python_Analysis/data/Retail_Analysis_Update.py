import pandas as pd
import numpy as np
import sys # Added for logging redirection
import datetime # Added for timestamping the log

# --- 1. CONFIGURATION (Run this cell first) ---
FILES = {
    'sales': 'sales.csv',
    'customers': 'customers.csv',
    'employees': 'employees.csv',
    'products': 'products.csv',
    'sales_commission': 'sales_commission.csv'
}

import sys

def safe_print(message: str, file=sys.stdout):
    """
    Prints a message safely by replacing characters that can't be encoded.
    Prevents crashes when emojis or other Unicode symbols are not supported
    by the current output encoding.
    """
    try:
        print(message, file=file)
    except UnicodeEncodeError:
        # Replace unsupported characters with '?'
        safe_message = message.encode(file.encoding, errors='replace').decode(file.encoding)
        print(safe_message, file=file)

def load_data(files: dict) -> dict:
    """Loads all CSV files into a dictionary of pandas DataFrames."""
    data_frames = {}
    print("--- 1. Loading DataFrames ---")
    for name, path in files.items():
        try:
            if name == 'sales':
                try:
                    data_frames[name] = pd.read_csv(path, parse_dates=['sale_date', 'dispatch_date'])
                except Exception:
                    data_frames[name] = pd.read_csv(path)
                    safe_print("⚠️ Warning: Could not parse dates automatically for {name}. Data types need verification.")
            else:
                data_frames[name] = pd.read_csv(path)
            safe_print("✅ Loaded {name}: {len(data_frames[name]):,} rows.")
        except FileNotFoundError:
            safe_print("❌ ERROR: File not found at path: {path}")
            return None 
    return data_frames

def clean_and_inspect_data(dfs: dict):
    """Checks for nulls, duplicates, and verifies data types."""
    print("\n--- 2. Data Cleaning and Inspection ---")
    for name, df in dfs.items():
        print(f"\n[Table: {name}]")
        
        # Check for Nulls
        null_count = df.isnull().sum().sum()
        if null_count > 0:
            safe_print("⚠️ Warning: Found {null_count} total null values.")
        else:
            safe_print("✅ No null values found.")

        # Check for Duplicates
        duplicate_count = df.duplicated().sum()
        if duplicate_count > 0:
            safe_print("⚠️ Warning: Found {duplicate_count} duplicate rows. Dropping them.")
            dfs[name] = df.drop_duplicates()
        else:
            safe_print("✅ No exact duplicate rows found.")
        
        # Display Data Types
        print("Data Types:")
        print(df.dtypes)
        
        # CRITICAL INSPECTION: Print column names
        if name == 'products':
             print("\n!!! CHECK: PRODUCTS COLUMNS !!!")
             print(df.columns.tolist())
        if name == 'employees':
             print("\n!!! CHECK: EMPLOYEES COLUMNS !!!")
             print(df.columns.tolist())
        if name == 'customers':
             print("\n!!! CHECK: CUSTOMERS COLUMNS !!!")
             print(df.columns.tolist())


def merge_data(dfs: dict) -> pd.DataFrame:
    """
    Merges all relevant tables into a single master analysis DataFrame.
    """
    print("\n--- 3. Merging DataFrames (Star Schema Join) ---")

    # 1. Merge Sales (Fact) with Products (Dimensions)
    # We rely on your updated CSV having the 'category' column now.
    master_df = dfs['sales'].merge(
        dfs['products'][['product_id', 'product_name', 'price', 'cost_price', 'category']],
        on='product_id',
        how='left',
        suffixes=('_sales', '_product')
    )

    # 2. Merge with Employees
    # Correctly using 'job_code' instead of 'department'
    master_df = master_df.merge(
        dfs['employees'][['employee_id', 'name', 'job_code']], 
        on='employee_id',
        how='left'
    ).rename(columns={'name': 'employee_name'}) 

    # 3. Merge with Customers
    # FIX: Corrected to use 'name' instead of 'first_name'/'last_name' and removed 'city' 
    # based on user feedback about the actual CSV structure.
    master_df = master_df.merge(
        dfs['customers'][['customer_id', 'name', 'age']],
        on='customer_id',
        how='left'
    ).rename(columns={'name': 'customer_name'}) # Rename 'name' column for clarity
    
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
    
    # Define the log file path
    log_file_path = "retail_analysis_log.txt"
    original_stdout = sys.stdout # Save the original stdout

    try:
        # 1. Redirect all print output to the log file
        with open(log_file_path, 'w') as f:
            sys.stdout = f # Change the standard output to the file stream
            
            print(f"--- RETAIL ANALYSIS LOG STARTED: {datetime.datetime.now()} ---")
            
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
                print("\n--- 5. Final Master Data Preview (First 5 Rows) ---")
                # Ensure the DataFrame is converted to string for logging
                print(final_df[['sale_id', 'sale_date', 'customer_name', 'age', 'employee_name', 'job_code', 'product_name', 'category', 'Revenue']].head().to_string())
            
            print(f"\n--- RETAIL ANALYSIS LOG FINISHED: {datetime.datetime.now()} ---")
            
    except Exception as e:
        # Print errors to the console (original stdout) even if logging failed
        sys.stdout = original_stdout
        print(f"An error occurred during execution: {e}")
        
    finally:
        # 2. Reset stdout to the original value (the Jupyter cell output)
        sys.stdout = original_stdout
        print(f"\n--- LOGGING COMPLETE ---")
        print(f"All output has been saved to: {log_file_path}")
        
        ERROR: An error occurred during execution: 'charmap' codec can't encode character '\u2705' in position 0: character maps to <undefined>
        