-- 1. Delinquent vs. Non-Delinquent customer count --

SELECT delinquent_acc, COUNT(*) AS Count
FROM cc_detail
GROUP BY delinquent_acc;

-- 2. Average utilization by delinquency --

SELECT 
	delinquent_acc, 
	Round(AVG(avg_utilization_ratio),2) AS Avg_Utilization
FROM cc_detail
GROUP BY delinquent_acc;

-- 3. Transaction amount vs. delinquency --

SELECT delinquent_acc, AVG(total_trans_amt) AS Avg_Amount
FROM cc_detail
GROUP BY delinquent_acc;


-- 4. Top 5 states with most delinquents  --

SELECT c.state_cd, COUNT(*) AS Delinquent_Count
FROM cust_detail c
JOIN cc_detail d ON c.client_num = d.client_num
WHERE d.delinquent_acc = '1'
GROUP BY c.state_cd
ORDER BY Delinquent_Count DESC
LIMIT 5;

-- 5. Delinquency by card category --

SELECT card_category, COUNT(*) FILTER (WHERE delinquent_acc = '1') AS Delinquent_Count
FROM cc_detail
GROUP BY card_category;


-- 6. Credit limit average in delinquent vs. non-delinquent --

SELECT delinquent_acc, 
	ROUND(AVG(credit_limit),2) AS Avg_Credit
FROM cc_detail
GROUP BY delinquent_acc;

-- 7. Delinquency rate by gender --

SELECT c.gender, 
    ROUND(COUNT(*) FILTER (WHERE d.delinquent_acc = '1') * 100.0 / COUNT(*),2) AS Delinquency_Rate
FROM cust_detail c
JOIN cc_detail d ON c.client_num = d.client_num
GROUP BY c.gender;


-- 8. Revolving balance and risk (binned) --

SELECT 
    ROUND(total_revolving_bal, -2) AS Balance_Bin,
    COUNT(*) FILTER (WHERE delinquent_acc = '1') AS Delinquent_Count
FROM cc_detail
GROUP BY Balance_Bin
ORDER BY Balance_Bin;


-- 9. Experience type and delinquency --

SELECT exp_type, COUNT(*) FILTER (WHERE Delinquent_Acc = '1') AS Delinquent_Count
FROM cc_detail
GROUP BY exp_type;

-- 10. Loan status vs. delinquency --

SELECT c.personal_loan, d.delinquent_acc, COUNT(*) AS Count
FROM cust_detail c
JOIN cc_detail d ON c.client_Num = d.client_Num
GROUP BY c.personal_loan, d.delinquent_acc;