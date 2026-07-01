/*
================================================================================
 HR Attrition Analysis
 SQL Queries for Business Questions
 Dataset: hr_analytics_project.employee_hr
================================================================================
*/

-- Preview the dataset
SELECT * FROM hr_analytics_project.employee_hr;
SELECT COUNT(*) FROM hr_analytics_project.employee_hr;


-- ================================================================
-- SECTION 1: WORKFORCE OVERVIEW
-- ================================================================

-- Q1. How many employees are currently in the dataset?
SELECT COUNT(DISTINCT employee_number)
FROM hr_analytics_project.employee_hr;


-- Q2. How many employees have left the company?
SELECT COUNT(*) 
FROM hr_analytics_project.employee_hr
WHERE attrition = 'Yes';


-- Q3. What is the employee attrition rate (%)?
SELECT
    ROUND(
        COUNT(CASE WHEN attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM hr_analytics_project.employee_hr;


-- Q4. What is the average employee age?
SELECT ROUND(AVG(age), 0) AS avg_age
FROM hr_analytics_project.employee_hr;


-- Q5. What is the average monthly income?
SELECT AVG(monthly_income) AS avg_monthly_income
FROM hr_analytics_project.employee_hr;


-- ================================================================
-- SECTION 2: WORKFORCE DEMOGRAPHICS
-- ================================================================

-- Q6. How many employees are there in each department?
SELECT department, COUNT(department) AS employee_count
FROM hr_analytics_project.employee_hr
GROUP BY department;


-- Q7. How many employees belong to each job role?
SELECT job_role, COUNT(job_role) AS employee_count
FROM hr_analytics_project.employee_hr
GROUP BY job_role;


-- Q8. What is the gender distribution across the organization?
SELECT gender, COUNT(gender) AS employee_count
FROM hr_analytics_project.employee_hr
GROUP BY gender;


-- Q9. What is the marital status distribution?
SELECT marital_status, COUNT(marital_status) AS employee_count
FROM hr_analytics_project.employee_hr
GROUP BY marital_status;


-- Q10. How are employees distributed across education levels?
SELECT education, COUNT(education) AS employee_count
FROM hr_analytics_project.employee_hr
GROUP BY education;


-- ================================================================
-- SECTION 3: COMPENSATION ANALYSIS
-- ================================================================

-- Q11. What is the average monthly income by department?
SELECT 
    department,
    AVG(monthly_income) AS avg_monthly_income
FROM hr_analytics_project.employee_hr
GROUP BY department;


-- Q12. Which job roles receive the highest average monthly income?
SELECT
    job_role,
    AVG(monthly_income) AS avg_monthly_income
FROM hr_analytics_project.employee_hr
GROUP BY job_role
ORDER BY avg_monthly_income DESC
LIMIT 5;


-- Q13. How does salary vary across different job levels?
SELECT 
    job_level,
    AVG(monthly_income) AS avg_monthly_income
FROM hr_analytics_project.employee_hr
GROUP BY job_level
ORDER BY avg_monthly_income DESC;


-- Q14. Is there a difference in average salary between male and female employees?
SELECT 
    ROUND(
        AVG(CASE WHEN gender = 'Female' THEN monthly_income END) -
        AVG(CASE WHEN gender = 'Male' THEN monthly_income END),
        2
    ) AS income_diff
FROM hr_analytics_project.employee_hr;


-- ================================================================
-- SECTION 4: ATTRITION ANALYSIS (CORE BUSINESS PROBLEM)
-- ================================================================

-- Q15. Which departments have the highest attrition?
SELECT 
    department,
    COUNT(attrition) AS num_of_attrition
FROM hr_analytics_project.employee_hr
WHERE attrition = 'Yes'
GROUP BY department
ORDER BY num_of_attrition DESC;


-- Q16. Which job roles experience the highest attrition?
SELECT 
    job_role,
    COUNT(attrition) AS num_of_attrition
FROM hr_analytics_project.employee_hr
WHERE attrition = 'Yes'
GROUP BY job_role
ORDER BY num_of_attrition DESC
LIMIT 5;


-- Q17. Does overtime increase employee attrition?
SELECT
    overtime,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    ROUND(
        SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM hr_analytics_project.employee_hr
GROUP BY overtime
ORDER BY attrition_rate DESC;


-- Q18. Does business travel frequency influence attrition?
SELECT
    business_travel,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    ROUND(
        SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM hr_analytics_project.employee_hr
GROUP BY business_travel
ORDER BY attrition_rate DESC;


-- Q19. Which age groups have the highest attrition?
SELECT MIN(age) AS min_age, MAX(age) AS max_age
FROM hr_analytics_project.employee_hr;

SELECT
    CASE
        WHEN age BETWEEN 18 AND 25 THEN 'Young Professionals'
        WHEN age BETWEEN 26 AND 35 THEN 'Early Career'
        WHEN age BETWEEN 36 AND 45 THEN 'Mid Career'
        WHEN age BETWEEN 46 AND 55 THEN 'Senior Career'
        ELSE 'Pre-Retirement'
    END AS age_group,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    ROUND(
        SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM hr_analytics_project.employee_hr
GROUP BY age_group
ORDER BY attrition_rate DESC;


-- Q20. Does employee tenure (YearsAtCompany) affect attrition?
SELECT
    CASE
        WHEN years_at_company BETWEEN 0 AND 2 THEN '0-2 Years'
        WHEN years_at_company BETWEEN 3 AND 5 THEN '3-5 Years'
        WHEN years_at_company BETWEEN 6 AND 10 THEN '6-10 Years'
        WHEN years_at_company BETWEEN 11 AND 20 THEN '11-20 Years'
        ELSE '20+ Years'
    END AS tenure_group,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    ROUND(
        SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM hr_analytics_project.employee_hr
GROUP BY tenure_group
ORDER BY attrition_rate DESC;


-- ================================================================
-- SECTION 5: EMPLOYEE SATISFACTION
-- ================================================================

-- Q21. What is the average job satisfaction score by department?
SELECT 
    department,
    AVG(job_satisfaction) AS avg_job_satisfaction
FROM hr_analytics_project.employee_hr
GROUP BY department;


-- Q22. Does lower work-life balance correspond to higher attrition?
SELECT 
    work_life_balance,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    ROUND(
        SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM hr_analytics_project.employee_hr
GROUP BY work_life_balance
ORDER BY attrition_rate DESC;


-- Q23. Does environment satisfaction influence attrition?
SELECT 
    environment_satisfaction,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    ROUND(
        SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM hr_analytics_project.employee_hr
GROUP BY environment_satisfaction
ORDER BY attrition_rate DESC;


-- ================================================================
-- SECTION 6: PERFORMANCE & CAREER GROWTH
-- ================================================================

-- Q24. How does performance rating vary across departments?
SELECT 
    department,
    AVG(performance_rating) AS avg_rating
FROM hr_analytics_project.employee_hr
GROUP BY department
ORDER BY avg_rating DESC;


-- Q25. Does the time since the last promotion appear to influence employee attrition?
SELECT 
    CASE
        WHEN years_since_last_promotion BETWEEN 0 AND 5 THEN '0-5 Years'
        WHEN years_since_last_promotion BETWEEN 6 AND 10 THEN '6-10 Years'
        WHEN years_since_last_promotion BETWEEN 11 AND 15 THEN '11-15 Years'
        ELSE '15+ Years'
    END AS promotion_group,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    ROUND(
        SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM hr_analytics_project.employee_hr
GROUP BY promotion_group
ORDER BY attrition_rate DESC;


-- ================================================================
-- BONUS QUERIES (ADVANCED)
-- ================================================================

-- Q26. Which departments have the highest average years of experience?
SELECT 
    department,
    ROUND(AVG(total_working_years), 0) AS avg_experience
FROM hr_analytics_project.employee_hr
GROUP BY department
ORDER BY avg_experience DESC;


-- Q27. How many employees work overtime in each department?
SELECT 
    department,
    COUNT(overtime) AS num_overtime
FROM hr_analytics_project.employee_hr
GROUP BY department
ORDER BY num_overtime DESC;


-- Q28. Which education fields have the highest attrition?
SELECT 
    education_field,
    COUNT(attrition) AS num_attrition
FROM hr_analytics_project.employee_hr
WHERE attrition = 'Yes'
GROUP BY education_field
ORDER BY num_attrition DESC;


-- Q29. How does stock option level relate to attrition?
SELECT 
    stock_option_level,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    ROUND(
        SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM hr_analytics_project.employee_hr
GROUP BY stock_option_level
ORDER BY attrition_rate DESC;


-- Q30. Which combination of Department + Job Role has the highest attrition?
SELECT
    department,
    job_role,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    ROUND(
        SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM hr_analytics_project.employee_hr
GROUP BY department, job_role
ORDER BY attrition_rate DESC
LIMIT 1;


-- Q31. Rank job roles by average salary using a window function.
WITH avg_salary AS (
    SELECT 
        job_role,
        AVG(monthly_income) AS avg_monthly_income
    FROM hr_analytics_project.employee_hr
    GROUP BY job_role
)
SELECT 
    job_role,
    ROUND(avg_monthly_income, 2) AS avg_monthly_income,
    DENSE_RANK() OVER (ORDER BY avg_monthly_income DESC) AS salary_rank 
FROM avg_salary;


-- Q32. Rank departments by attrition rate using a window function.
WITH attrition_rate AS (
    SELECT
        department,
        COUNT(*) AS total_employees,
        SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
        ROUND(
            SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
            2
        ) AS attrition_rate
    FROM hr_analytics_project.employee_hr
    GROUP BY department
)
SELECT
    department,
    total_employees,
    employees_left,
    attrition_rate,
    RANK() OVER (ORDER BY attrition_rate DESC) AS department_rank
FROM attrition_rate;


-- Q33. Find the top 10 highest-paid employees in each department using ROW_NUMBER().
WITH ranked_employees AS (
    SELECT
        employee_number,
        department,
        monthly_income,
        ROW_NUMBER() OVER (
            PARTITION BY department
            ORDER BY monthly_income DESC
        ) AS row_num
    FROM hr_analytics_project.employee_hr
)
SELECT
    employee_number,
    department,
    monthly_income,
    row_num
FROM ranked_employees
WHERE row_num <= 10
ORDER BY department, row_num;


-- Q34. Compare average salary against the company average using a subquery or CTE.
WITH company_average AS (
    SELECT
        AVG(monthly_income) AS company_avg_salary
    FROM hr_analytics_project.employee_hr
)
SELECT
    department,
    ROUND(AVG(monthly_income), 2) AS department_avg_salary,
    ROUND(company_avg_salary, 2) AS company_avg_salary,
    ROUND(
        AVG(monthly_income) - company_avg_salary,
        2
    ) AS salary_difference
FROM hr_analytics_project.employee_hr
CROSS JOIN company_average
GROUP BY department, company_avg_salary;


-- Q35. Identify departments where attrition is above the company average.
WITH company_average AS (
    SELECT
        AVG(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS company_avg_attrition
    FROM hr_analytics_project.employee_hr
)
SELECT
    department,
    ROUND(
        AVG(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100,
        2
    ) AS department_attrition_rate,
    ROUND(company_avg_attrition * 100, 2) AS company_attrition_rate,
    ROUND(
        (AVG(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) - company_avg_attrition) * 100,
        2
    ) AS difference
FROM hr_analytics_project.employee_hr
CROSS JOIN company_average
GROUP BY department, company_avg_attrition;
