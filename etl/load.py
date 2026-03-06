from pathlib import Path

import pandas as pd
from sqlalchemy import create_engine, text

from etl.config import BASE_DIR, DATABASE_URL


def get_engine():
  """
  Create and return a SQLAlchemy engine for PostgreSQL.
  """
  return create_engine(DATABASE_URL)


def test_database_connection() -> None:
  """
  Validate database connectivity with a simple query.
  """
  engine = get_engine()

  with engine.connect() as connection:
    result = connection.execute(text("SELECT 1"))
    value = result.scalar()

  print(f"[LOAD] Database connection test result: {value}")


def run_sql_file(file_path: Path) -> None:
  """
  Execute a SQL file against PostgreSQL.
  """
  engine = get_engine()
  sql = file_path.read_text(encoding="utf-8")

  with engine.begin() as connection:
    connection.execute(text(sql))

  print(f"[LOAD] Executed SQL file: {file_path.name}")


def setup_database() -> None:
  """
  Create schemas and tables required for the pipeline.
  """
  ddl_dir = BASE_DIR / "sql" / "ddl"

  run_sql_file(ddl_dir / "01_create_schemas.sql")
  run_sql_file(ddl_dir / "02_create_staging_table.sql")
  run_sql_file(ddl_dir / "03_create_dimensions.sql")
  run_sql_file(ddl_dir / "04_create_fact_table.sql")


def load_to_staging(df: pd.DataFrame) -> None:
  """
  Load the cleaned DataFrame into the staging.sales_raw table.
  """
  engine = get_engine()

  with engine.begin() as connection:
      connection.execute(text("TRUNCATE TABLE staging.sales_raw;"))

  df.to_sql(
    name="sales_raw",
    schema="staging",
    con=engine,
    if_exists="append",
    index=False,
    method="multi",
    chunksize=1000,
  )

  print(f"[LOAD] Rows loaded to staging.sales_raw: {len(df):,}")


def build_analytics_layer() -> None:
  """
  Populate dimensional and fact tables from staging.
  """
  engine = get_engine()
  transformations_dir = BASE_DIR / "sql" / "transformations"

  with engine.begin() as connection:
    connection.execute(text("TRUNCATE TABLE analytics.fact_sales RESTART IDENTITY;"))
    connection.execute(text("TRUNCATE TABLE analytics.dim_product RESTART IDENTITY CASCADE;"))
    connection.execute(text("TRUNCATE TABLE analytics.dim_region RESTART IDENTITY CASCADE;"))
    connection.execute(text("TRUNCATE TABLE analytics.dim_channel RESTART IDENTITY CASCADE;"))
    connection.execute(text("TRUNCATE TABLE analytics.dim_date CASCADE;"))

  print("[LOAD] Cleared analytics tables.")

  run_sql_file(transformations_dir / "01_load_dim_date.sql")
  run_sql_file(transformations_dir / "02_load_dim_product.sql")
  run_sql_file(transformations_dir / "03_load_dim_region.sql")
  run_sql_file(transformations_dir / "04_load_dim_channel.sql")
  run_sql_file(transformations_dir / "05_load_fact_sales.sql")

  print("[LOAD] Analytics layer built successfully.")