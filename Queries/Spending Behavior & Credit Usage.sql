-- 1. Average credit limit by card category --

SELECT card_category, ROUND(AVG(credit_limit),2) AS Avg_Credit_Limit
FROM cc_detail
GROUP BY card_category;


-- 2. Total transactions by category --

SELECT card_category, SUM(total_trans_Amt) AS Total_Amount
FROM cc_detail
GROUP BY card_category
ORDER BY Total_Amount DESC;

-- 3. Top 5 customers by transaction count --

SELECT client_num, total_trans_ct
FROM cc_detail
ORDER BY total_trans_ct DESC
LIMIT 5;

-- 4. Average utilization by experience type --

SELECT exp_type, ROUND(AVG(avg_utilization_ratio),2) AS Avg_Util
FROM cc_detail
GROUP BY exp_type
ORDER BY Avg_Util DESC;

-- 5. Quarterly transaction trend --

SELECT qtr, SUM(total_trans_amt) AS Total_Quarterly_Amount
FROM cc_detail
GROUP BY qtr
ORDER BY qtr;


-- 6. Utilization ratio vs. Interest earned --

SELECT ROUND(avg_utilization_ratio,1) AS Util_Bucket, ROUND(AVG(interest_earned),3) AS Avg_Interest
FROM cc_detail
GROUP BY Util_Bucket
ORDER BY Util_Bucket;


-- 7. Chip usage impact on transaction amount --

SELECT use_chip, ROUND(AVG(total_trans_amt),2) AS Avg_Amount
FROM cc_detail
GROUP BY use_chip;


-- 8. Card category vs. delinquency --

SELECT card_category, COUNT(*) FILTER (WHERE delinquent_acc = '1' ) AS Delinquent_Count
FROM cc_detail
GROUP BY card_category;


-- 9. Credit limit vs. Revolving balance correlation (binned) --

SELECT 
    ROUND(credit_limit, -3) AS Credit_Bin,
    ROUND(AVG(total_revolving_bal),2) AS Avg_Balance
FROM cc_detail
GROUP BY Credit_Bin
ORDER BY Credit_Bin;


-- 10. Monthly activation analysis --

SELECT TO_CHAR(week_start_date, 'Month') AS Month, SUM(activation_30_days) AS Total_Activations
FROM cc_detail
GROUP BY Month
ORDER BY Total_Activations DESC;


-- 11. Credit Utilization Quartile Buckets using NTILE (Window Function)   ??? --  
 
SELECT 
    client_num,
    avg_utilization_ratio,
    NTILE(4) OVER (ORDER BY avg_utilization_ratio) AS Util_Quartile
FROM cc_detail;


-- 12. CTE + Join: Customers with Above-Average Spending  ???? --

WITH AvgSpend AS (
    SELECT AVG(total_trans_amt) AS avg_amt FROM cc_detail
)
SELECT c.client_num, c.total_trans_amt
FROM cc_detail c, avg_spend a
WHERE c.Total_Trans_Amt > a.avg_amt;


-- 13. Window Function for % Change in Transaction Amount Week over Week ????? --

SELECT 
    client_num,
    week_start_date,
    total_trans_amt,
    LAG(total_trans_amt) OVER (PARTITION BY client_num ORDER BY week_start_date) AS Prev_Week,
    ROUND(
        (total_trans_amt - LAG(total_trans_amt) OVER (PARTITION BY client_num ORDER BY week_start_date)) * 100.0 /
        NULLIF(LAG(total_trans_amt) OVER (PARTITION BY client_num ORDER BY week_start_date), 0), 2
    ) AS Week_Over_Week_Change
FROM cc_detail


-- 14. Top 5 high-income customers and their spending pattern --

WITH TopIncome AS (
    SELECT client_num, income
    FROM cust_detail
    ORDER BY income DESC
    LIMIT 5
)
SELECT 
    t.client_num,
    t.income,
    c.total_trans_amt,
    c.avg_utilization_ratio
FROM TopIncome t
JOIN cc_detail c ON t.client_num = c.client_num;

-- 15. Find customers with high transaction amount and their income bracket --

SELECT 
    c.client_num,
    c.total_trans_amt,
    cd.income,
    cd.customer_job
FROM cc_detail c
INNER JOIN cust_detail cd ON c.client_num = cd.client_num
WHERE c.total_trans_amt > 10000;


-- 16. Average transaction amount by gender --

SELECT 
    cd.gender,
    ROUND(AVG(c.total_trans_amt),2) AS Avg_Transaction
FROM cc_detail c
JOIN cust_detail cd ON c.client_num = cd.client_num
GROUP BY cd.gender;