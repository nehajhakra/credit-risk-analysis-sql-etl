# 💳 CREDIT RISK ANALYSIS using SQL (ETL Project)  
🚀 *Transforming raw data into financial insights*

---

## 📘 Project Overview

This project is a **hands-on simulation of an end-to-end ETL (Extract, Transform, Load)** process using SQL to analyze credit risk in a financial dataset.  

From cleaning messy CSV files to building smart queries that identify high-risk customers and loan patterns — this project showcases how SQL can powerfully drive **data insights** in the world of **banking & finance**.

---

## 📦 Dataset Details

The project uses four primary CSV datasets:

| Dataset        | Description                            |
|----------------|----------------------------------------|
| `customers.csv`     | Customer profile with credit score, income, etc. |
| `loans.csv`         | Loan details with amount, type, term, etc.        |
| `transactions.csv`  | Customer transactions history        |
| `payments.csv`      | Loan payments and due status         |

---

## 🛠️ ETL Workflow (SQL)

### 🔍 **Extract**
- Imported all `.csv` files using `LOAD DATA INFILE`
- Enabled secure loading with `SET GLOBAL local_infile = 1`

### 🧹 **Transform**
- Cleaned invalid dates (`0000-00-00` → `NULL`)
- Converted strings to proper `DATE` formats
- Created derived columns using `CASE`, `JOIN`, and `CTE`s
- Applied aggregations and filters to engineer risk metrics

### 🧩 **Load**
- Structured data into MySQL tables: `customers`, `loans`, `transactions`, `payments`
- Ensured referential integrity using `FOREIGN KEY` constraints

---

## 📊 Analytical SQL Insights

✨ Here's what I explored:

- 🧮 **Loan Metrics**: Total, average, max, min loan amounts
- 🔗 **Joins**: Customer-Loan relationships
- 🔍 **Missed Payments**: Identified high-risk profiles using `CTEs`
- 📈 **Loan Trends**: Approval stats, most borrowed categories
- 🪜 **Window Functions**: Ranking top borrowers & rolling payment totals
- 🚦 **Risk Categorization**: Applied `CASE` logic to tag customers as `High`, `Medium`, `Low Risk`

---

## 🧠 Key Learnings

- Real-world SQL data cleaning & preprocessing  
- Advanced SQL: `CTEs`, `CASE`, `RANK`, `ROW_NUMBER`, `JOINs`  
- Business logic behind **credit scoring** & **risk prediction**  
- Efficiently structuring data for further BI or Python analysis

---

## 📌 Future Scope

📍 Coming soon:
- 📈 Power BI Dashboard
- 🐍 Python Visualizations (Pandas + Matplotlib)
- 📦 Deployment on Cloud / Streamlit (stretch goal)

---     ETL Flow Diagram
              ┌────────────────────────────┐
                │        Source Files        │
                │  (CSV: customers, loans,   │
                │   transactions, payments)  │
                └────────────┬───────────────┘
                             │
                             ▼
                ┌────────────────────────────┐
                │     Data Loading (E)       │
                │  LOAD DATA INFILE queries  │
                │  with custom date parsing  │
                └────────────┬───────────────┘
                             │
                             ▼
                ┌────────────────────────────┐
                │     Data Storage (T)       │
                │   MySQL Tables Created:    │
                │   - customers              │
                │   - loans                  │
                │   - transactions           │
                │   - payments               │
                └────────────┬───────────────┘
                             │
                             ▼
                ┌────────────────────────────┐
                │    Data Transformation     │
                │ - Aggregations (SUM, AVG)  │
                │ - JOINs (INNER, LEFT)      │
                │ - CTEs (High Risk Users)   │
                │ - Window Functions (RANK)  │
                │ - CASE WHEN (Risk Category)│
                └────────────┬───────────────┘
                             │
                             ▼
                ┌────────────────────────────┐
                │     Data Analysis (L)      │
                │  - Risk Trends             │
                │  - Loan Behaviors          │
                │  - Missed Payments         │
                └────────────┬───────────────┘
                             │
                             ▼
                ┌────────────────────────────┐
                │   Future Visualization     │
                │   (Python / Power BI)      │
                └────────────────────────────┘


---

## 🙌 Let's Connect

📩 **If you're into SQL, Data Analytics, or Finance — I'd love to connect!**  
👉 https://www.linkedin.com/in/neha-jhakra-395a201a2/ 🌟 Star this repo if you found it helpful

---

**#SQL #ETL #CreditRisk #DataAnalytics #Finance #PortfolioProject #MySQL #BusinessInsights**
