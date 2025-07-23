# D. EXTRA CHALLENGE
/* If the annual interest rate is set at 6% and the Data Bank team wants 
to reward its customers by increasing their data allocation based off the 
interest calculated on a daily basis at the end of each day, how much data 
would be required for this option on a monthly basis? */

WITH transactions AS (
SELECT customer_id, txn_date, 
CASE WHEN txn_type = "deposit" THEN txn_amount ELSE -txn_amount END amount,
DATEDIFF(CURDATE(), txn_date) + 1 days_diff
FROM customer_transactions
)

SELECT customer_id, txn_date, ROUND(SUM(amount) OVER (
PARTITION BY customer_id ORDER BY txn_date),2) balance,
ROUND(SUM(amount * 0.06 * days_diff / 365) OVER (
PARTITION BY customer_id ORDER BY txn_date),2) balance_with_interest
FROM transactions ORDER BY customer_id, txn_date;