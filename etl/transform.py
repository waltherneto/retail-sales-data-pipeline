import pandas as pd

from etl.config import PROCESSED_DATA_PATH


def transform_sales_data(df: pd.DataFrame) -> pd.DataFrame:
    """
    Clean and standardize retail sales data for warehouse loading.
    """
    initial_rows = len(df)

    df = df.copy()

    duplicates_removed = df.duplicated().sum()
    df = df.drop_duplicates()

    df["order_date"] = pd.to_datetime(df["order_date"], errors="coerce")

    df["region"] = df["region"].astype(str).str.strip().str.title()
    df["channel"] = df["channel"].astype(str).str.strip().str.title()
    df["category"] = df["category"].astype(str).str.strip().str.title()
    df["payment_method"] = df["payment_method"].astype(str).str.strip().str.title()

    product_name_nulls = df["product_name"].isna().sum()
    df["product_name"] = df["product_name"].fillna("Unknown Product")

    discount_nulls = df["discount"].isna().sum()
    df["discount"] = df["discount"].fillna(0)

    df["unit_price"] = pd.to_numeric(df["unit_price"], errors="coerce")
    df["quantity"] = pd.to_numeric(df["quantity"], errors="coerce")
    df["discount"] = pd.to_numeric(df["discount"], errors="coerce")

    invalid_quantity_rows = (df["quantity"] <= 0).sum()
    df = df[df["quantity"] > 0]

    invalid_price_rows = (df["unit_price"] < 0).sum()
    df = df[df["unit_price"] >= 0]

    df = df[df["order_date"].notna()]

    df["discount"] = df["discount"].clip(lower=0, upper=1)

    df["quantity"] = df["quantity"].astype(int)
    df["unit_price"] = df["unit_price"].round(2)
    df["discount"] = df["discount"].round(4)

    df["gross_sales"] = (df["unit_price"] * df["quantity"]).round(2)
    df["discount_amount"] = (df["gross_sales"] * df["discount"]).round(2)
    df["net_sales"] = (df["gross_sales"] - df["discount_amount"]).round(2)

    PROCESSED_DATA_PATH.parent.mkdir(parents=True, exist_ok=True)
    df.to_csv(PROCESSED_DATA_PATH, index=False)

    print(f"[TRANSFORM] Initial rows: {initial_rows:,}")
    print(f"[TRANSFORM] Duplicates removed: {duplicates_removed:,}")
    print(f"[TRANSFORM] Product name nulls fixed: {product_name_nulls:,}")
    print(f"[TRANSFORM] Discount nulls fixed: {discount_nulls:,}")
    print(f"[TRANSFORM] Invalid quantity rows removed: {invalid_quantity_rows:,}")
    print(f"[TRANSFORM] Invalid price rows removed: {invalid_price_rows:,}")
    print(f"[TRANSFORM] Final rows: {len(df):,}")
    print(f"[TRANSFORM] Processed file saved to: {PROCESSED_DATA_PATH}")

    return df