# Power BI Dashboard Notes

## Overview
This dashboard was built on top of the PostgreSQL analytics layer created by the retail sales data pipeline.  
It provides a business-friendly view of sales performance across regions, channels, products, categories, and time.

## Data Source
The dashboard connects directly to the PostgreSQL database `retail_sales_dw` and uses the following tables from the `analytics` schema:

- `analytics.fact_sales`
- `analytics.dim_date`
- `analytics.dim_product`
- `analytics.dim_region`
- `analytics.dim_channel`

## Data Model
The Power BI model is based on a star schema:

- `fact_sales` stores transactional sales metrics
- `dim_date` supports time-based analysis
- `dim_product` supports product and category analysis
- `dim_region` supports regional analysis
- `dim_channel` supports channel analysis

## KPI Definitions
The dashboard includes three main KPIs:

- **Total Net Sales**: total net revenue after discounts
- **Total Orders**: distinct count of sales orders
- **Total Quantity Sold**: total units sold

## Main Visuals
The report includes the following visuals:

- **Total Net Sales**
- **Total Orders**
- **Total Quantity Sold**
- **Net Sales by Region**
- **Net Sales by Channel**
- **Monthly Net Sales Trend**
- **Top 10 Products by Net Sales**
- **Net Sales by Category**

## Filters
The dashboard includes interactive filters for:

- Region
- Category
- Channel

These filters allow users to slice the metrics and visuals dynamically.

## Business Questions Supported
This dashboard helps answer questions such as:

- Which region generates the highest net sales?
- Which sales channel performs best?
- What is the monthly sales trend?
- Which products drive the highest revenue?
- Which categories contribute most to total net sales?

## Notes
The dashboard was designed as a lightweight portfolio deliverable focused on clarity, usability, and analytical relevance rather than enterprise-level complexity.
