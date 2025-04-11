COPY cust_detail
FROM 'C:\\DA\\Projects\\SQL Project\\Credit_card_analysis\\DataSet\\customer.csv'
DELIMITER ','
CSV HEADER;


COPY cc_detail
FROM 'C:\\DA\\Projects\\SQL Project\\Credit_card_analysis\\DataSet\\credit_card.csv'
DELIMITER ','
CSV HEADER;