import pandas as pd
import re
from datetime import datetime
import phonenumbers
import pycountry

# -------------------------------
# 1. Email validation
# -------------------------------
def validate_email(email):
    pattern = r"^[\w\.-]+@[\w\.-]+\.\w+$"
    return bool(re.match(pattern, str(email)))

# -------------------------------
# 2. Phone validation (E.164)
# -------------------------------
def validate_phone(phone):
    try:
        parsed = phonenumbers.parse(str(phone), None)
        return phonenumbers.is_valid_number(parsed)
    except:
        return False

def normalize_phone(phone):
    try:
        parsed = phonenumbers.parse(str(phone), None)
        return phonenumbers.format_number(parsed, phonenumbers.PhoneNumberFormat.E164)
    except:
        return None

# -------------------------------
# 3. Date validation (dd/mm/yyyy or yyyy-mm-dd)
# -------------------------------
def is_valid_date(value):
    for fmt in ("%d/%m/%Y", "%Y-%m-%d"):
        try:
            datetime.strptime(str(value), fmt)
            return True
        except ValueError:
            continue
    return False

# -------------------------------
# 4. Country validation (ISO 3166)
# -------------------------------
def validate_country(country):
    if not country or pd.isna(country):
        return False
    return country in [c.name for c in pycountry.countries]

# -------------------------------
# 5. Age plausibility check
# -------------------------------
def validate_age(dob):
    try:
        dob = pd.to_datetime(dob, errors="coerce", dayfirst=True)
        age = (pd.Timestamp.today() - dob).days // 365
        return 0 <= age <= 110
    except:
        return False

# -------------------------------
# 6. Row-level validation
# -------------------------------
def validate_row(row):
    errors = []

    required_fields = ["name", "email", "phone", "address", "city", "country", "date_of_birth", "salary"]
    for field in required_fields:
        if pd.isna(row[field]) or str(row[field]).strip() == "":
            errors.append(f"Missing {field}")

    # Email
    if not validate_email(row["email"]):
        errors.append("Invalid email")

    # Phone
    if not validate_phone(row["phone"]):
        errors.append("Invalid phone")
    else:
        row["phone"] = normalize_phone(row["phone"])

    # Date of Birth
    if not is_valid_date(str(row["date_of_birth"])):
        errors.append("Invalid date_of_birth")
    elif not validate_age(row["date_of_birth"]):
        errors.append("Unrealistic age")

    # Salary numeric
    try:
        float(row["salary"])
    except:
        errors.append("Invalid salary")

    # Country
    if not validate_country(row["country"]):
        errors.append("Invalid country")

    # Corrupted address
    if re.search(r"@|\d{3}[-\.\)]", str(row["address"])):
        errors.append("Corrupted address field")

    return errors

# -------------------------------
# 7. Apply validation
# -------------------------------
def apply_validation(df: pd.DataFrame):
    df["errors"] = df.apply(validate_row, axis=1)
    valid = df[df["errors"].str.len() == 0].copy()
    invalid = df[df["errors"].str.len() > 0].copy()
    return valid, invalid
