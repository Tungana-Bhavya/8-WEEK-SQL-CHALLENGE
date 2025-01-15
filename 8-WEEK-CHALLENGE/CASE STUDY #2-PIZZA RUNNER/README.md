## <p align="left">Case Study #2 Pizza Runner</p>
<img src="https://8weeksqlchallenge.com/images/case-study-designs/2.png" alt="Image" width="480" height="380">

### Case Study Questions
<details><summary><a href="https://github.com/Tungana-Bhavya/8-WEEK-SQL-CHALLENGE/tree/main/8-WEEK-CHALLENGE/CASE%20STUDY%20%232-PIZZA%20RUNNER"><b>Pizza Metrics Queries</b></a></summary>

1.	How many pizzas were ordered?
2.	How many unique customer orders were made?
3.	How many successful orders were delivered by each runner?
4.	How many of each type of pizza was delivered?
5.	How many Vegetarian and Meatlovers were ordered by each customer?
6.	What was the maximum number of pizzas delivered in a single order?
7.	For each customer, how many delivered pizzas had at least 1 change and how many had no changes?
8.	How many pizzas were delivered that had both exclusions and extras?
9.	What was the total volume of pizzas ordered for each hour of the day?
10.	What was the volume of orders for each day of the week?
</details>

<b>- [Solution](https://github.com/Tungana-Bhavya/8-WEEK-SQL-CHALLENGE/blob/main/8-WEEK-CHALLENGE/CASE%20STUDY%20%232-PIZZA%20RUNNER/PIZZA_METRICS.sql)</b>
<br>
<details><summary><a href="https://github.com/Tungana-Bhavya/8-WEEK-SQL-CHALLENGE/tree/main/8-WEEK-CHALLENGE/CASE%20STUDY%20%232-PIZZA%20RUNNER"><b>Runner and Customer Experience Queries</b></a></summary>
1.	How many runners signed up for each 1 week period? (i.e. week starts 2021-01-01)<br>
2.	What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pickup the order?<br>
3.	Is there any relationship between the number of pizzas and how long the order takes to prepare?<br>
4.	What was the average distance travelled for each customer?<br>
5.	What was the difference between the longest and shortest delivery times for all orders?<br>
6.	What was the average speed for each runner for each delivery and do you notice any trend for these values?<br>
7.	What is the successful delivery percentage for each runner?
</details>

<b>- [Solution](https://github.com/Tungana-Bhavya/8-WEEK-SQL-CHALLENGE/blob/main/8-WEEK-CHALLENGE/CASE%20STUDY%20%232-PIZZA%20RUNNER/RUNNER_AND_CUSTOMER_EXPERIENCE.sql)</b>
<br>
<details><summary><a href="https://github.com/Tungana-Bhavya/8-WEEK-SQL-CHALLENGE/tree/main/8-WEEK-CHALLENGE/CASE%20STUDY%20%232-PIZZA%20RUNNER"><b>Ingredient Optimisation Queries</b></a></summary>
1.	What are the standard ingredients for each pizza? <br>
2.	What was the most commonly added extra?<br>
3.	What was the most common exclusion?<br>
4.	Generate an order item for each record in the customers_orders table in the format of one of the following: <br>
	*  Meat Lovers<br>
	*  Meat Lovers - Exclude Beef<br>
	*  Meat Lovers - Extra Bacon<br>
	*  Meat Lovers - Exclude Cheese, Bacon - Extra Mushroom, Peppers<br>
5.	Generate an alphabetically ordered comma separated ingredient list for each pizza order from the customer_orders table and add a 2x in 
front of any relevant ingredients For example: "Meat Lovers: 2xBacon, Beef, ... , Salami" <br>
6.	What is the total quantity of each ingredient used in all delivered pizzas sorted by most frequent first?
</details>

<b>- [Solution](https://github.com/Tungana-Bhavya/8-WEEK-SQL-CHALLENGE/blob/main/8-WEEK-CHALLENGE/CASE%20STUDY%20%232-PIZZA%20RUNNER/INGREDIENT_OPTIMIZATON.sql)</b>
<br>
<details><summary><a href="https://github.com/Tungana-Bhavya/8-WEEK-SQL-CHALLENGE/tree/main/8-WEEK-CHALLENGE/CASE%20STUDY%20%232-PIZZA%20RUNNER"><b>Pricing and Ratings Queries</b></a></summary>
1.	If a Meat Lovers pizza costs $12 and Vegetarian costs $10 and there were no charges for changes - how much money has Pizza Runner made so 
	far if there are no delivery fees?<br>
2.	What if there was an additional $1 charge for any pizza extras? <br>
	*       Add cheese is $1 extra<br>
3.	The Pizza Runner team now wants to add an additional ratings system that allows customers to rate their runner, how would you design an 
	additional table for this new dataset - generate a schema for this new table and insert your own data for ratings for each successful 
	customer order between 1 to 5. <br>
4.	Using your newly generated table - can you join all of the information together to form a table which has the following information for 
	successful deliveries?<br>
	*       customer_id <br>
	*	order_id <br>
	*	runner_id <br>
	*	rating <br>
	*	order_time <br>
	*	pickup_time <br>
	*	Time between order and pickup <br>
	*	Delivery duration <br>
	*	Average speed <br>
	*	Total number of pizzas <br>
5.	If a Meat Lovers pizza was $12 and Vegetarian $10 fixed prices with no cost for extras and each runner is paid $0.30 per kilometre traveled - how much money does Pizza Runner have left over after these deliveries?
</details>

<b>- [Solution]()</b>
<br>
<details><summary><a href="https://github.com/Tungana-Bhavya/8-WEEK-SQL-CHALLENGE/tree/main/8-WEEK-CHALLENGE/CASE%20STUDY%20%232-PIZZA%20RUNNER"><b>Bonus Questions</b></a></summary>
1. If Danny wants to expand his range of pizzas - how would this impact the existing data design? Write an INSERT statement to demonstrate what 
would happen if a new Supreme pizza with all the toppings was added to the Pizza Runner menu?
</details>

<b>- [Solution]()</b>


