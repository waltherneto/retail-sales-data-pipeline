CREATE TABLE IF NOT EXISTS staging.sales_raw (
  order_id VARCHAR(50) NOT NULL,
  order_date DATE NOT NULL,
  region VARCHAR(100) NOT NULL,
  channel VARCHAR(100) NOT NULL,
  product_id VARCHAR(50) NOT NULL,
  product_name VARCHAR(255) NOT NULL,
  category VARCHAR(100) NOT NULL,
  unit_price NUMERIC(10, 2) NOT NULL,
  quantity INTEGER NOT NULL,
  discount NUMERIC(5, 4) NOT NULL,
  customer_id VARCHAR(50) NOT NULL,
  payment_method VARCHAR(50) NOT NULL,
  gross_sales NUMERIC(12, 2) NOT NULL,
  discount_amount NUMERIC(12, 2) NOT NULL,
  net_sales NUMERIC(12, 2) NOT NULL
);