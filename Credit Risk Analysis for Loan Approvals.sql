CREATE DATABASE credit_risk_analysis;
USE credit_risk_analysis;

-- 1. customer table 
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    gender CHAR(1),
    income INT,
    employment_type VARCHAR(50),
    credit_score INT
);


SET GLOBAL local_infile = 1;
SHOW VARIABLES LIKE 'local_infile';

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/customers_medium.csv'
INTO TABLE customers
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- 2. Loans table 
CREATE TABLE loans (
    loan_id INT PRIMARY KEY,
    customer_id INT,
    loan_amount INT,
    loan_type VARCHAR(50),
    interest_rate DECIMAL(5,2),
    term_months INT,
    approval_status VARCHAR(50),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/loans_medium.csv'
INTO TABLE loans
FIELDS TERMINATED BY ','  
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS;

-- 3. Transaction table 
CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY,
    customer_id INT,
    amount INT,
    transaction_type VARCHAR(100),
    transaction_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/transactions_medium.csv'
INTO TABLE transactions
FIELDS TERMINATED BY ','  
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS;

-- 4. Payments table 

CREATE TABLE payments (
    payment_id INT PRIMARY KEY,
    customer_id INT,
    loan_id INT,
    amount_paid INT,
    due_date DATE,
    paid_date DATE NULL,
    status VARCHAR(50),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (loan_id) REFERENCES loans(loan_id)
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/payments_medium_cleaned.csv'
INTO TABLE payments
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(payment_id, customer_id, loan_id, amount_paid, @due_date, @paid_date, status)
SET due_date = IF(@due_date = '0000-00-00' OR @due_date = '', NULL, STR_TO_DATE(@due_date, '%Y-%m-%d')),
    paid_date = IF(@paid_date = '0000-00-00' OR @paid_date = '', NULL, STR_TO_DATE(@paid_date, '%Y-%m-%d'));

-- 5 . view all data tables 

SELECT * FROM customers;
SELECT * FROM loans;
SELECT * FROM transactions;
SELECT * FROM payments;
 -- 6. Aggregate Functions (SUM, AVG, COUNT, MAX, MIN)- Total Loan Amount, Average Interest Rate, and Loan Count
SELECT 
    COUNT(loan_id) AS total_loans,
    SUM(loan_amount) AS total_loan_amount,
    AVG(interest_rate) AS avg_interest_rate,
    MAX(loan_amount) AS max_loan_amount,
    MIN(loan_amount) AS min_loan_amount
FROM loans;
 -- 7. Basic Joins (INNER JOIN, LEFT JOIN, RIGHT JOIN) - Customer Loan Details (INNER JOIN)
 SELECT 
    c.customer_id, 
    c.name, 
    c.credit_score, 
    l.loan_amount, 
    l.loan_type, 
    l.approval_status
FROM customers c
INNER JOIN loans l ON c.customer_id = l.customer_id;

-- 8. Advanced Joins (LEFT JOIN, RIGHT JOIN, FULL OUTER JOIN) - Customers Who Haven’t Taken Loans (LEFT JOIN)
SELECT c.customer_id, c.name, c.credit_score, l.loan_id
FROM customers c
LEFT JOIN loans l ON c.customer_id = l.customer_id
WHERE l.loan_id IS NULL;
  
  -- 9. Common Table Expressions (CTEs) - WITH high_risk_customers AS (
    WITH high_risk_customers AS (
    SELECT c.customer_id, c.name, c.credit_score, COUNT(p.payment_id) AS missed_payments
    FROM customers c
    LEFT JOIN payments p ON c.customer_id = p.customer_id AND p.status = 'Missed'
    GROUP BY c.customer_id, c.name, c.credit_score
    HAVING c.credit_score < 600 AND COUNT(p.payment_id) > 3
)
SELECT * FROM high_risk_customers;
-- 10 . Window Functions (RANK, DENSE_RANK, ROW_NUMBER)
-- Ranking Customers Based on Loan Amounts
SELECT 
    customer_id, 
    loan_id, 
    loan_amount, 
    RANK() OVER (PARTITION BY customer_id ORDER BY loan_amount DESC) AS loan_rank
FROM loans;
 -- Top 5 Customers Who Borrow the Most Money (ROW_NUMBER)
 SELECT * FROM (
    SELECT 
        customer_id, 
        SUM(loan_amount) AS total_loans, 
        ROW_NUMBER() OVER (ORDER BY SUM(loan_amount) DESC) AS rnk
    FROM loans
    GROUP BY customer_id
) ranked
WHERE rnk <= 5;

-- 11. Rolling Totals and Moving Averages (Window Functions) -  Loan Repayment Trend (Rolling Total of Amount Paid)
SELECT 
    customer_id, 
    paid_date, 
    amount_paid,
    SUM(amount_paid) OVER (PARTITION BY customer_id ORDER BY paid_date) AS rolling_total
FROM payments;
 
 -- 12. Case Statements with Joins - Credit Risk Categorization
 SELECT 
    c.customer_id, 
    c.name, 
    c.credit_score,
    COUNT(p.payment_id) AS missed_payments,
    CASE 
        WHEN c.credit_score < 600 AND COUNT(p.payment_id) > 3 THEN 'High Risk'
        WHEN c.credit_score BETWEEN 600 AND 700 AND COUNT(p.payment_id) BETWEEN 1 AND 3 THEN 'Medium Risk'
        ELSE 'Low Risk'
    END AS risk_category
FROM customers c
LEFT JOIN payments p ON c.customer_id = p.customer_id AND p.status = 'Missed'
GROUP BY c.customer_id, c.name, c.credit_score;

-- 13. Finding Loan Approval Trends (GROUP BY with HAVING)
SELECT loan_type, COUNT(loan_id) AS total_loans
FROM loans
GROUP BY loan_type
HAVING COUNT(loan_id) > 10;


 










