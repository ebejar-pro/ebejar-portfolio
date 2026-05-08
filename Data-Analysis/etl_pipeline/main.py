from src.pipeline import run_etl
from src.logger import setup_logger

def main():
    setup_logger()
    run_etl()
    

if __name__ == "__main__":
    main()
