-- QUESTION_08.

-- What is the total items and amount spent for each member before they became a    member?
   
   Select s.customer_id,
   count(s.product_id)as total_items,
   sum(m.price) as amount_spent
   from bha_sales s
   join bha_menu m 
   on s.product_id=m.product_id 
   join bha_members m1 
   on m1.customer_id=s.customer_id
   where s.order_date < m1.join_date
   group by s.customer_id;