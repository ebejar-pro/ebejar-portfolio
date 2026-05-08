import pandas as pd

def enrich(df: pd.DataFrame) -> pd.DataFrame:
    df = df.copy()

    # Add age
    df["age"] = (pd.Timestamp.today() - df["date_of_birth"]).dt.days // 365

    # Salary band
    df["salary_band"] = pd.cut(
        df["salary"],
        bins=[0, 40000, 70000, 100000, 999999],
        labels=["Low", "Medium", "High", "Very High"]
    )

    return df


def save_output(df: pd.DataFrame, path: str):
    df.to_csv(path, index=False)
