
--[4. grouping sets]
SELECT TO_CHAR(department_id), ROUND(AVG(salary),2)
FROM employees
GROUP BY department_id
UNION
SELECT job_id, ROUND(AVG(salary),2)
FROM employees
GROUP BY job_id
ORDER BY 1;
--[4. grouping sets = ���ε��� ���� �Ͱ� grouping sets(����)+ order by ]
SELECT department_id, job_id, ROUND(AVG(salary),2)
FROM employees
GROUP BY GROUPING SETS(department_id, job_id)
ORDER BY department_id, job_id;

SELECT department_id, job_id, manager_id,
        ROUND(AVG(salary), 2) as avg_sal
FROM employees
GROUP BY
    GROUPING SETS((department_id, job_id),(job_id, manager_id))
ORDER BY department_id, job_id, manager_id;

--[5. rollup, cube ���]
SELECT department_id, job_id, ROUND(AVG(salary),2), COUNT(*)
FROM employees
GROUP BY department_id, job_id
ORDER BY department_id, job_id;
-- ���� ���� �ϳ��� AD_ASST ������ ������
SELECT department_id, job_id
FROM employees
WHERE job_id = 'AD_ASST';
--ǥ ���鼭 �غ���, roll up
SELECT department_id, job_id, ROUND(AVG(salary),2),COUNT(*)
FROM employees
GROUP BY ROLLUP(department_id, job_id)
ORDER BY department_id, job_id;
--cube�� �غ���, department�� ���� ��� + job_id ���,  null = �Ұ�
SELECT department_id, job_id, ROUND(AVG(salary),2), COUNT(*)
FROM employees
GROUP BY CUBE(department_id, job_id)
ORDER BY department_id, job_id;

--[6.Grouping] 
SELECT
    DECODE(GROUPING(department_id), 1, '�Ұ�',
            TO_CHAR(department_id)) �μ�,
    DECODE(GROUPING(job_id), 1, '�Ұ�',job_id) AS ����,
    ROUND(AVG(salary),2) ���,
    COUNT(*) ����Ǽ�
FROM
    employees
GROUP BY CUBE(department_id, job_id)
ORDER BY �μ�, ����;

---[7.grouping_id]
SELECT
DECODE(GROUPING_ID(department_id, job_id), 2, '�Ұ�',
    3, '�հ�', TO_CHAR(department_id)) �μ���ȣ,
DECODE(GROUPING_ID(department_id, job_id), 1, '�Ұ�',
    3, '�հ�', job_id) ����,
GROUPING_ID(department_id,job_id) as GID,
ROUND(AVG(salary),2) ���,
COUNT(*) ����Ǽ�
FROM employees
GROUP BY CUBE(department_id, job_id)
ORDER BY �μ���ȣ, ����;
-- 	SA_REP	0	7000	1 
--  �Ұ�	    1 	7000	1   �� ����  CUBE�� ���ؼ� ���ϵ� ���� �ƴ�.
SELECT * FROM employees
WHERE job_id = 'SA_REP' AND department_id IS NULL;
--178	Kimberely	Grant	KGRANT	011.44.1644.429263	07/05/24	SA_REP	7000	0.15	149	(null)

--[5�� �м��Լ�]]
--[1.1 �������ϱ� �Լ�]
SELECT employee_id, department_id, salary,
RANK() OVER(ORDER BY salary DESC) sal_rank,
DENSE_RANK() OVER(ORDER BY salary DESC) sal_dense_rank,
ROW_NUMBER() OVER(ORDER BY salary DESC) sal_number
FROM employees;

--��������Լ�
SELECT employee_id, department_id, salary,
    CUME_DIST() OVER(ORDER BY salary DESC) sal_cum_dist,
    PERCENT_RANK() OVER(ORDER BY salary DESC) sal_pct_rank
FROM employees;
-- sal_cum_dist : ���� �޴»���� �ۼ�Ʈ�� ������ ��. 1���, 2���.....

--1.3  �����Լ�, RATIO_TO_REPORT
SELECT first_name, salary,
    ROUND(RATIO_TO_REPORT(salary) OVER(),4) salary_ratio
FROM employees
WHERE job_id = 'IT_PROG';
-- �������. �� ���ϸ� 1����.
-- over() -> �ƹ��͵� �ȳ��� �� ���� �� �״�� ���ڴ� ��.

SELECT department_id,
    round(AVG(salary) OVER(PARTITION BY department_id),2)
