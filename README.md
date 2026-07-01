# HR Attrition Analysis

A data analysis project identifying the key factors driving employee attrition, using Excel for data cleaning, SQL for analysis, and Power BI for visualization.

## 📊 Project Overview

This project analyzes IBM's HR Analytics employee dataset to understand workforce demographics, compensation, job satisfaction, performance, and — most importantly — what drives employees to leave the company. The goal was to translate raw HR data into actionable insights that support employee retention and workforce planning decisions.

**Business Objective:** Analyze workforce data to identify the key factors influencing employee attrition and evaluate workforce demographics, compensation, job satisfaction, performance, and employee engagement, generating insights that help HR improve retention and support data-driven decision-making.

## 📁 Dataset

- **Source:** [Kaggle – IBM HR Analytics Employee Attrition Dataset](https://www.kaggle.com/datasets/pavansubhasht/ibm-hr-analytics-attrition-dataset)
- **Size:** 1,470 rows × 35 columns

Key columns include `Age`, `Attrition`, `BusinessTravel`, `Department`, `Education`, `EducationField`, `EnvironmentSatisfaction`, `Gender`, `JobLevel`, `JobRole`, `JobSatisfaction`, `MaritalStatus`, `MonthlyIncome`, `OverTime`, `PerformanceRating`, `StockOptionLevel`, `TotalWorkingYears`, `WorkLifeBalance`, `YearsAtCompany`, `YearsSinceLastPromotion`, and `YearsWithCurrManager`.

Three columns were removed during cleaning as they carried no analytical value:
| Column | Reason for Removal |
|---|---|
| `EmployeeCount` | Constant value (1) for every record |
| `StandardHours` | Same value (80) for every employee |
| `Over18` | Contains only the value "Y" |

## 🧹 Data Cleaning (Excel)

- Checked for duplicate records
- Checked for blank values
- Verified data types
- Removed unnecessary columns (see table above)
- Looked for inconsistent categories
- Checked for impossible values
- Saved the cleaned dataset

## 🔍 Business Questions (Answered via SQL)

**Section 1 — Workforce Overview**
1. How many employees are currently in the dataset?
2. How many employees have left the company?
3. What is the employee attrition rate (%)?
4. What is the average employee age?
5. What is the average monthly income?

**Section 2 — Workforce Demographics**
6. How many employees are there in each department?
7. How many employees belong to each job role?
8. What is the gender distribution across the organization?
9. What is the marital status distribution?
10. How are employees distributed across education levels?

**Section 3 — Compensation Analysis**
11. What is the average monthly income by department?
12. Which job roles receive the highest average monthly income?
13. How does salary vary across different job levels?
14. Is there a difference in average salary between male and female employees?

**Section 4 — Attrition Analysis (Core Business Problem)**
15. Which departments have the highest attrition?
16. Which job roles experience the highest attrition?
17. Does overtime increase employee attrition?
18. Does business travel frequency influence attrition?
19. Which age groups have the highest attrition?
20. Does employee tenure (YearsAtCompany) affect attrition?

**Section 5 — Employee Satisfaction**
21. What is the average job satisfaction score by department?
22. Does lower work-life balance correspond to higher attrition?
23. Does environment satisfaction influence attrition?

**Section 6 — Performance & Career Growth**
24. How does performance rating vary across departments?
25. Does the time since the last promotion appear to influence employee attrition?

**Bonus Queries (Advanced — window functions & CTEs)**
26. Which departments have the highest average years of experience?
27. How many employees work overtime in each department?
28. Which education fields have the highest attrition?
29. How does stock option level relate to attrition?
30. Which combination of Department + Job Role has the highest attrition?
31. Rank job roles by average salary using a window function
32. Rank departments by attrition rate using a window function
33. Find the top 10 highest-paid employees in each department using `ROW_NUMBER()`
34. Compare average salary against the company average using a CTE
35. Identify departments where attrition is above the company average

## ✅ Key Findings

- **Workforce size:** 1,470 employees — **237 have left** the company, for an overall **attrition rate of 16.12%**
- **Average age:** 37 — **Average monthly income:** ₹6,502.93
- **Research & Development has the highest attrition count** (133 employees), but **Human Resources has the highest attrition rate relative to its size**
- **Sales Representatives** have the smallest headcount of any role but the **highest attrition rate (≈40%)**
- **Overtime is the strongest single predictor of attrition** in this dataset: employees working overtime leave at **30.53%**, nearly 3x the rate of those who don't (**10.44%**)
- **Frequent business travel** is linked to a much higher attrition rate (**24.91%**) compared to no travel (**8.00%**) — roughly 3x higher
- **Work-life balance matters:** employees with the lowest score leave more than twice as often as those with the best score (**31.25% vs. 17.65%**)
- **Environment satisfaction matters:** the least-satisfied group leaves nearly twice as often as the most-satisfied group (**25.35% vs. 13.45%**)
- **Tenure is a major factor:** employees in their first 0–2 years leave at **29.82%**, nearly 5x the rate of long-tenured staff (**~6.67%** at 11–20 years)
- **Young Professionals (18–25)** have the highest attrition rate by age group (**35.77%**), dropping steadily with seniority
- **Pay hierarchy is steep:** Managers and Research Directors earn 2–6x more than entry-level roles like Sales Representatives and Laboratory Technicians
- **Sales attrition runs 4.5 points above the company average** (20.63% vs. 16.12%), while R&D sits 2.28 points *below* average — making Sales the department most in need of retention attention
- Promotion timing is a comparatively **weak driver** of attrition — rates stay fairly flat across different time-since-last-promotion buckets, unlike overtime or tenure

## 📈 Power BI Dashboard

The dashboard contains four pages:

**1. Executive Overview** — *Workforce overview & attrition snapshot*
![Executive Overview](powerbi/page1_executive_overview.png)
- KPI cards: Total Employees (1.47K), Total Attrition (237), Attrition Rate % (16.12%), Average Monthly Income (₹6.50K)
- Total Attrition and Attrition Rate % by Department
- Total Attrition and Attrition Rate % by Job Role
- Department slicer

**2. Attrition Drivers** — *Key drivers of employee attrition (centerpiece page)*
![Attrition Drivers](powerbi/page2_attrition_drivers.png)
- Attrition by OverTime
- Attrition by Business Travel
- Attrition by Work-Life Balance
- Attrition by Environment Satisfaction

**3. Compensation & Career Growth**
![Compensation and Career Growth](powerbi/page3_compensation_career_growth.png)
- Attrition by Promotion Bucket
- Monthly Income by Job Role and by Job Level
- Attrition by Tenure Bucket
- Monthly Income by Department

**4. Salary Ranking & Department Variance**
![Salary Ranking and Variance](powerbi/page4_salary_ranking_variance.png)
- Job roles ranked by average salary
- Attrition variance by department vs. company average

## 🛠️ Tools Used

- **Excel** – data cleaning, quality checks, removing unnecessary columns
- **SQL** – querying the cleaned dataset to answer all 35 business questions, including window functions (`RANK`, `DENSE_RANK`, `ROW_NUMBER`) and CTEs
- **Power BI** – four-page interactive dashboard and visualization

## 📂 Repository Structure

```
├── data/                # Raw and cleaned dataset
├── sql/                 # SQL queries used to answer business questions
├── powerbi/             # Power BI (.pbix) file and dashboard screenshots
├── report/              # Written analysis / Word document
└── README.md
```

## 🚀 How to Use

1. Clone this repository
2. Open the `.pbix` file in Power BI Desktop to explore the interactive dashboard
3. Review the SQL scripts in `/sql` to see how each business question was answered
4. See `/report` for the full written analysis

---
*Dataset source: [Kaggle – IBM HR Analytics Employee Attrition Dataset](https://www.kaggle.com/datasets/pavansubhasht/ibm-hr-analytics-attrition-dataset)*
