-- QUESTION_09

-- If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how    many points would each customer have?
   
   Select s.customer_id,
   sum(case when m.product_name = 'sushi' 
   then 20 * price else 10 * price end)
   as total_points
   from bha_sales s
   left join bha_menu m
   ON s.product_id = m.product_id
   group by s.customer_id;
  