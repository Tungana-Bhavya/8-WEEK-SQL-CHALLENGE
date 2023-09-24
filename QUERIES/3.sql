-- QUESTION_03

-- What was the first item from the menu purchased by each customer?
   
   Select distinct s.customer_id,
   m.product_name,
   s.order_date
   from bha_sales s left join 
   bha_menu m on s.product_id= m.product_id
   where s.order_date="2021-01-01";