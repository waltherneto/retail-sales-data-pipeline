import pandas as pd

from etl.config import RAW_DATA_PATH

EXPECTED_COLUMNS = [
    "order_id",
    "order_date",
    "region",
    "channel",
    "product_id",
    "product_name",
    "category",
    "unit_price",
    "quantity",
    "discount",
    "customer_id",
    "payment_method",
]


def extract_sales_data() -> pd.DataFrame:
    """
    Read the raw retail sales CSV and validate its structure.
    """
    if not RAW_DATA_PATH.exists():
        raise FileNotFoundError(f"Raw data file not found: {RAW_DATA_PATH}")

    df = pd.read_csv(RAW_DATA_PATH)

    missing_columns = [col for col in EXPECTED_COLUMNS if col not in df.columns]
    if missing_columns:
        raise ValueError(
            f"Missing expected columns in raw dataset: {missing_columns}"
        )

    print(f"[EXTRACT] Rows read: {len(df):,}")
    print(f"[EXTRACT] Columns validated: {len(df.columns)}")

    return df