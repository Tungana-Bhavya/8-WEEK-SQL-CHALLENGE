## <p align ='left'>Case Study #5 Data Mart</p>

<img src="https://8weeksqlchallenge.com/images/case-study-designs/4.png" alt="Image" width="480" height="380">

### Case Study Questions

<details><summary><a href=""><b>A. Customer Nodes Exploration</b></a></summary>

<h3 align ='left'>1. How many unique nodes are there on the Data Bank system?</h3>
---
SELECT COUNT(DISTINCT node_id) unique_nodes FROM customer_nodes;
---
<p align="center">
  <img  src="https://github.com/Tungana-Bhavya/8-WEEK-SQL-CHALLENGE/blob/main/8-WEEK-CHALLENGE/CASE%20STUDY%20%234%20DATA%20BANK/IMAGES/CNE_1.jpg">
</p>

2. What is the number of nodes per region?
3. How many customers are allocated to each region?
4. How many days on average are customers reallocated to a different node?
5. What is the median, 80th and 95th percentile for this same reallocation days metric for each region?

<details><summary><a href=""><b>B. Customer Transactions</b></a></summary>

1. What is the unique count and total amount for each transaction type?
2. What is the average total historical deposit counts and amounts for all customers?
3. For each month - how many Data Bank customers make more than 1 deposit and either 1 purchase or 1 withdrawal in a single month?
4. What is the closing balance for each customer at the end of the month?
5. What is the percentage of customers who increase their closing balance by more than 5%?

<details><summary><a href=""><b>C. Data Allocation Challenge</b></a></summary>

<details><summary><a href=""><b> D. Extra Challenge</b></a></summary>

<details><summary><a href=""><b>Extension Request</b></a></summary>

