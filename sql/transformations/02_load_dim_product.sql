INSERT INTO analytics.dim_product (
  product_id,
  product_name,
  category
)
SELECT DISTINCT
  product_id,
  product_name,
  category
FROM staging.sales_raw
ON CONFLICT (product_id) DO NOTHING;