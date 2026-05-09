import pandas as pd
import re
from datetime import datetime

def validate_email(email):
    pattern = r"^[\w\.-]+@[\w\.-]+\.\w+$"
    return bool(re.match(pattern, str(email)))

def validate_phone(phone):
    pattern = r"^[\d\-\+\(\)\.\sx]+$"
    return bool(re.match(pattern, str(phone)))

def is_valid_date(value):
    try:
        # Accept both dd/mm/yyyy and yyyy-mm-dd formats
        for fmt in ("%d/%m/%Y", "%Y-%m-%d"):
            try:
                datetime.strptime(str(value), fmt)
                return True
            except ValueError:
                continue
        return False
    except Exception:
        return False

def validate_row(row):
    errors = []

    # 1. Required fields
    required_fields = ["name", "email", "phone", "address", "city", "country", "date_of_birth", "salary"]
    for field in required_fields:
        if pd.isna(row[field]) or str(row[field]).strip() == "":
            errors.append(f"Missing {field}")

    # 2. Email format
    if not validate_email(row["email"]):
        errors.append("Invalid email")

    # 3. Phone format
    if not validate_phone(row["phone"]):
        errors.append("Invalid phone")

    # 4. Date validation

    if not is_valid_date(str(row["date_of_birth"])):
        errors.append("Invalid date_of_birth")

    # 5. Salary numeric
    try:
        float(row["salary"])
    except:
        errors.append("Invalid salary")

    # 6. Detect corrupted rows (address containing another record)
    if "," in str(row["address"]):
        # If address contains another email or phone → corrupted
        if re.search(r"@|\d{3}[-\.\)]", str(row["address"])):
            errors.append("Corrupted address field")

    return errors


def apply_validation(df: pd.DataFrame):
    df["errors"] = df.apply(validate_row, axis=1)
    valid = df[df["errors"].str.len() == 0].copy()
    invalid = df[df["errors"].str.len() > 0].copy()
    return valid, invalid
