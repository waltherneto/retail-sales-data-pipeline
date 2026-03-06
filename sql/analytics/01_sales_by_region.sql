SELECT
  r.region_name,
  ROUND(SUM(f.net_sales), 2) AS total_net_sales
FROM analytics.fact_sales f
JOIN analytics.dim_region r
  ON f.region_key = r.region_key
GROUP BY r.region_name
ORDER BY total_net_sales DESC;