CREATE TABLE cust_detail (
    Client_Num BIGINT PRIMARY KEY,
    Customer_Age INT,
    Gender CHAR(1),
    Dependent_Count INT,
    Education_Level TEXT,
    Marital_Status TEXT,
    state_cd CHAR(2),
    Zipcode INT,
    Car_Owner TEXT,
    House_Owner TEXT,
    Personal_loan TEXT,
    contact TEXT,
    Customer_Job TEXT,
    Income INT,
    Cust_Satisfaction_Score INT
);

CREATE TABLE cc_detail (
    Client_Num BIGINT,
    Card_Category TEXT,
    Annual_Fees INT,
    Activation_30_Days INT,
    Customer_Acq_Cost INT,
    Week_Start_Date DATE,
    Week_Num TEXT,
    Qtr TEXT,
    current_year INT,
    Credit_Limit FLOAT,
    Total_Revolving_Bal INT,
    Total_Trans_Amt INT,
    Total_Trans_Vol INT,
    Avg_Utilization_Ratio FLOAT,
    "Use Chip" TEXT,
    "Exp Type" TEXT,
    Interest_Earned FLOAT,
    Delinquent_Acc INT,
    FOREIGN KEY (Client_Num) REFERENCES cust_detail(Client_Num)
);
