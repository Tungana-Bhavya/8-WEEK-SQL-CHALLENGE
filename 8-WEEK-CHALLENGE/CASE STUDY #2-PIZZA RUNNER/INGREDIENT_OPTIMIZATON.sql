USE pizza_runners;
#Data Cleaning

DROP TABLE pizza_types;
CREATE TABLE pizza_types AS
SELECT topping_id,
CASE WHEN topping_id IN (4,6,7,9,11,12) THEN 2
ELSE 1 END pizza_id, 
topping_name, 
CASE WHEN topping_id IN (4,6,7,9,11,12) THEN 'Vegetarian'
ELSE 'Meat Lovers' END pizza_type FROM pizza_toppings;

##1. What are the standard ingredients for each pizza ?
SELECT topping_id, topping_name, pizza_type FROM pizza_types;
## or
SELECT pizza_type, GROUP_CONCAT(topping_name SEPARATOR ', ') pizza_ingredients, COUNT(*) ingredients_count
FROM pizza_types GROUP BY pizza_type;

##2. What was the most commonly added extra ?
SELECT extras,topping_name,
COUNT(extras) AS extras_counts
FROM clnd_customer_orders c
JOIN pizza_types pt ON c.extras = pt.topping_id
GROUP BY extras, topping_name;

##3. What was the most common exclusions ?
SELECT exclusions, topping_name, COUNT(exclusions) exclusion_counts
FROM clnd_customer_orders c JOIN pizza_types pt 
ON c.exclusions = pt.topping_id
GROUP BY exclusions, topping_name
ORDER BY exclusion_counts desc;

##4. Genearte an order item for each record in the customer_orders table in the following format:
## - Meat Lovers
## - Meat Lovers - exclude beef
## - Meat Lovers - extra bacon
## - Meat Lovers - exclude cheese, bacon - Extra Mushrooms, peppers

SELECT DISTINCT c.order_id, c.customer_id, t.pizza_id, t.pizza_type, c.exclusions, c.extras, 
CASE WHEN c.pizza_id = 1 AND c.exclusions = '' AND c.extras = '' THEN 'Meat Lovers'
     WHEN c.pizza_id = 2 AND c.exclusions = '' AND c.extras = '' THEN 'Vegetarian'
     WHEN c.pizza_id = 1 AND c.exclusions = '4' AND c.extras ='' THEN 'Meat Lovers - Exclude Beef'
     WHEN c.pizza_id = 1 AND c.exclusions = '4' AND c.extras = '' THEN 'Meat Lovers - Exclude Cheese'
     WHEN c.pizza_id = 2 AND c.exclusions = '4' AND c.extras = '' THEN 'Vegetarian - Exclude Cheese'     
     WHEN c.pizza_id = 1 AND c.exclusions = '' AND c.extras ='1' THEN  'Meat Lovers - Extra Bacon'
	 WHEN c.pizza_id = 2 AND c.exclusions = '' AND c.extras ='1' THEN  'Vegetarian - Extra Bacon'
	 WHEN c.pizza_id = 1 AND c.exclusions = '4' AND c.extras ='1' THEN  'Meat Lovers - Exclude Cheese - Extra Bacon'
	 WHEN c.pizza_id = 1 AND c.exclusions = '4' AND c.extras ='5' THEN  'Meat Lovers - Exclude Cheese - Extra Chicken'
	 WHEN c.pizza_id = 1 AND c.exclusions = '2' AND c.extras ='1' THEN  'Meat Lovers - Exclude BBQ Sauce - Extra Bacon'
	 WHEN c.pizza_id = 1 AND c.exclusions = '2' AND c.extras ='4' THEN  'Meat Lovers - Exclude BBQ Sauce - Extra Cheese'
	 WHEN c.pizza_id = 1 AND c.exclusions = '6' AND c.extras ='1' THEN  'Meat Lovers - Exclude Mushrooms - Extra Bacon'
	 WHEN c.pizza_id = 1 AND c.exclusions = '6' AND c.extras ='4' THEN  'Meat Lovers - Exclude Mushrooms - Extra Cheese'   
     WHEN c.pizza_id = 1 AND c.exclusions = '1,4' AND c.extras ='6,9' THEN 'Meat Lovers - Exclude Bacon & Cheese - Extras Mushrooms & Peppers'
END order_items
FROM clnd_customer_orders c JOIN pizza_types t
ON c.pizza_id = t.pizza_id
ORDER BY c.order_id, c.customer_id

##6. What is the total quantity of each ingredient used in all delivered pizzas sorted by most frequent first?
  SELECT pt.pizza_type, pt.topping_id, pt.topping_name, COUNT(pt.topping_id) AS ingredient_count
  FROM delivered_runner_orders dro JOIN clnd_customer_orders cco
  ON dro.order_id = cco.order_id
  JOIN pizza_types pt ON cco.pizza_id = pt.pizza_id
  GROUP BY pt.topping_name ORDER BY ingredient_count DESC;
