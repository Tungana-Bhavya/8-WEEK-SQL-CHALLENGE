## Data Cleansing Steps

## Drop DATABASE data_mart;
## SHOW databases;
## USE data_mart;
## SELECT * FROM weekly_sales;
## DESCRIBE data_mart.weekly_sales;
## SHOW tables in data_mart;
SELECT * FROM clean_weekly_sales LIMIT 10;

CREATE TABLE clean_weekly_sales AS 
SELECT
week_date,
EXTRACT(WEEK FROM week_date) week_number,
EXTRACT(MONTH FROM week_date) month_number,
EXTRACT(YEAR FROM week_date) calendar_year,
region, platform,
CASE WHEN segment = null THEN 'unknown'ELSE segment END segment,
CASE WHEN RIGHT(segment,1) = 1 THEN 'Young Adults'
     WHEN RIGHT(segment,1) = 2 THEN 'Middle Aged'
     WHEN RIGHT(segment,1) IN (3,4) THEN 'Retirees' ELSE 'unknown' END age_band,
CASE WHEN segment LIKE 'C%' THEN 'Couples'
     WHEN segment LIKE 'F%' THEN 'families' ELSE 'unknown' END demographic,
customer_type,
transactions, sales,
    ROUND(sales / transactions, 2) avg_transaction
FROM weekly_sales;