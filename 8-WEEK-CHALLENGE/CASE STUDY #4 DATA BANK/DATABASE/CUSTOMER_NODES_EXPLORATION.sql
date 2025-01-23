# A. Customer Nodes Exploration
## 1 How many unique nodes are there on the Data Bank system?

SELECT COUNT(DISTINCT node_id) unique_nodes FROM customer_nodes;

## 2 What is the number of nodes per region?

SELECT c.region_id, r.region_name, COUNT(c.node_id) nodes_count 
FROM customer_nodes c JOIN regions r
ON c.region_id = r.region_id
GROUP BY c.region_id, region_name
ORDER BY nodes_count DESC;

## 3 How many customers are allocated to each region?
SELECT r.region_id, r.region_name,COUNT(DISTINCT c.customer_id) customer_count 
FROM customer_nodes c JOIN regions r
ON c.region_id = r.region_id
GROUP BY c.region_id, r.region_name
ORDER BY customer_count DESC;

## 4 How many days on average are customers reallocated to a different node?

SELECT ROUND(AVG(TO_DAYS(end_date) - TO_DAYS(start_date)),0) avg_number_of_day FROM customer_nodes
WHERE end_date!='9999-12-31';

## 5 What is the median, 80th and 95th percentile for this same reallocation days metric for each region?
WITH tmp_rank AS (
SELECT region_name, 
TO_DAYS(end_date) - TO_DAYS(start_date) days_diff, 
ROW_NUMBER() OVER (ORDER BY TO_DAYS(end_date) - TO_DAYS(start_date)) row_num,
COUNT(*) OVER () rows_sum FROM customer_nodes c JOIN regions r
ON c.region_id = r.region_id WHERE end_date != '9999-12-31'
GROUP BY region_name
ORDER BY region_name)

SELECT region_name, days_diff percentile_80 FROM tmp_rank WHERE row_num >= CEIL(rows_sum * 0.8); 

