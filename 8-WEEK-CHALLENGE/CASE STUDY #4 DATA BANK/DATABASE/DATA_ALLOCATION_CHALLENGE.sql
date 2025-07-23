# C. DATA ALLOCATION CHALLENGE
## 1. Running a customer balance column that includes the impact of each transaction

SELECT customer_id, txn_date, txn_type, 
txn_amount, SUM(CASE WHEN txn_type = "deposit" THEN txn_amount
			         WHEN txn_type = "withdrawal" THEN -txn_amount
                     WHEN txn_type = "purchase" THEN -txn_amount 
ELSE 0 END) OVER(PARTITION BY customer_id ORDER BY txn_date) running_balance
FROM customer_transactions;

## 2. Customer balance at the end of each month

SELECT customer_id, EXTRACT(MONTH FROM txn_date) month_id,
DATE_FORMAT(txn_date, "%b") month_name, 
SUM(CASE WHEN txn_type = "deposit" THEN txn_amount
	     WHEN txn_type = "withdrawal" THEN -txn_amount
         WHEN txn_type = "purchase" THEN -txn_amount ELSE 0 END) closing_balance
FROM customer_transactions GROUP BY customer_id, 
EXTRACT(MONTH FROM txn_date), DATE_FORMAT(txn_date, "%b")


## 3. Minimum, average and maximum values of the running balance for each customer.

WITH r_bal AS (
SELECT customer_id, txn_date, txn_amount, 
SUM(CASE WHEN txn_type = "deposit" THEN txn_amount
			         WHEN txn_type = "withdrawal" THEN -txn_amount
                     WHEN txn_type = "purchase" THEN -txn_amount 
ELSE 0 END) OVER(PARTITION BY customer_id ORDER BY txn_date) running_balance
FROM customer_transactions
)

SELECT customer_id, AVG(running_balance) avg_running_balance,
MIN(running_balance) min_running_balance,
MAX(running_balance) max_running_balance
FROM r_bal GROUP BY customer_id;