FROM employees;
-- partition by �� department_id�� �׷����� �ؼ� ����� ���� �����޶� ���. 
SELECT department_id, round(AVG(salary))
FROM employees
GROUP BY department_id;
--�׷�ȭ�� ������. �׷����ؼ� ��갪�� ��������(group by), 1:1�� �����ؼ� ��� ���� ��������(partition)

--[1.4 �й� �Լ� NTILE]
SELECT employee_id, department_id, salary,
    NTILE(10) OVER(ORDER BY salary DESC) sal_quart_tile
FROM employees
WHERE department_id=50;

--[1.5 LAG, LEAD] ���� ��, ���� �� ���������� ��� �̾Ƴ��� ��
SELECT employee_id,
LAG(salary,1,0) OVER(ORDER BY salary) AS lower_sal,
salary,
LEAD(salary,1,0) OVER(ORDER BY salary) AS higher_sal
FROM employees
ORDER BY salary;

--[1.6 LISTAGG]
SELECT department_id, first_name --> ����
FROM employees
GROUP BY department_id;
--
SELECT department_id, count(first_name) --�� ����.
FROM employees
GROUP BY department_id;
--
SELECT department_id,
    LISTAGG(first_name, ',') WITHIN GROUP(ORDER BY hire_date) AS names
FROM employees
GROUP BY department_id;
-- group by�� �����Ұǵ�
-- ,�� �����ڷ� �ؼ� hire_date�� ����ȭ �ؼ� names�� ���� ��. 
SELECT department_id, first_name
FROM employees
GROUP BY department_id, first_name;
--50	Payam
--50	Irene
--50	Mozhe
--50	Jason
--�̷� ������� ���ٷ� ���� �� �ְ� �ϰ� ���� ��.50 Payam, Irene, Mozhe, Jason


