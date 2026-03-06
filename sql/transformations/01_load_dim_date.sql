INSERT INTO analytics.dim_date (
  date_key,
  full_date,
  year,
  quarter,
  month,
  month_name
)
SELECT DISTINCT
  TO_CHAR(order_date, 'YYYYMMDD')::INTEGER AS date_key,
  order_date AS full_date,
  EXTRACT(YEAR FROM order_date)::INTEGER AS year,
  EXTRACT(QUARTER FROM order_date)::INTEGER AS quarter,
  EXTRACT(MONTH FROM order_date)::INTEGER AS month,
  TO_CHAR(order_date, 'Month')::VARCHAR(20) AS month_name
FROM staging.sales_raw
ON CONFLICT (full_date) DO NOTHING;