import pandas as pd

def extract_raw_csv(path: str) -> pd.DataFrame:
    """
    Load raw CSV with maximum tolerance for errors.
    """
    df = pd.read_csv(
        path,
        dtype=str,
        encoding="utf-8",
        on_bad_lines="warn"   # skip malformed rows
    )
    return df