--[2. ������ ��]
--[2.1 first_value, last_value]
SELECT employee_id,
FIRST_VALUE(salary)
    OVER(ORDER BY salary
        ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS lower_sal,
    salary AS my_sal,
    LAST_VALUE(salary)
        OVER(ORDER BY salary
            ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS higher_sal
FROM employees;
132	2100	2100	2200
128	2100	2200	2200
136	2200	2200	2400
127	2200	2400	2400
--salary���� �տ��� �� ĭ �ڿ��� �� ĭ �������� ��. 
SELECT employee_id, salary
FROM employees
ORDER BY salary;
--my_sal�� �����ַ��� ��. first_value(���� �ɸ� �� ������), last_value(�ڿ� ���� �� ������ ��)

--[3. ����ȸ�� �Լ�]

--[4. �ǹ� ���̺�]p.156***
CREATE TABLE     sales_data(
    employee_id NUMBER(6),
    week_id     NUMBER(2),
    week_day    VARCHAR2(10),
    sales       NUMBER(8,2)
);

INSERT INTO sales_data VALUES(1101, 4, 'SALES_MON', 100);
INSERT INTO sales_data VALUES(1102, 5, 'SALES_MON', 300);
INSERT INTO sales_data VALUES(1101, 4, 'SALES_TUE', 150);
INSERT INTO sales_data VALUES(1102, 5, 'SALES_TUE', 300);
INSERT INTO sales_data VALUES(1101, 4, 'SALES_WED', 80);
INSERT INTO sales_data VALUES(1102, 5, 'SALES_WED', 230);
INSERT INTO sales_data VALUES(1101, 4, 'SALES_THU', 60);
INSERT INTO sales_data VALUES(1102, 5, 'SALES_THU', 120);
INSERT INTO sales_data VALUES(1101, 4, 'SALES_FRI', 120);
INSERT INTO sales_data VALUES(1102, 5, 'SALES_FRI', 150);
COMMIT;
SELECT *FROM sales_data;
--���� ���� �ٲٴ°� �ǹ�, ���� ������ �ٲٴ� �� ���ǹ�. 
--�ǹ��Լ�
CREATE TABLE sales(
    employee_id NUMBER(6),
    week_id     NUMBER(2),
    sales_mon   NUMBER(8,2),
    sales_tue   NUMBER(8,2),
    sales_wed   NUMBER(8,2),
    sales_thu   NUMBER(8,2),
    sales_fri   NUMBER(8,2)
);
INSERT INTO sales VALUES(1101, 4, 100, 150, 80, 60, 120);
INSERT INTO sales VALUES(1102, 5, 300, 300, 230, 120, 150);
COMMIT;
SELECT * FROM sales;
SELECT *
FROM sales_data
PIVOT
(
    sum(sales)
    FOR week_day IN('SALES_MON' AS sales_mon,
                    'SALES_TUE' AS sales_tue,
                    'SALES_WED' AS sales_wed,
                    'SALES_THU' AS sales_thu,
                    'SALES_FRI' 
                    
                    AS sales_fri)
)
ORDER BY employee_id, week_id;
-- ���ظ� ���� ���� sum(week_id)
SELECT *
FROM sales_data
PIVOT
(
    sum(week_id)
    FOR week_day IN('SALES_MON' AS sales_mon,
                    'SALES_TUE' AS sales_tue,
                    'SALES_WED' AS sales_wed,
                    'SALES_THU' AS sales_thu,
                    'SALES_FRI' AS sales_fri)
)
ORDER BY employee_id;--, week_id;
--employee_id, sales�� �� �״�� ����, ���Ͽ� �Ҵ�� ���� ���Ͽ� ���� ���ڰ� ����, �������� NULL
--PIVOT�� ���� �ϳ��� ���� �ٲٴ� ��. UNPIVOT�� �ݴ��.

--[4.3 UNPIVOT]
SELECT *
FROM sales_data
PIVOT
(
    sum(sales)
    FOR week_day IN('SALES_MON' AS sales_mon,
                    'SALES_TUE' AS sales_tue,
                    'SALES_WED' AS sales_wed,
                    'SALES_THU' AS sales_thu,
                    'SALES_FRI' 
                    
                    AS sales_fri)
)
ORDER BY employee_id, week_id;
--1101	4	100	150	80	60	120
--1102	5	300	300	230	120	150 �ǹ��� �� ����� UNPIVOT �ϴ� ��.
SELECT employee_id, week_id, week_day, sales
FROM sales
UNPIVOT
(
    sales
    FOR week_day
    IN(sales_mon, sales_tue, sales_wed, sales_thu, sales_fri)
);

-- p.162 ��������
--1.
SELECT
    department_id,
    first_name,
    salary,
    RANK()
        OVER(PARTITION BY department_id
            ORDER BY salary DESC) as sal_rank,
    LAG(salary, 1,0)
        OVER(PARTITION BY department_id
            ORDER BY salary DESC) AS prev_salary,
    FIRST_VALUE(salary)
        OVER(PARTITION BY department_id
            ORDER BY salary DESC
            ROWS 1 PRECEDING) AS prev_salary2
FROM employees
ORDER BY department_id;
--2.
SELECT first_name
FROM employees
WHERE employee_id = (
    SELECT before_id
    FROM
    (
    SELECT employee_id, 
    LAG(employee_id,1,0) OVER(ORDER BY employee_id) AS before_id
    FROM employees
    )
WHERE employee_id=170
);
--3
SELECT employee_id, department_id,
    FIRST_VALUE(salary)
        OVER(PARTITION by department_id
            ORDER BY salary
            ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) lower_sal,
    LAST_VALUE(salary)
        OVER(PARTITION by department_id
            ORDER BY salary
            ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) higher_sal,
    LAST_
    
    VALUE(salary)
        OVER(PARTITION by department_id
            ORDER BY salary
            ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) - salary as diff_sal
FROM employees;
-- UNBOUNDED PRECEDING : �������� ���� ��ġ�� ù��° ROW
-- UNBOUNDED FOLLOWING : �������� ������ ��ġ�� ������ ROW
-- FIRST_VALUE : 
-- LAST_VALUE : 
--����

--[p.170 ������ �̿��� �������̺� �˻�]
SELECT COUNT(*) FROM employees;
SELECT COUNT(* )FROM departments;
-- �� 107 * 27 = 2889�� �� ����
SELECT count(*)--first_name, department_name
FROM employees, departments;
--�̰� CARTESIAN PRODUCT JOIN

SELECT first_name, e.department_id, department_name
FROM employees e, departments d;
--desc employees;
--desc departments; - �Ѵ� �־ �浹(����), �׷��� ������ ���� ��.

--[2.2 equi join]
SELECT department_id, first_name FROM employees;
SELECT department_id, department_name FROM departments;

SELECT e.first_name, e.department_id, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id;
--�̰� ����������. 107�� �� null�� 1���� �� 106���� ��������� ����.
