-- =====================================================
-- Employee Attrition Analysis (SQL)
-- Dataset: IBM HR Analytics Employee Attrition (1470 rows)
-- Tool: MySQL Workbench
-- =====================================================

USE employee_attrition;

-- 1. Total number of employees
SELECT COUNT(*) AS total_employees
FROM employees;

-- 2. Attrition count (Yes vs No)
SELECT Attrition, COUNT(*) AS employee_count
FROM employees
GROUP BY Attrition;

-- 3. Overall attrition rate (%)
SELECT 
  COUNT(*) AS total_employees,
  SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS left_company,
  ROUND(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS attrition_pct
FROM employees;

-- 4. Attrition by department
SELECT Department,
  COUNT(*) AS total_employees,
  SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS left_company,
  ROUND(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS attrition_pct
FROM employees
GROUP BY Department
ORDER BY attrition_pct DESC;

-- 5. Attrition by overtime
SELECT OverTime,
  COUNT(*) AS total_employees,
  SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS left_company,
  ROUND(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS attrition_pct
FROM employees
GROUP BY OverTime;

-- 6. Attrition by age group
SELECT 
  CASE 
    WHEN Age < 25 THEN 'Under 25'
    WHEN Age BETWEEN 25 AND 34 THEN '25-34'
    WHEN Age BETWEEN 35 AND 44 THEN '35-44'
    WHEN Age BETWEEN 45 AND 54 THEN '45-54'
    ELSE '55+'
  END AS age_group,
  COUNT(*) AS total_employees,
  SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS left_company,
  ROUND(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS attrition_pct
FROM employees
GROUP BY age_group
ORDER BY MIN(Age);

-- 7. Attrition by job satisfaction level
-- (1 = Low, 2 = Medium, 3 = High, 4 = Very High)
SELECT JobSatisfaction,
  COUNT(*) AS total_employees,
  SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS left_company,
  ROUND(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS attrition_pct
FROM employees
GROUP BY JobSatisfaction
ORDER BY JobSatisfaction;

-- 8. Average monthly income: employees who stayed vs left
SELECT Attrition,
  COUNT(*) AS total_employees,
  ROUND(AVG(MonthlyIncome), 0) AS avg_monthly_income
FROM employees
GROUP BY Attrition;

-- 9. Attrition by years at company (tenure groups)
SELECT 
  CASE 
    WHEN YearsAtCompany < 2 THEN '0-1 years'
    WHEN YearsAtCompany BETWEEN 2 AND 5 THEN '2-5 years'
    WHEN YearsAtCompany BETWEEN 6 AND 10 THEN '6-10 years'
    ELSE '10+ years'
  END AS tenure_group,
  COUNT(*) AS total_employees,
  SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS left_company,
  ROUND(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS attrition_pct
FROM employees
GROUP BY tenure_group
ORDER BY MIN(YearsAtCompany);

-- 10. Top 5 job roles with highest attrition rate
SELECT JobRole,
  COUNT(*) AS total_employees,
  SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS left_company,
  ROUND(100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS attrition_pct
FROM employees
GROUP BY JobRole
ORDER BY attrition_pct DESC
LIMIT 5;