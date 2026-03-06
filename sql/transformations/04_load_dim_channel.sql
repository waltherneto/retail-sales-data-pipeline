INSERT INTO analytics.dim_channel (
  channel_name
)
SELECT DISTINCT
  channel
FROM staging.sales_raw
ON CONFLICT (channel_name) DO NOTHING;