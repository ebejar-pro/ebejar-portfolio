from pathlib import Path

BASE_DIR = Path(__file__).resolve().parent.parent

DATA_DIR = BASE_DIR / "data"

RAW_PATH = DATA_DIR / "raw/sample_data.csv"
BRONZE_PATH = DATA_DIR / "bronze/bronze.csv"
SILVER_PATH = DATA_DIR / "silver/silver.csv"
GOLD_PATH = DATA_DIR / "gold/gold.csv"
QUARANTINE_PATH = DATA_DIR / "quarantine/quarantine.csv"

LOG_PATH = BASE_DIR / "logs/etl.log"