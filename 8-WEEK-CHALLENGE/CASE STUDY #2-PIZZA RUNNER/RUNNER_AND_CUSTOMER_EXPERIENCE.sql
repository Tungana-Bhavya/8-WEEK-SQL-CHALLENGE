## Runner and Customer Experience

use pizza_runner

SELECT * FROM clnd_customer_orders;
SELECT * FROM clnd_runner_orders;

## Question  1
## How many runners signed up for each 1 week period? (i.e. week starts 2021-01-01)
SELECT week(registration_date) registration_week, COUNT(runner_id) runners_registered
FROM runners GROUP BY registration_week;

## Question  2
## What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pickup the order?
SELECT r.runner_id, ROUND(AVG(TIMESTAMPDIFF(MINUTE, c.order_time, r.pickup_time)),2) avg_time 
FROM runner_orders r, customer_orders c 
WHERE c.order_id = r.order_id
GROUP BY r.runner_id;

## Question  3
## Is there any relationship between the number of pizzas and how long the order takes to prepare?
with pizza_prep_time AS(
SELECT c.order_id, COUNT(c.order_id) pizza_count,
timestampdiff(minute,c.order_time,r.pickup_time) as time_taken_per_order,
timestampdiff(minute,c.order_time,r.pickup_time)/count(c.pizza_id) as time_taken_per_pizza
FROM customer_orders c JOIN runner_orders r Using(order_id)
GROUP BY c.order_id,c.order_time,r.pickup_time)
    
SELECT pizza_count, ROUND(AVG(time_taken_per_order),2) total_avg_time,
ROUND(AVG(time_taken_per_pizza),2) AS avg_time_taken_per_pizza
FROM pizza_prep_time GROUP BY pizza_count;

## Question  4
## What was the average distance travelled for each customer?
SELECT c.customer_id, ROUND(AVG(r.distance),1) FROM
clnd_customer_orders c JOIN clnd_runner_orders r
ON c.order_id = r.order_id
GROUP BY c.customer_id;

## Question  5
## What was the difference between the longest and shortest delivery times for all orders?
SELECT MAX(duration), MIN(duration), MAX(duration) - MIN(duration) time_difference FROM clnd_runner_orders;

## Question  6
## What was the average speed for each runner for each delivery and do you notice any trend for these values?
SELECT r.runner_id, c.order_id, r.distance, r.duration, 
COUNT(c.order_id) pizza_count, ROUND(AVG(r.distance/r.duration*60), 1) avg_speed
FROM clnd_runner_orders r JOIN clnd_customer_orders c
ON r.order_id = c.order_id
WHERE r.cancellation IS NULL
GROUP BY r.runner_id, c.order_id, r.distance, r.duration;

## Question  7
## What is the successful delivery percentage for each runner?
SELECT runner_id, COUNT(distance) delivered, COUNT(order_id) total,
COUNT(distance) / COUNT(order_id) * 100 successful_delivery_perc
FROM clnd_runner_orders GROUP BY runner_id;