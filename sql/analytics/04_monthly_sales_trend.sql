SELECT
  d.year,
  d.month,
  TRIM(d.month_name) AS month_name,
  ROUND(SUM(f.net_sales), 2) AS total_net_sales
FROM analytics.fact_sales f
JOIN analytics.dim_date d
  ON f.date_key = d.date_key
GROUP BY d.year, d.month, d.month_name
ORDER BY d.year, d.month;