-- AVG, SUM, MIN, MAX
SELECT AVG(salary), SUM(salary), MIN(salary), MAX(salary)
FROM employees
WHERE job_id LIKE 'SA%';

SELECT MIN(hire_date), MAX(hire_date)
FROM employees;

SELECT MIN(first_name), MAX(first_name)
FROM employees;

SELECT MAX(salary)
FROM employees;

-- COUNT
SELECT COUNT(*) 
FROM employees;

SELECT COUNT(commission_pct)
FROM employees;

SELECT SUM(salary) AS �հ�,
            ROUND(AVG(salary), 2) AS ���,
            ROUND(STDDEV(salary), 2) AS ǥ������,
            ROUND(VARIANCE(salary), 2) AS �л�
FROM employees;

-- GROUP BY
SELECT department_id, AVG(salary)
FROM employees
GROUP BY department_id;

SELECT department_id, job_id, SUM(salary)
FROM  employees
GROUP BY department_id, job_id;

-- HAVING
SELECT department_id, ROUND(AVG(salary), 2)
FROM employees
GROUP BY department_id
HAVING AVG(salary) > 8000;