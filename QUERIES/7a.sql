-- QUESTION_07.

-- Which item was purchased just before the customer became a member?
-- customer A
 select s.customer_id,
 s.order_date,
 m.product_name 
 from bha_sales s 
 join bha_menu m 
 on s.product_id=m.product_id
 where s.customer_id='A' AND s.order_date <'2021-01-07'
 order by s.order_date desc;