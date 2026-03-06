-- 1. Orphan foreign key checks
SELECT
  COUNT(*) AS orphan_product_keys
FROM analytics.fact_sales f
LEFT JOIN analytics.dim_product p
  ON f.product_key = p.product_key
WHERE p.product_key IS NULL;

SELECT
  COUNT(*) AS orphan_region_keys
FROM analytics.fact_sales f
LEFT JOIN analytics.dim_region r
  ON f.region_key = r.region_key
WHERE r.region_key IS NULL;

SELECT
  COUNT(*) AS orphan_channel_keys
FROM analytics.fact_sales f
LEFT JOIN analytics.dim_channel c
  ON f.channel_key = c.channel_key
WHERE c.channel_key IS NULL;

SELECT
  COUNT(*) AS orphan_date_keys
FROM analytics.fact_sales f
LEFT JOIN analytics.dim_date d
  ON f.date_key = d.date_key
WHERE d.date_key IS NULL;

-- 2. Negative sales check
SELECT
  COUNT(*) AS negative_net_sales_rows
FROM analytics.fact_sales
WHERE net_sales < 0;

-- 3. Null or blank dimension checks
SELECT
  COUNT(*) AS blank_region_names
FROM analytics.dim_region
WHERE region_name IS NULL OR TRIM(region_name) = '';

SELECT
  COUNT(*) AS blank_channel_names
FROM analytics.dim_channel
WHERE channel_name IS NULL OR TRIM(channel_name) = '';

-- 4. Row count comparison
SELECT
  (SELECT COUNT(*) FROM staging.sales_raw) AS staging_row_count,
  (SELECT COUNT(*) FROM analytics.fact_sales) AS fact_row_count;