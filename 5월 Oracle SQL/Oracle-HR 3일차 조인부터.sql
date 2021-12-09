--p.171, equi join 동등조인
SELECT e.first_name, e.salary, m.first_name, m.salary
FROM employees e, employees m
WHERE e.manager_id = m.employee_id AND e.salary>m.salary;
--where절에 조건을 넣을 수 있다.
-- 양 테이블에서 빼오고 싶은 부분만 떼오는 것.

--[2.3 self join]
--사원번호가 103인 사원의 이름과 매니저의 이름을 출력.
SELECT e.first_name AS employee_name,
        m.first_name AS manager_name
FROM employees e, employees m
WHERE e.manager_id = m.employee_id AND e.employee_id=103;

[2.4 equi join이 아닌 것은 다 non-equi join] - euqi join보다 계산량이 많음. 하나씩 다 서치해야 하기 때문에
--desc jobs;
--SELECT * FROM jobs;
SELECT e.first_name, e.salary, j.job_title
FROM employees e, jobs j
WHERE e.salary
BETWEEN j.min_salary AND j.max_salary
ORDER BY e.first_name;

-- [2.5 OUTER JOIN] p.174
SELECT e.employee_id, e.first_name, e.hire_date,
        J.start_date, j.end_date, j.job_id, j.department_id
FROM employees e, job_history j
WHERE e.employee_id = j.employee_id(+)
ORDER BY j.employee_id;
--작은 B에 (+)를 해주는 것 확인.
SELECT COUNT(*) FROM employees;
--desc job_history;
SELECT COUNT(employee_id) FROM job_history;
-- 107>10이므로 작은쪽에 (+)를 해주는 것. 뒤에서 나올 것.
--확인 식
SELECT employee_id, first_name FROM employees
WHERE employee_id NOT IN(101,102,122,176,200,201);
SELECT employee_id FROM job_history;
--공통점으로 묶는 것도 묶지만 없는 것들도 나타내고 싶을 때, OUTER JOIN
-- 부서가 바뀐 인원 뿐만아니라 안바뀐 인원들도 보고 싶을 때 즉, 모든 사원의 job history를 확인하고 싶을 때.
--A, B가 있을 때, A기준으로 A와 B와 겹치는 부분도 같이 뽑아내고 싶을 때.
-- B에 없는 내용은 NULL로 채워서 보여달라.
-- = job history가 없는 것들은 NULL로 처리.

--[안시 조인]표준
--[3.1cross join] = cartesian product와 거의 같은 개념임.
SELECT employee_id, department_name
FROM employees
CROSS JOIN departments;
--인출된 행 2889 개. 107 * 29

--[3.2natural join]
--[3.3 equi join = USING JOIN] p.179예제
SELECT first_name, department_name
FROM employees
JOIN departments
USING(department_id);
--= 
SELECT first_name, department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id;
-- 안시표준 조인, 동등조인 둘 다 같음.

--[3.4 ON JOIN]안시표준
SELECT department_name, street_address, city, state_province
FROM departments d
JOIN locations l
ON d.location_id = l.location_id; -- 조건을 더 넣을 수 있음.

--1) 여러 테이블의 조인
SELECT e.first_name, d.department_name,
    l.street_address ||', ' ||l.city ||', '||
l.state_province as address
FROM employees e
JOIN departments d ON e.department_id=d.department_id
JOIN locations l ON d.location_id=l.location_id;
--employee하고 location은 공통이 없지만 departments와 location을 묶고 난 걸 employee랑 묶는 것.
--3개 테이블 조인, 

--[2) WHERE 절과의 혼용] - 빼고 싶은 내용은 WHERE절로(employee_id = 103을 빼는 것)

SELECT e.first_name AS name,
        d.department_name as department
FROM employees e
JOIN departments d
ON e.department_id = d.department_id
WHERE employee_id = 103;
--구조를 빼온 이후 where은 행단위로 빼오는 것. + projection(열을 디스플레이 하는 것)
-- employee_id 103번의 부서와 이름은 무엇인가? 를 알아내는 것.
-- 설명을 다시 이해 하는 것 중요**

--3)ON 절에 WHERE 절의 조건 추가
SELECT e.first_name AS name,
        d.department_name as department
FROM employees e
JOIN departments d
ON e.department_id = d.department_id AND employee_id = 103;
--where 지우고 and 만 넣어주면 같은 값 나온다.

--[3.5 OUTER JOIN]
SELECT e.employee_id, e.first_name, e.hire_date,
        j.start_date, j.end_date, j.job_id, j.department_id
FROM employees e
LEFT OUTER JOIN job_history j
ON      e.employee_id = j.employee_id
ORDER BY j.employee_id;
--left를 기준으로 다 가져오고(employees), right를 붙이는 것. 나머지는 없으니 NULL로 놓는 것.
--employees(101,102,....) + (job_history(101,101,102...) + NULL)
--right join을 해보자
SELECT e.employee_id, e.first_name, e.hire_date,
        j.start_date, j.end_date, j.job_id, j.department_id
FROM employees e
RIGHT OUTER JOIN job_history j
ON      e.employee_id = j.employee_id
ORDER BY j.employee_id;

-- 