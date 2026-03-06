INSERT INTO analytics.dim_region (
  region_name
)
SELECT DISTINCT
  region
FROM staging.sales_raw
ON CONFLICT (region_name) DO NOTHING;