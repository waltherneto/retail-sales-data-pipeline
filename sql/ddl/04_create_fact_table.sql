CREATE TABLE IF NOT EXISTS analytics.fact_sales (
  sales_key BIGSERIAL PRIMARY KEY,
  order_id VARCHAR(50) NOT NULL,
  date_key INTEGER NOT NULL,
  product_key INTEGER NOT NULL,
  region_key INTEGER NOT NULL,
  channel_key INTEGER NOT NULL,
  customer_id VARCHAR(50) NOT NULL,
  payment_method VARCHAR(50) NOT NULL,
  quantity INTEGER NOT NULL,
  unit_price NUMERIC(10, 2) NOT NULL,
  discount NUMERIC(5, 4) NOT NULL,
  gross_sales NUMERIC(12, 2) NOT NULL,
  discount_amount NUMERIC(12, 2) NOT NULL,
  net_sales NUMERIC(12, 2) NOT NULL,
  CONSTRAINT fk_fact_sales_date
    FOREIGN KEY (date_key) REFERENCES analytics.dim_date(date_key),
  CONSTRAINT fk_fact_sales_product
    FOREIGN KEY (product_key) REFERENCES analytics.dim_product(product_key),
  CONSTRAINT fk_fact_sales_region
    FOREIGN KEY (region_key) REFERENCES analytics.dim_region(region_key),
  CONSTRAINT fk_fact_sales_channel
    FOREIGN KEY (channel_key) REFERENCES analytics.dim_channel(channel_key)
);