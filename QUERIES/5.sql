-- QUESTION_05

-- Which item was the most popular for each customer?
   
   Select s.customer_id,
   m.product_name,
   count(m.product_id)as purchase_num_times
   from bha_sales s join
   bha_menu m on s.product_id= m.product_id 
   group by s.customer_id,m.product_name
   order by purchase_num_times desc;
