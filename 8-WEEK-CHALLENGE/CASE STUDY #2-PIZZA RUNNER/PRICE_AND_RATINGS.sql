use pizza_runner

/*1  If a Meat Lovers pizza costs $12 and Vegetarian costs $10 and there were
 no charges for changes - how much money has Pizza Runner made so far if there 
 are no delivery fees?*/
SELECT pizza_id,
CASE WHEN c.pizza_id = 1 THEN 'Meat Lovers' ELSE 'Vegetarian' END pizza_type,
COUNT(c.pizza_id) pizza_count,
CASE WHEN c.pizza_id = 1 THEN 12 ELSE 10 END price,
SUM(CASE WHEN c.pizza_id = 1 THEN 12
         WHEN c.pizza_id = 2 THEN 10 END) total_amount_per_pizza_no_extras
FROM clnd_runner_orders r JOIN clnd_customer_orders c
ON r.order_id = c.order_id 
WHERE r.distance IS NOT NULL
GROUP BY pizza_id;

/* 2. What if there was an additional $1 charge for any pizza extras?*/
SELECT pizza_id,
CASE WHEN c.pizza_id = 1 THEN 'Meat Lovers' ELSE 'Vegetarian' END pizza_type,
COUNT(c.pizza_id) pizza_count,
CASE WHEN c.pizza_id = 1 THEN 12 ELSE 10 END price,
SUM(CASE WHEN c.pizza_id = 1 THEN 12
         WHEN c.pizza_id = 2 THEN 10 END) total_amount_per_pizza_no_extras,
SUM(CASE WHEN c.pizza_id = 1 THEN 12 + 1*LENGTH(c.extras)
         WHEN c.pizza_id = 2 THEN 10 + 1*LENGTH(c.extras)
         ELSE 0 END) total_amount_per_pizza_with_extras
FROM clnd_runner_orders r JOIN clnd_customer_orders c
ON r.order_id = c.order_id 
WHERE r.distance IS NOT NULL
GROUP BY pizza_id;

/* 2a Add cheese is $1 extra */
SELECT pizza_id,
CASE WHEN c.pizza_id = 1 THEN 'Meat Lovers' ELSE 'Vegetarian' END pizza_type,
COUNT(c.pizza_id) pizza_count,
CASE WHEN c.pizza_id = 1 THEN 12 ELSE 10 END price,
SUM(CASE WHEN c.pizza_id = 1 THEN 12
         WHEN c.pizza_id = 2 THEN 10 END) +
SUM(CASE WHEN c.extras like '%4%' THEN 1 ELSE 0 END) total_income_per_pizza_type
FROM clnd_runner_orders r JOIN clnd_customer_orders c
ON r.order_id = c.order_id 
WHERE r.distance IS NOT NULL
GROUP BY pizza_id;

/* 3. The Pizza Runner team now wants to add an additional ratings system that allows customers to 
rate their runner, how would you design an additional table for this new dataset - generate a schema 
for this new table and insert your own data for ratings for each successful customer order between 1 to 5.*/

DROP TABLE ratings;
CREATE TABLE ratings 
 (order_id INTEGER,
    rating INTEGER);
INSERT INTO ratings
 (order_id ,rating)
VALUES 
(1,3),(2,4),(3,5),(4,2),(5,1),(6,3),(7,4),(8,1),(9,3),(10,5);

SELECT * FROM ratings;

/* 4. Using your newly generated table - can you join all of the information together to form a table which 
has the following information for successful deliveries? */
-- customer_id -- order_id -- runner_id -- rating -- order_time -- pickup_time -- Time between order and pickup
-- Delivery duration -- Average speed -- Total number of pizzas */
SELECT c.customer_id, c.order_id, ro.runner_id, 
       r.rating, c.order_time, ro.pickup_time, 
       TIMESTAMPDIFF(minute, c.order_time, ro.pickup_time) prep_time, 
       ro.duration delivery_duration,
       ROUND(AVG(ro.distance*60/ro.duration),1) avg_speed, 
       COUNT(c.pizza_id) pizza_count
FROM clnd_customer_orders c JOIN clnd_runner_orders ro 
ON c.order_id = ro.order_id JOIN ratings r ON c.order_id = r.order_id
GROUP BY c.customer_id, c.order_id, ro.runner_id, r.rating, c.order_time, 
ro.pickup_time, prep_time, delivery_duration
ORDER BY c.customer_id;


/* 5. If a Meat Lovers pizza was $12 and Vegetarian $10 fixed prices with no cost for extras 
and each runner is paid $0.30 per kilometre traveled - how much money does Pizza Runner have 
left over after these deliveries? */

SELECT SUM(CASE WHEN pizza_id = 1 THEN 12 + 1*LENGTH(extras)
                WHEN pizza_id = 2 THEN 10 + 1*LENGTH(extras)
		 ELSE 0 END) - (0.3 * REPLACE(r.distance, 'km', '')) left_amount
FROM clnd_customer_orders c JOIN clnd_runner_orders r
ON c.order_id = r.order_id
WHERE r.cancellation IS NULL;


