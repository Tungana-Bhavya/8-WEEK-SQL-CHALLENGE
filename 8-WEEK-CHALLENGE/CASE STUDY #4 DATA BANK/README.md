## <p align ='left'>Case Study #5 Data Mart</p>

<img src="https://8weeksqlchallenge.com/images/case-study-designs/4.png" alt="Image" width="480" height="380">

### Case Study Questions

<details><summary><a href=""><b>A. Customer Nodes Exploration</b></a></summary>

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

h3 align ='left'>4. How many days on average are customers reallocated to a different node?</h3>

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
</p></details>

<details><summary><a href=""><b>B. Customer Transactions</b></a></summary>
1. What is the unique count and total amount for each transaction type?
2. What is the average total historical deposit counts and amounts for all customers?
3. For each month - how many Data Bank customers make more than 1 deposit and either 1 purchase or 1 withdrawal in a single month?
4. What is the closing balance for each customer at the end of the month?
5. What is the percentage of customers who increase their closing balance by more than 5%? </details>

<details><summary><a href=""><b>C. Data Allocation Challenge</b></a></summary></details>

<details><summary><a href=""><b> D. Extra Challenge</b></a></summary></details>

<details><summary><a href=""><b>Extension Request</b></a></summary></details>

