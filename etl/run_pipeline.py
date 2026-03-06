from etl.extract import extract_sales_data
from etl.transform import transform_sales_data
from etl.load import (
  build_analytics_layer,
  load_to_staging,
  setup_database,
  test_database_connection,
)

def main() -> None:
  """
  Execute the retail sales pipeline through the analytics layer.
  """
  print("[PIPELINE] Starting pipeline...")

  df_raw = extract_sales_data()
  df_clean = transform_sales_data(df_raw)

  print(f"[PIPELINE] Clean dataset ready with {len(df_clean):,} rows.")

  test_database_connection()
  setup_database()
  load_to_staging(df_clean)
  build_analytics_layer()

  print("[PIPELINE] Analytics pipeline completed successfully.")

if __name__ == "__main__":
  main()