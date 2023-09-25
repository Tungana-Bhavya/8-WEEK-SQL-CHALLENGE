-- QUESTION_06.

-- Which item was purchased first by the customer after they became a member?
-- B
 Select s.customer_id,
 s.order_date,
 m.product_name 
 from bha_sales s 
 join bha_menu m 
 on s.product_id=m.product_id
 where s.customer_id='B' AND s.order_date >'2021-01-07'
 order by s.order_date limit 1;