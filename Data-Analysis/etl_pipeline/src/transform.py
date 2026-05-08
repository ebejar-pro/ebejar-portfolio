import pandas as pd

def clean_dataframe(df: pd.DataFrame) -> pd.DataFrame:
    df = df.copy()

    # Standardise column names
    df.columns = (
        df.columns.str.lower()
        .str.replace(" ", "_")
        .str.replace("-", "_")
    )

    # Clean whitespace
    df = df.map(lambda x: x.strip() if isinstance(x, str) else x)

    # Fix multiline addresses
    df["address"] = df["address"].str.replace("\n", ", ")

    # Convert salary to numeric
    df["salary"] = pd.to_numeric(df["salary"], errors="coerce")

    # Convert date of birth
    # df["date_of_birth"] = pd.to_datetime(df["date_of_birth"], errors="coerce")
    df["date_of_birth"] = pd.to_datetime(df["date_of_birth"], errors="coerce", dayfirst=True)


    # Remove duplicates
    df = df.drop_duplicates(subset=["email"], keep="first")

    return df
