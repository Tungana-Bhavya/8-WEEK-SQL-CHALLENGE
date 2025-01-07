## Data Cleaning

## Creating temp table from customer_orders
## Replacing null values with empty in exclusions
## Replacing null values with empty in extras column

CREATE TABLE clnd_customer_orders AS
SELECT order_id, customer_id, pizza_id, 
CASE WHEN exclusions = 'null' OR exclusions IS NULL 
THEN '' ELSE exclusions END exclusions,
CASE WHEN extras = 'null' OR extras IS NULL 
THEN '' ELSE extras END extras,
order_time FROM customer_orders;

SELECT * FROM clnd_customer_orders;

## Creating temp table from runner_orders
## Replacing 'null' text values with null in pickup_time, duration and cancellation

CREATE TABLE clnd_runner_orders AS ( 
SELECT order_id, runner_id,
CASE WHEN pickup_time LIKE 'null' THEN NULL ELSE pickup_time END pickup_time,
CASE WHEN distance LIKE 'null' THEN NULL
     WHEN distance LIKE '%km' THEN TRIM('km' FROM distance)
ELSE distance END distance,
CASE WHEN duration LIKE 'null' THEN NULL
	 WHEN duration LIKE '%mins' THEN TRIM('mins' FROM duration)
	 WHEN duration LIKE '%minute' THEN TRIM('minute' FROM duration)
	 WHEN duration LIKE '%minutes' THEN TRIM('minutes' FROM duration)
ELSE duration END duration,
CASE WHEN cancellation IN ('null', 'NaN', '') THEN NULL ELSE cancellation END AS cancellation
FROM runner_orders);

#Updating Datatypes for runner_orders table

ALTER TABLE clnd_runner_orders
MODIFY column pickup_time DATETIME null,
MODIFY column distance decimal(5,1) null,
MODIFY column duration int null;

SELECT * FROM clnd_runner_orders;
 