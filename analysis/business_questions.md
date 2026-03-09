# Business Questions

This project was designed to support common retail analytics questions using a batch data pipeline and a dimensional warehouse model.

## Core Business Questions

### 1. Which regions generate the highest net sales?
This helps identify the best-performing geographic areas and compare regional sales performance.

### 2. Which sales channels perform best?
This supports channel-level analysis across Online, Store, Marketplace, and Wholesale.

### 3. How do net sales trend over time?
This helps monitor monthly performance and identify seasonality or changes in sales behavior.

### 4. Which products generate the highest revenue?
This helps highlight the top-performing products by net sales.

### 5. Which product categories contribute most to total net sales?
This supports category-level performance analysis and helps identify major revenue drivers.

## Analytical Outputs Used

These questions are supported through:

- SQL analytical queries in `sql/analytics/`
- dimensional tables in the `analytics` schema
- Power BI visuals built on top of the star schema

## Business Value

The project demonstrates how raw retail transactions can be transformed into reliable analytical datasets that support business reporting and performance monitoring.