/* If Danny wants to expand his range of pizzas - how would this impact the existing data design? */
/* Write an INSERT statement to demonstrate what would happen if a new Supreme pizza with all the 
toppings was added to the Pizza Runner menu? */

use pizza_runner;
SET SQL_SAFE_UPDATES = 0;
#Inserting new name supereme into pizza_name
INSERT INTO pizza_names(pizza_id, pizza_name) Values(3, 'Supreme');

# Inserting new toppings into pizza_toppings
INSERT INTO pizza_toppings(topping_id, topping_name) values(13, 'Olive'), (14, 'Capsicum'), (15, 'prawns'),
(16, 'Garlic'), (17, 'Sweetcorn'), (18, 'Spinach'), (19, 'Oregano'), (20, 'Pineapple');

SELECT * FROM pizza_names;
