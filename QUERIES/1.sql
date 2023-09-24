-- QUESTION_01.

-- What is the total amount each customer spent at the restaurant?
   
   Select s.customer_id,
   sum(m.price) from bha_sales s 
   join bha_menu m on s.product_id=m.product_id
   group by s.customer_id