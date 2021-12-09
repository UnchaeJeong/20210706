--p.206 연습문제
--1.
SELECT *
FROM employees
WHERE manager_id IN(
        SELECT DISTINCT manager_id
        FROM employees
        WHERE department_id=20
        );
-- 2. 
select first_name
FROM employees
WHERE salary = (
        SELECT max(salary)
        FROM employees
        );

-- 3.
SELECT rnum, first_name, salary
FROM(SELECT first_name, salary, rownum as rnum
    FROM (SELECT first_name, salary
        FROM employees
        ORDER BY salary DESC)
    )
WHERE rnum between 3 and 5;

--4.
SELECT department_id, first_name, salary,
    (SELECT ROUND(avg(salary))
    FROM employees c
    WHERE a.department_id=c.department_id) as avg_sal
FROM employees a
WHERE salary >(
        SELECT avg(salary)
        FROM employees b
        WHERE b.department_id = a.department_id
);
--비교        
SELECT first_name, salary
FROM employees a
WHERE salary > (
    SELECT avg(salary)
    FROM employees b
    WHERE b.department_id = a.department_id
);


            