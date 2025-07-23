## <p align ='left'>Case Study #5 Data Bank</p>

<img src="https://8weeksqlchallenge.com/images/case-study-designs/4.png" alt="Image" width="480" height="380">

## Case Study Questions

[A. Customer Nodes Exploration](https://github.com/Tungana-Bhavya/8-WEEK-SQL-CHALLENGE/blob/main/8-WEEK-CHALLENGE/CASE%20STUDY%20%234%20DATA%20BANK/DATABASE/CUSTOMER_NODES_EXPLORATION.sql)
<h3 align ='left'>1. How many unique nodes are there on the Data Bank system?</h3>

SELECT COUNT(DISTINCT node_id) unique_nodes FROM customer_nodes; </br>
### Output:</br>
<p align="left">
  <img  src="https://github.com/Tungana-Bhavya/8-WEEK-SQL-CHALLENGE/blob/main/8-WEEK-CHALLENGE/CASE%20STUDY%20%234%20DATA%20BANK/IMAGES/CNE_1.jpg">
</p>

<h3 align ='left'>2. What is the number of nodes per region?</h3>

SELECT c.region_id, r.region_name, COUNT(c.node_id) nodes_count </br>
FROM customer_nodes c JOIN regions r ON c.region_id = r.region_id </br>
GROUP BY c.region_id, region_name ORDER BY nodes_count DESC; </br>
### Output:</br>
<p align="left">
  <img  src="https://github.com/Tungana-Bhavya/8-WEEK-SQL-CHALLENGE/blob/main/8-WEEK-CHALLENGE/CASE%20STUDY%20%234%20DATA%20BANK/IMAGES/CNE_2.jpg">
</p>

<h3 align ='left'>3. How many customers are allocated to each region?</h3>

SELECT r.region_id, r.region_name,COUNT(DISTINCT c.customer_id) customer_count </br>
FROM customer_nodes c JOIN regions r ON c.region_id = r.region_id </br>
GROUP BY c.region_id, r.region_name ORDER BY customer_count DESC; </br>
### Output:</br>
<p align="left">
  <img  src="https://github.com/Tungana-Bhavya/8-WEEK-SQL-CHALLENGE/blob/main/8-WEEK-CHALLENGE/CASE%20STUDY%20%234%20DATA%20BANK/IMAGES/CNE_3.jpg">
</p>

<h3 align ='left'>4. How many days on average are customers reallocated to a different node?</h3>

SELECT ROUND(AVG(TO_DAYS(end_date) - TO_DAYS(start_date)),0) avg_number_of_day </br>
FROM customer_nodes WHERE end_date!='9999-12-31'; </br>
### Output:</br>
<p align="left">
  <img  src="https://github.com/Tungana-Bhavya/8-WEEK-SQL-CHALLENGE/blob/main/8-WEEK-CHALLENGE/CASE%20STUDY%20%234%20DATA%20BANK/IMAGES/CNE_4.jpg">
</p>

<h3 align ='left'>5. What is the median, 80th and 95th percentile for this same reallocation days metric for each region?</h3>

WITH tmp_rank AS ( </br>
SELECT region_name, </br>
TO_DAYS(end_date) - TO_DAYS(start_date) days_diff, </br>
ROW_NUMBER() OVER (ORDER BY TO_DAYS(end_date) - TO_DAYS(start_date)) row_num,</br>
COUNT(*) OVER () rows_sum FROM customer_nodes c JOIN regions r </br>
ON c.region_id = r.region_id WHERE end_date != '9999-12-31' </br>
GROUP BY region_name </br>
ORDER BY region_name) </br>

SELECT region_name, days_diff percentile_80 FROM tmp_rank WHERE row_num >= CEIL(rows_sum * 0.8); </br>

### Output:</br>
<p align="left">
  <img  src="https://github.com/Tungana-Bhavya/8-WEEK-SQL-CHALLENGE/blob/main/8-WEEK-CHALLENGE/CASE%20STUDY%20%234%20DATA%20BANK/IMAGES/CNE_5.jpg">
</p>

----

[B. Customer Transactions](https://github.com/Tungana-Bhavya/8-WEEK-SQL-CHALLENGE/blob/main/8-WEEK-CHALLENGE/CASE%20STUDY%20%234%20DATA%20BANK/DATABASE/CUSTOMER_TRANSACTION.sql)
  
<h3 align ='left'>1. What is the unique count and total amount for each transaction type?</h3>
SELECT txn_type, COUNT(*) unique_count, SUM(txn_amount) total_amount</details></br>
FROM customer_transactions</br>
GROUP BY txn_type</br>
ORDER BY txn_type;</br>

### Output:</br>
<p align="left">
  <img src = "https://github.com/Tungana-Bhavya/8-WEEK-SQL-CHALLENGE/blob/main/8-WEEK-CHALLENGE/CASE%20STUDY%20%234%20DATA%20BANK/IMAGES/CT_1.jpg">
</p>

<h3 align ='left'>2. What is the average total historical deposit counts and amounts for all customers</h3>

WITH deposit_tmp AS </br>
(</br>
SELECT customer_id, </br>
       txn_type, </br>
       COUNT(*) deposit_count, </br>
       SUM(txn_amount) deposit_amount </br>
FROM customer_transactions </br>
GROUP BY customer_id, txn_type </br>
) </br>
SELECT txn_type, ROUND(AVG(deposit_count),0) avg_deposit_count, </br>
ROUND(AVG(deposit_amount),0) avg_amount  </br>
FROM deposit_tmp WHERE txn_type = 'deposit' </br>
GROUP BY txn_type; </br>
### Output:</br>
<p align="left">
  <img src = "https://github.com/Tungana-Bhavya/8-WEEK-SQL-CHALLENGE/blob/main/8-WEEK-CHALLENGE/CASE%20STUDY%20%234%20DATA%20BANK/IMAGES/CT_2.jpg">
</p>

<h3 align ='left'>3. For each month - how many Data Bank customers make more than 1 deposit and either 1 purchase or 1 withdrawal in a single month?</h3>

WITH customer_cte AS</br>
(</br>
SELECT customer_id,</br>
EXTRACT(YEAR FROM txn_date) year,</br>
EXTRACT(MONTH FROM txn_date) month_id,</br>
DATE_FORMAT(txn_date, "%b") month_name,</br>
COUNT(CASE WHEN txn_type = "deposit" THEN 1 END) deposit_count,</br>
COUNT(CASE WHEN txn_type = "purchase" THEN 1 END) purchase_count,</br>
COUNT(CASE WHEN txn_type = "withdrawal" THEN 1 END) withdrawl_count</br>
FROM customer_transactions</br>
GROUP BY customer_id, DATE_FORMAT(txn_date, "%b"), </br>
EXTRACT(YEAR FROM txn_date), EXTRACT(MONTH FROM txn_date))</br>

SELECT month_id, month_name, year, COUNT(customer_id) customer_count FROM customer_cte</br>
WHERE deposit_count > 1 AND (purchase_count > 0 OR withdrawl_count > 0)</br>
GROUP BY month_id, month_name, year ORDER BY year, month_id;</br>
### Output:</br>
<p align="left">
  <img src = "https://github.com/Tungana-Bhavya/8-WEEK-SQL-CHALLENGE/blob/main/8-WEEK-CHALLENGE/CASE%20STUDY%20%234%20DATA%20BANK/IMAGES/CT_3.jpg">
</p>

<h3 align ='left'>4. What is the closing balance for each customer at the end of the month?</h3>

WITH cte1 AS (</br>
SELECT customer_id, EXTRACT(MONTH FROM txn_date) month_id,</br>
DATE_FORMAT(txn_date, "%b") month_name, EXTRACT(YEAR FROM txn_date) year,</br>
CASE WHEN txn_type = "deposit" THEN txn_amount ELSE -txn_amount END account_balance_change</br>
FROM customer_transactions ), </br>
cte2 AS (</br>
SELECT customer_id, month_id, month_name, year, SUM(account_balance_change) change_month</br>
FROM cte1 GROUP BY customer_id, month_id, month_name, year</br>
)</br>

SELECT customer_id, month_id, month_name, year,</br>
SUM(change_month) OVER (PARTITION BY customer_id ORDER BY YEAR) balance_closing</br>
FROM cte2 ORDER BY customer_id, month_id, month_name, year;</br>
### Output:</br>
<p align="left">
  <img src = "https://github.com/Tungana-Bhavya/8-WEEK-SQL-CHALLENGE/blob/main/8-WEEK-CHALLENGE/CASE%20STUDY%20%234%20DATA%20BANK/IMAGES/CT_4.jpg">
</p>

<h3 align ='left'>5. What is the percentage of customers who increase their closing balance by more than 5%? </h3>

WITH monthly_bal AS (</br>
SELECT customer_id, LAST_DAY(txn_date) end_of_date,</br>
SUM(CASE WHEN txn_type IN ('withdrawal', 'purchase') </br>
THEN -txn_amount ELSE txn_amount END) net_amount</br>
FROM customer_transactions</br>
GROUP BY customer_id, LAST_DAY(txn_date)</br>
),</br>

running_bal AS (</br>
SELECT customer_id, end_of_date, </br>
SUM(net_amount) OVER (</br>
PARTITION BY customer_id ORDER BY end_of_date) closing_balance</br>
FROM monthly_bal</br>
),</br>

bal_growth AS (</br>
SELECT customer_id, end_of_date, closing_balance,</br>
LAG(closing_balance) OVER (</br>
PARTITION BY customer_id ORDER BY end_of_date) prev_balance</br>
FROM running_bal</br>
),</br>

qualified_custs AS (</br>
SELECT DISTINCT customer_id FROM bal_growth</br>
WHERE (prev_balance IS NULL OR prev_balance = 0) AND closing_balance > 0</br>
OR (prev_balance > 0 AND (closing_balance - prev_balance) / prev_balance > 0.05)</br>
)</br>

SELECT CONCAT(ROUND(100.0 * COUNT(*) / (SELECT COUNT(DISTINCT customer_id) </br>
FROM customer_transactions), 2), ' %') custs_prcnt_with_growth</br>
FROM qualified_custs;</br>
### Output:</br>
<p align="left">
  <img src = "https://github.com/Tungana-Bhavya/8-WEEK-SQL-CHALLENGE/blob/main/8-WEEK-CHALLENGE/CASE%20STUDY%20%234%20DATA%20BANK/IMAGES/CT_5A.jpg">
</p>
</br>
</br>
<p align="left">
  <img src = "https://github.com/Tungana-Bhavya/8-WEEK-SQL-CHALLENGE/blob/main/8-WEEK-CHALLENGE/CASE%20STUDY%20%234%20DATA%20BANK/IMAGES/CT_5B.jpg"></p>

----

[C. Data Allocation Challenge](https://github.com/Tungana-Bhavya/8-WEEK-SQL-CHALLENGE/blob/main/8-WEEK-CHALLENGE/CASE%20STUDY%20%234%20DATA%20BANK/DATABASE/DATA_ALLOCATION_CHALLENGE.sql)

<h3 align ='left'>1. Running a customer balance column that includes the impact of each transaction ?</h3>

SELECT customer_id, txn_date, txn_type,</br>
txn_amount, SUM(CASE WHEN txn_type = "deposit" THEN txn_amount</br>
			         WHEN txn_type = "withdrawal" THEN -txn_amount</br>
                     WHEN txn_type = "purchase" THEN -txn_amount </br>
ELSE 0 END) OVER(PARTITION BY customer_id ORDER BY txn_date) running_balance</br>
FROM customer_transactions;

### Output:</br>
<p align="left">
<img src = "https://github.com/Tungana-Bhavya/8-WEEK-SQL-CHALLENGE/blob/main/8-WEEK-CHALLENGE/CASE%20STUDY%20%234%20DATA%20BANK/IMAGES/DAC_1.jpg"></p>


<h3 align ='left'>2. Customer balance at the end of each month</h3>

SELECT customer_id, EXTRACT(MONTH FROM txn_date) month_id,</br>
DATE_FORMAT(txn_date, "%b") month_name, </br>
SUM(CASE WHEN txn_type = "deposit" THEN txn_amount</br>
	     WHEN txn_type = "withdrawal" THEN -txn_amount</br>
         WHEN txn_type = "purchase" THEN -txn_amount ELSE 0 END) closing_balance</br>
FROM customer_transactions GROUP BY customer_id, </br>
EXTRACT(MONTH FROM txn_date), DATE_FORMAT(txn_date, "%b")</br>

### Output:</br>
<p align="left">
<img src = "https://github.com/Tungana-Bhavya/8-WEEK-SQL-CHALLENGE/blob/main/8-WEEK-CHALLENGE/CASE%20STUDY%20%234%20DATA%20BANK/IMAGES/DAC_2.jpg"></p>

<h3 align ='left'>3. Minimum, average and maximum values of the running balance for each customer.</h3>

WITH r_bal AS (</br>
SELECT customer_id, txn_date, txn_amount, </br>
SUM(CASE WHEN txn_type = "deposit" THEN txn_amount</br>
			   WHEN txn_type = "withdrawal" THEN -txn_amount</br>
        WHEN txn_type = "purchase" THEN -txn_amount </br>
ELSE 0 END) OVER(PARTITION BY customer_id ORDER BY txn_date) running_balance</br>
FROM customer_transactions</br>
)</br>

SELECT customer_id, AVG(running_balance) avg_running_balance,</br>
MIN(running_balance) min_running_balance,</br>
MAX(running_balance) max_running_balance</br>
FROM r_bal GROUP BY customer_id;</br>

### Output:</br>
<p align="left">
<img src = "https://github.com/Tungana-Bhavya/8-WEEK-SQL-CHALLENGE/blob/main/8-WEEK-CHALLENGE/CASE%20STUDY%20%234%20DATA%20BANK/IMAGES/DAC_3.jpg"></p>

----

[D. Extra Challenge](https://github.com/Tungana-Bhavya/8-WEEK-SQL-CHALLENGE/blob/main/8-WEEK-CHALLENGE/CASE%20STUDY%20%234%20DATA%20BANK/DATABASE/EXTRA_CHALLENGE.sql)

If the annual interest rate is set at 6% and the Data Bank team wants to reward its</br>
customers by increasing their data allocation based off the interest calculated on a </br>
daily basis at the end of each day, how much data would be required for this option on a </br>
monthly basis?</br>

WITH transactions AS (</br>
SELECT customer_id, txn_date, </br>
CASE WHEN txn_type = "deposit" THEN txn_amount ELSE -txn_amount END amount,</br>
DATEDIFF(CURDATE(), txn_date) + 1 days_diff</br>
FROM customer_transactions</br>
)</br>

SELECT customer_id, txn_date, ROUND(SUM(amount) OVER (</br>
PARTITION BY customer_id ORDER BY txn_date),2) balance,</br>
ROUND(SUM(amount * 0.06 * days_diff / 365) OVER (</br>
PARTITION BY customer_id ORDER BY txn_date),2) balance_with_interest</br>
FROM transactions ORDER BY customer_id, txn_date;</br>
### Output:</br>
<p align="left">
  <img src = "https://github.com/Tungana-Bhavya/8-WEEK-SQL-CHALLENGE/blob/main/8-WEEK-CHALLENGE/CASE%20STUDY%20%234%20DATA%20BANK/IMAGES/EC1.jpg"></p>


