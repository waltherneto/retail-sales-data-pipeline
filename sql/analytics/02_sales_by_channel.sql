SELECT
  c.channel_name,
  ROUND(SUM(f.net_sales), 2) AS total_net_sales
FROM analytics.fact_sales f
JOIN analytics.dim_channel c
  ON f.channel_key = c.channel_key
GROUP BY c.channel_name
ORDER BY total_net_sales DESC;