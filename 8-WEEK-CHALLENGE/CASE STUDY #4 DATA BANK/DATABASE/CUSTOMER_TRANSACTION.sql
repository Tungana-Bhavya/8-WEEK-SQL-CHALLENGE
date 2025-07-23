# B. CUSTOMER TRANSACTIONS

## 1. What is the unique count and total amount for each transaction type?

SELECT txn_type, COUNT(*) unique_count, SUM(txn_amount) total_amount
FROM customer_transactions
GROUP BY txn_type
ORDER BY txn_type;

## 2. What is the average total historical deposit counts and amounts for all customers?

WITH deposit_tmp AS 
(
SELECT customer_id, 
       txn_type, 
       COUNT(*) deposit_count, 
       SUM(txn_amount) deposit_amount
FROM customer_transactions
GROUP BY customer_id, txn_type
)
SELECT txn_type, ROUND(AVG(deposit_count),0) avg_deposit_count,
ROUND(AVG(deposit_amount),0) avg_amount 
FROM deposit_tmp WHERE txn_type = 'deposit'
GROUP BY txn_type;

## 3. For each month - how many Data Bank customers make more than 1 deposit 
## and either 1 purchase or 1 withdrawal in a single month ?

WITH customer_cte AS
(
SELECT customer_id,
EXTRACT(YEAR FROM txn_date) year,
EXTRACT(MONTH FROM txn_date) month_id,
DATE_FORMAT(txn_date, "%b") month_name,
COUNT(CASE WHEN txn_type = "deposit" THEN 1 END) deposit_count,
COUNT(CASE WHEN txn_type = "purchase" THEN 1 END) purchase_count,
COUNT(CASE WHEN txn_type = "withdrawal" THEN 1 END) withdrawl_count
FROM customer_transactions
GROUP BY customer_id, DATE_FORMAT(txn_date, "%b"), 
EXTRACT(YEAR FROM txn_date), EXTRACT(MONTH FROM txn_date))

SELECT month_id, month_name, year, COUNT(customer_id) customer_count FROM customer_cte
WHERE deposit_count > 1 AND (purchase_count > 0 OR withdrawl_count > 0)
GROUP BY month_id, month_name, year ORDER BY year, month_id;

## 4. What is the closing balance for each customer at the end of the month?

WITH cte1 AS (
SELECT customer_id, EXTRACT(MONTH FROM txn_date) month_id,
DATE_FORMAT(txn_date, "%b") month_name, EXTRACT(YEAR FROM txn_date) year,
CASE WHEN txn_type = "deposit" THEN txn_amount ELSE -txn_amount END account_balance_change
FROM customer_transactions ), 
cte2 AS (
SELECT customer_id, month_id, month_name, year, SUM(account_balance_change) change_month
FROM cte1 GROUP BY customer_id, month_id, month_name, year
)

SELECT customer_id, month_id, month_name, year,
SUM(change_month) OVER (PARTITION BY customer_id ORDER BY YEAR) balance_closing
FROM cte2 ORDER BY customer_id, month_id, month_name, year;

## 5. What is the percentage of customers who increase their closing balance by more than 5% ?

WITH monthly_bal AS (
SELECT customer_id, LAST_DAY(txn_date) end_of_date,
SUM(CASE WHEN txn_type IN ('withdrawal', 'purchase') 
THEN -txn_amount ELSE txn_amount END) net_amount
FROM customer_transactions
GROUP BY customer_id, LAST_DAY(txn_date)
),

running_bal AS (
SELECT customer_id, end_of_date, 
SUM(net_amount) OVER (
PARTITION BY customer_id ORDER BY end_of_date) closing_balance
FROM monthly_bal
),

bal_growth AS (
SELECT customer_id, end_of_date, closing_balance,
LAG(closing_balance) OVER (
PARTITION BY customer_id ORDER BY end_of_date) prev_balance
FROM running_bal
),

qualified_custs AS (
SELECT DISTINCT customer_id FROM bal_growth
WHERE (prev_balance IS NULL OR prev_balance = 0) AND closing_balance > 0
OR (prev_balance > 0 AND (closing_balance - prev_balance) / prev_balance > 0.05)
)

SELECT CONCAT(ROUND(100.0 * COUNT(*) / (SELECT COUNT(DISTINCT customer_id) 
FROM customer_transactions), 2), ' %') custs_prcnt_with_growth
FROM qualified_custs;
