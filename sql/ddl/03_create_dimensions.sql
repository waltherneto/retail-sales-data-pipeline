CREATE TABLE IF NOT EXISTS analytics.dim_date (
  date_key INTEGER PRIMARY KEY,
  full_date DATE NOT NULL UNIQUE,
  year INTEGER NOT NULL,
  quarter INTEGER NOT NULL,
  month INTEGER NOT NULL,
  month_name VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS analytics.dim_product (
  product_key SERIAL PRIMARY KEY,
  product_id VARCHAR(50) NOT NULL UNIQUE,
  product_name VARCHAR(255) NOT NULL,
  category VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS analytics.dim_region (
  region_key SERIAL PRIMARY KEY,
  region_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS analytics.dim_channel (
  channel_key SERIAL PRIMARY KEY,
  channel_name VARCHAR(100) NOT NULL UNIQUE
);