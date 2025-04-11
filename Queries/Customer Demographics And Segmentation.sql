-- 1. Age group distribution of customers --

SELECT 
    CASE 
        WHEN customer_age < 30 THEN 'Under 30'
        WHEN customer_age BETWEEN 30 AND 50 THEN '30-50'
        ELSE 'Above 50'
    END AS Age_Group, COUNT(*) AS Count
FROM cust_detail
GROUP BY Age_Group;


-- 2. Gender-wise income average --

SELECT gender, ROUND(AVG(income),2) AS Avg_Income
FROM cust_detail
GROUP BY gender;

-- 3. Marital status vs. credit card satisfaction --

SELECT marital_status, ROUND(AVG(cust_satisfaction_score),2) AS Avg_Score
FROM cust_detail
GROUP BY marital_status;


-- 4. Top 5 states with highest number of customers --

SELECT state_cd, COUNT(*) AS customer_count
FROM cust_detail
GROUP BY state_cd
ORDER BY customer_count DESC
LIMIT 5;


-- 5. Education level distribution --

SELECT education_level, COUNT(*) AS Count
FROM cust_detail
GROUP BY education_level
ORDER BY Count DESC;

-- 6. Dependent count vs. personal loan --

SELECT dependent_count, COUNT(*) FILTER (WHERE personal_loan = 'Yes') AS With_Loan
FROM cust_detail
GROUP BY dependent_count
ORDER BY dependent_count;


-- 7. House ownership by income bracket --

SELECT 
    CASE 
        WHEN income < 40000 THEN 'Low Income'
        WHEN income BETWEEN 40000 AND 80000 THEN 'Mid Income'
        ELSE 'High Income'
    END AS Income_Group,
    house_owner,
    COUNT(*) AS Count
FROM cust_detail
GROUP BY Income_Group, house_owner
ORDER BY  Count DESC;


-- 8. Car ownership by gender --

SELECT gender, car_owner, COUNT(*) AS Count
FROM cust_detail
GROUP BY gender, car_owner;


-- 9. Top job roles by satisfaction score --

SELECT customer_job, AVG(cust_satisfaction_score) AS Avg_Score
FROM cust_detail
GROUP BY customer_job
ORDER BY Avg_Score DESC
LIMIT 10;


-- 10. Zip code concentration --

SELECT zipcode, COUNT(*) AS customer_count
FROM cust_detail
GROUP BY zipcode
ORDER BY customer_count DESC
LIMIT 10;
