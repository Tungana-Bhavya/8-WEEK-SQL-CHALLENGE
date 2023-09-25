-- QUESTION_10

-- In the first week after a customer joins the program (including their join date)    they earn 2x points on all items, not just sushi - how many points do customer A    and B have at the end of January?
   
  WITH cte AS(
  SELECT
    s.customer_id,
    m.product_name,
    m.price,
    s.order_date,
    m1.join_date,
    CASE
      WHEN m.product_name = 'sushi' THEN 20
      WHEN s.order_date BETWEEN m1.join_date
      AND m1.join_date + 6 THEN 20
      ELSE 10
    END AS point
  FROM
    bha.bha_sales AS s
    INNER JOIN bha.bha_members AS m1 ON s.customer_id = m1.customer_id
    INNER JOIN bha.bha_menu AS m ON s.product_id = m.product_id
)
SELECT
customer_id,
SUM(point * price) AS total_point
FROM cte
WHERE order_date <= '2021-01-31'
GROUP BY 1 ORDER BY 1;