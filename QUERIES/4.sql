-- QUESTION_04

-- What is the most purchased item on the menu and how many times was it purchased     by all customers?
   
   Select m.product_name,
   count(m.product_id) as purchase_num_times
   from bha_sales s join
   bha_menu m on s.product_id= m.product_id 
   group by m.product_name
   order by purchase_num_times desc limit 1;
