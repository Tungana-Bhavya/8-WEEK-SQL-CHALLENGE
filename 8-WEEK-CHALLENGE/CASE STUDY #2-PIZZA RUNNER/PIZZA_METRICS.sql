use pizza_runner

## Question 1
## How many pizzas were ordered?
Select count(pizza_id)as pizza_ordered_count from customer_orders; 

## Question 2
## How many unique customer orders were made?
Select count(distinct(order_id))as unique_orders_count from customer_orders;

## Question 3
## How many successful orders were delivered by each runner?
Select runner_id,count(order_id)  as successful_orders 
from runner_orders where distance!=0 group by runner_id; 

## Question 4
## how many of each type of pizza was delivered ?
Select pizza_names.pizza_name,
count(customer_orders.pizza_id) as amount_of_pizza_delivered_count 
from customer_orders join runner_orders 
on customer_orders.order_id=runner_orders.order_id
join pizza_names on customer_orders.pizza_id=pizza_names.pizza_id 
where runner_orders.distance != 0
group by pizza_names.pizza_name;

## Question 5
## How many Vegetarian and Meatlovers were ordered by each customer?
Select c.customer_id, p.pizza_name, count(p.pizza_name) as order_count
from customer_orders c join pizza_names p on 
c.pizza_id=p.pizza_id
group by c.customer_id, p.pizza_name
order by c.customer_id;

## Question 6
## What was the maximum number of pizzas delivered in a single order?
Select order_id, count(pizza_id)as total_no_of_orders
from customer_orders group by order_id
order by total_no_of_orders desc;

## Question 7
## For each customer, how many delivered pizzas had at least 1 change and how many had no changes?
Select customer_orders.customer_id, sum(case when (exclusions is not null and exclusions != 0) or (extras is not null and extras != 0) then 1 else 0 end )
as Atleast_One_Change,
sum(case when (exclusions is null or exclusions = 0) and (extras is null or extras = 0) then 1 else 0 end ) as no_change
from customer_orders inner join runner_orders
on runner_orders.order_id = customer_orders.order_id
where runner_orders.distance != 0
group by customer_orders.customer_id;

## Question 8
## How many pizzas were delivered that had both exclusions and extras?
Select c.customer_id, 
sum(case
  when (exclusions is not null and exclusions != 0) and (extras is not null and extras != 0) then 1
        else 0
        end )as both_exclusion_extra
from customer_orders c
inner join runner_orders r
on r.order_id = c.order_id
where r.distance != 0
group by c.customer_id
order by both_exclusion_extra desc;

## Question 9
## What was the total volume of pizzas ordered for each hour of the day?
Select extract(hour from order_time)as hour_of_the_day, 
count(order_id)as total_pizza_ordered from customer_orders
group by hour_of_the_day
order by hour_of_the_day;

## Question 10
## What was the volume of orders for each day of the week?
Select dayname(order_time)as day_of_week, 
count(order_id)as total_pizza_ordered from customer_orders
group by day_of_week
order by total_pizza_ordered desc;

