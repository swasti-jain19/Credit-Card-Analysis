-- 1. Average acquisition cost by card category --

SELECT 
	card_category, 
	ROUND(AVG(customer_acq_cost),2) AS Avg_Cost
FROM cc_detail
GROUP BY card_category;


-- 2. Total activations by quarter --

SELECT qtr, SUM(activation_30_days) AS Total_Activations
FROM cc_detail
GROUP BY qtr;

-- 3. Top 5 weeks by activations --

SELECT week_start_date, activation_30_days
FROM cc_detail
ORDER BY activation_30_days DESC
LIMIT 5;

-- 4. Acquisition cost vs. income band --

SELECT 
    CASE 
        WHEN c.income < 40000 THEN 'Low'
        WHEN c.income BETWEEN 40000 AND 80000 THEN 'Mid'
        ELSE 'High'
    END AS Income_Band,
    ROUND(AVG(d.customer_acq_cost),2) AS Avg_Acq_Cost
FROM cust_detail c
JOIN cc_detail d ON c.client_num = d.client_num
GROUP BY income_band;


-- 5. Customer acquisition efficiency --

SELECT customer_acq_cost, activation_30_days
FROM cc_detail
ORDER BY activation_30_days DESC;


-- 6. Week-on-week acquisition trend ?????? --

SELECT week_num, SUM(activation_30_days) AS Total_Activations
FROM cc_detail
GROUP BY week_num
ORDER BY week_num::INT;

-- 7. Cost vs. transaction amount correlation ?????? --

SELECT ROUND(customer_acq_cost, -100) AS Cost_Bin, AVG(total_trans_amt) AS Avg_Trans
FROM cc_detail
GROUP BY Cost_Bin
ORDER BY Cost_Bin;


-- 8. Top states by activation (merged with customer table) --

SELECT c.state_cd, SUM(d.activation_30_days) AS Activations
FROM cust_detail c
JOIN cc_detail d ON c.client_Num = d.client_Num
GROUP BY c.state_cd
ORDER BY Activations DESC
LIMIT 5;


-- 9. Activation vs. delinquency --

SELECT 
	delinquent_acc, 
	ROUND(AVG(activation_30_days),2) AS Avg_Activation
FROM cc_detail
GROUP BY delinquent_acc;


-- 10. Age-wise activation behavior --

SELECT 
    CASE 
        WHEN c.customer_age < 30 THEN 'Under 30'
        WHEN c.customer_age BETWEEN 30 AND 50 THEN '30-50'
        ELSE '50+'
    END AS Age_Group,
    ROUND(AVG(d.activation_30_days),2) AS Avg_Activation
FROM cust_detail c
JOIN cc_detail d ON c.client_num = d.client_num
GROUP BY Age_Group;