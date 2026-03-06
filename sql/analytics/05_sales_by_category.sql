SELECT
  p.category,
  ROUND(SUM(f.net_sales), 2) AS total_net_sales
FROM analytics.fact_sales f
JOIN analytics.dim_product p
  ON f.product_key = p.product_key
GROUP BY p.category
ORDER BY total_net_sales DESC;