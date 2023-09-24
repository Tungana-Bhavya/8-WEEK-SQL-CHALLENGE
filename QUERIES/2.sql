-- QUESTION_02

-- How many days has each customer visited the restaurant?
   
   Select customer_id,
   Count(Distinct(order_date)) as number_of_visits
   from bha_sales 
   group by customer_id;