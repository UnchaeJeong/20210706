--p.171, equi join ��������
SELECT e.first_name, e.salary, m.first_name, m.salary
FROM employees e, employees m
WHERE e.manager_id = m.employee_id AND e.salary>m.salary;
--where���� ������ ���� �� �ִ�.
-- �� ���̺��� ������ ���� �κи� ������ ��.

--[2.3 self join]
--�����ȣ�� 103�� ����� �̸��� �Ŵ����� �̸��� ���.
SELECT e.first_name AS employee_name,
        m.first_name AS manager_name
FROM employees e, employees m
WHERE e.manager_id = m.employee_id AND e.employee_id=103;

[2.4 equi join�� �ƴ� ���� �� non-equi join] - euqi join���� ��귮�� ����. �ϳ��� �� ��ġ�ؾ� �ϱ� ������
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
--���� B�� (+)�� ���ִ� �� Ȯ��.
SELECT COUNT(*) FROM employees;
--desc job_history;
SELECT COUNT(employee_id) FROM job_history;
-- 107>10�̹Ƿ� �����ʿ� (+)�� ���ִ� ��. �ڿ��� ���� ��.
--Ȯ�� ��
SELECT employee_id, first_name FROM employees
WHERE employee_id NOT IN(101,102,122,176,200,201);
SELECT employee_id FROM job_history;
--���������� ���� �͵� ������ ���� �͵鵵 ��Ÿ���� ���� ��, OUTER JOIN
-- �μ��� �ٲ� �ο� �Ӹ��ƴ϶� �ȹٲ� �ο��鵵 ���� ���� �� ��, ��� ����� job history�� Ȯ���ϰ� ���� ��.
--A, B�� ���� ��, A�������� A�� B�� ��ġ�� �κе� ���� �̾Ƴ��� ���� ��.
-- B�� ���� ������ NULL�� ä���� �����޶�.
-- = job history�� ���� �͵��� NULL�� ó��.

--[�Ƚ� ����]ǥ��
--[3.1cross join] = cartesian product�� ���� ���� ������.
SELECT employee_id, department_name
FROM employees
CROSS JOIN departments;
--����� �� 2889 ��. 107 * 29

--[3.2natural join]
--[3.3 equi join = USING JOIN] p.179����
SELECT first_name, department_name
FROM employees
JOIN departments
USING(department_id);
--= 
SELECT first_name, department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id;
-- �Ƚ�ǥ�� ����, �������� �� �� ����.

--[3.4 ON JOIN]�Ƚ�ǥ��
SELECT department_name, street_address, city, state_province
FROM departments d
JOIN locations l
ON d.location_id = l.location_id; -- ������ �� ���� �� ����.

--1) ���� ���̺��� ����
SELECT e.first_name, d.department_name,
    l.street_address ||', ' ||l.city ||', '||
l.state_province as address
FROM employees e
JOIN departments d ON e.department_id=d.department_id
JOIN locations l ON d.location_id=l.location_id;
--employee�ϰ� location�� ������ ������ departments�� location�� ���� �� �� employee�� ���� ��.
--3�� ���̺� ����, 

--[2) WHERE ������ ȥ��] - ���� ���� ������ WHERE����(employee_id = 103�� ���� ��)

SELECT e.first_name AS name,
        d.department_name as department
FROM employees e
JOIN departments d
ON e.department_id = d.department_id
WHERE employee_id = 103;
--������ ���� ���� where�� ������� ������ ��. + projection(���� ���÷��� �ϴ� ��)
-- employee_id 103���� �μ��� �̸��� �����ΰ�? �� �˾Ƴ��� ��.
-- ������ �ٽ� ���� �ϴ� �� �߿�**

--3)ON ���� WHERE ���� ���� �߰�
SELECT e.first_name AS name,
        d.department_name as department
FROM employees e
JOIN departments d
ON e.department_id = d.department_id AND employee_id = 103;
--where ����� and �� �־��ָ� ���� �� ���´�.

--[3.5 OUTER JOIN]
SELECT e.employee_id, e.first_name, e.hire_date,
        j.start_date, j.end_date, j.job_id, j.department_id
FROM employees e
LEFT OUTER JOIN job_history j
ON      e.employee_id = j.employee_id
ORDER BY j.employee_id;
--left�� �������� �� ��������(employees), right�� ���̴� ��. �������� ������ NULL�� ���� ��.
--employees(101,102,....) + (job_history(101,101,102...) + NULL)
--right join�� �غ���
SELECT e.employee_id, e.first_name, e.hire_date,
        j.start_date, j.end_date, j.job_id, j.department_id
FROM employees e
RIGHT OUTER JOIN job_history j
ON      e.employee_id = j.employee_id
ORDER BY j.employee_id;

-- 