INSERT INTO analytics.fact_sales (
  order_id,
  date_key,
  product_key,
  region_key,
  channel_key,
  customer_id,
  payment_method,
  quantity,
  unit_price,
  discount,
  gross_sales,
  discount_amount,
  net_sales
)
SELECT
  s.order_id,
  TO_CHAR(s.order_date, 'YYYYMMDD')::INTEGER AS date_key,
  p.product_key,
  r.region_key,
  c.channel_key,
  s.customer_id,
  s.payment_method,
  s.quantity,
  s.unit_price,
  s.discount,
  s.gross_sales,
  s.discount_amount,
  s.net_sales
FROM staging.sales_raw s
INNER JOIN analytics.dim_product p
  ON s.product_id = p.product_id
INNER JOIN analytics.dim_region r
  ON s.region = r.region_name
INNER JOIN analytics.dim_channel c
  ON s.channel = c.channel_name;