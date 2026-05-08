from src.extract import extract_raw_csv
from src.transform import clean_dataframe
from src.validate import apply_validation
from src.load import enrich, save_output

from config.config import (
    RAW_PATH, BRONZE_PATH, SILVER_PATH,
    GOLD_PATH, QUARANTINE_PATH
)

import logging

def run_etl():
    logging.info("Starting ETL pipeline")

    # 1. Extract
    df_raw = extract_raw_csv(RAW_PATH)
    df_raw.columns = df_raw.columns.str.lower().str.replace(" ", "_").str.replace("-", "_")
    valid, invalid = apply_validation(df_raw)
    df_raw.to_csv(BRONZE_PATH, index=False)

    # 2. Validate
    
    df_raw.columns = df_raw.columns.str.lower().str.replace(" ", "_").str.replace("-", "_")
    valid, invalid = apply_validation(df_raw)
    invalid.to_csv(QUARANTINE_PATH, index=False)

    # 3. Transform
    df_clean = clean_dataframe(valid)
    df_clean.to_csv(SILVER_PATH, index=False)

    # 4. Enrich
    df_gold = enrich(df_clean)
    save_output(df_gold, GOLD_PATH)

    logging.info("ETL pipeline completed successfully")