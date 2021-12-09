
--[4. grouping sets]
SELECT TO_CHAR(department_id), ROUND(AVG(salary),2)
FROM employees
GROUP BY department_id
UNION
SELECT job_id, ROUND(AVG(salary),2)
FROM employees
GROUP BY job_id
ORDER BY 1;
--[4. grouping sets = 따로따로 붙인 것과 grouping sets(집합)+ order by ]
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

--[5. rollup, cube 사용]
SELECT department_id, job_id, ROUND(AVG(salary),2), COUNT(*)
FROM employees
GROUP BY department_id, job_id
ORDER BY department_id, job_id;
-- 위의 식의 하나만 AD_ASST 직원만 보려면
SELECT department_id, job_id
FROM employees
WHERE job_id = 'AD_ASST';
--표 보면서 해보자, roll up
SELECT department_id, job_id, ROUND(AVG(salary),2),COUNT(*)
FROM employees
GROUP BY ROLLUP(department_id, job_id)
ORDER BY department_id, job_id;
--cube도 해보자, department에 대한 통계 + job_id 통계,  null = 소계
SELECT department_id, job_id, ROUND(AVG(salary),2), COUNT(*)
FROM employees
GROUP BY CUBE(department_id, job_id)
ORDER BY department_id, job_id;

--[6.Grouping] 
SELECT
    DECODE(GROUPING(department_id), 1, '소계',
            TO_CHAR(department_id)) 부서,
    DECODE(GROUPING(job_id), 1, '소계',job_id) AS 직무,
    ROUND(AVG(salary),2) 평균,
    COUNT(*) 사원의수
FROM
    employees
GROUP BY CUBE(department_id, job_id)
ORDER BY 부서, 직무;

---[7.grouping_id]
SELECT
DECODE(GROUPING_ID(department_id, job_id), 2, '소계',
    3, '합계', TO_CHAR(department_id)) 부서번호,
DECODE(GROUPING_ID(department_id, job_id), 1, '소계',
    3, '합계', job_id) 직무,
GROUPING_ID(department_id,job_id) as GID,
ROUND(AVG(salary),2) 평균,
COUNT(*) 사원의수
FROM employees
GROUP BY CUBE(department_id, job_id)
ORDER BY 부서번호, 직무;
-- 	SA_REP	0	7000	1 
--  소계	    1 	7000	1   두 개는  CUBE에 의해서 리턴된 값이 아님.
SELECT * FROM employees
WHERE job_id = 'SA_REP' AND department_id IS NULL;
--178	Kimberely	Grant	KGRANT	011.44.1644.429263	07/05/24	SA_REP	7000	0.15	149	(null)

--[5장 분석함수]]
--[1.1 순위구하기 함수]
SELECT employee_id, department_id, salary,
RANK() OVER(ORDER BY salary DESC) sal_rank,
DENSE_RANK() OVER(ORDER BY salary DESC) sal_dense_rank,
ROW_NUMBER() OVER(ORDER BY salary DESC) sal_number
FROM employees;

--가상분포함수
SELECT employee_id, department_id, salary,
    CUME_DIST() OVER(ORDER BY salary DESC) sal_cum_dist,
    PERCENT_RANK() OVER(ORDER BY salary DESC) sal_pct_rank
FROM employees;
-- sal_cum_dist : 값을 받는사람의 퍼센트가 나오는 것. 1명분, 2명분.....

--1.3  비율함수, RATIO_TO_REPORT
SELECT first_name, salary,
    ROUND(RATIO_TO_REPORT(salary) OVER(),4) salary_ratio
FROM employees
WHERE job_id = 'IT_PROG';
-- 백분율임. 다 더하면 1나옴.
-- over() -> 아무것도 안넣은 건 나온 값 그대로 쓰자는 것.

SELECT department_id,
    round(AVG(salary) OVER(PARTITION BY department_id),2)
FROM employees;
-- partition by 는 department_id를 그룹핑을 해서 평균을 내서 보여달란 얘기. 
SELECT department_id, round(AVG(salary))
FROM employees
GROUP BY department_id;
--그룹화의 개념임. 그룹핑해서 계산값을 내놓느냐(group by), 1:1로 매핑해서 계산 값을 내놓느냐(partition)

--[1.4 분배 함수 NTILE]
SELECT employee_id, department_id, salary,
    NTILE(10) OVER(ORDER BY salary DESC) sal_quart_tile
FROM employees
WHERE department_id=50;

--[1.5 LAG, LEAD] 앞의 수, 뒤의 수 순차적으로 계속 뽑아내는 것
SELECT employee_id,
LAG(salary,1,0) OVER(ORDER BY salary) AS lower_sal,
salary,
LEAD(salary,1,0) OVER(ORDER BY salary) AS higher_sal
FROM employees
ORDER BY salary;

--[1.6 LISTAGG]
SELECT department_id, first_name --> 에러
FROM employees
GROUP BY department_id;
--
SELECT department_id, count(first_name) --는 가능.
FROM employees
GROUP BY department_id;
--
SELECT department_id,
    LISTAGG(first_name, ',') WITHIN GROUP(ORDER BY hire_date) AS names
FROM employees
GROUP BY department_id;
-- group by로 구분할건데
-- ,로 구분자로 해서 hire_date로 순서화 해서 names를 찍어내는 것. 
SELECT department_id, first_name
FROM employees
GROUP BY department_id, first_name;
--50	Payam
--50	Irene
--50	Mozhe
--50	Jason
--이런 결과값을 한줄로 나올 수 있게 하고 싶은 것.50 Payam, Irene, Mozhe, Jason


--[2. 윈도우 절]
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
--salary에서 앞에서 한 칸 뒤에서 한 칸 가져오는 것. 
SELECT employee_id, salary
FROM employees
ORDER BY salary;
--my_sal을 보여주려는 것. first_value(먼저 걸린 것 나오고), last_value(뒤에 나온 것 나오는 것)

--[3. 선형회귀 함수]

--[4. 피벗 테이블]p.156***
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
--행을 열로 바꾸는게 피벗, 열을 행으로 바꾸는 걸 역피벗. 
--피벗함수
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
-- 이해를 돕기 위한 sum(week_id)
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
--employee_id, sales는 행 그대로 가고, 요일에 할당된 수가 요일에 맞춰 숫자가 들어가고, 나머지는 NULL
--PIVOT은 행을 하나의 열로 바꾸는 것. UNPIVOT은 반대로.

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
--1102	5	300	300	230	120	150 피벗한 이 행렬을 UNPIVOT 하는 것.
SELECT employee_id, week_id, week_day, sales
FROM sales
UNPIVOT
(
    sales
    FOR week_day
    IN(sales_mon, sales_tue, sales_wed, sales_thu, sales_fri)
);

-- p.162 연습문제
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
-- UNBOUNDED PRECEDING : 윈도우의 시작 위치가 첫번째 ROW
-- UNBOUNDED FOLLOWING : 윈도우의 마지막 위치가 마지막 ROW
-- FIRST_VALUE : 
-- LAST_VALUE : 
--생략

--[p.170 조인을 이용한 다중테이블 검색]
SELECT COUNT(*) FROM employees;
SELECT COUNT(* )FROM departments;
-- 행 107 * 27 = 2889개 행 생성
SELECT count(*)--first_name, department_name
FROM employees, departments;
--이게 CARTESIAN PRODUCT JOIN

SELECT first_name, e.department_id, department_name
FROM employees e, departments d;
--desc employees;
--desc departments; - 둘다 있어서 충돌(오류), 그래서 가명을 쓰는 것.

--[2.2 equi join]
SELECT department_id, first_name FROM employees;
SELECT department_id, department_name FROM departments;

SELECT e.first_name, e.department_id, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id;
--이게 동등조인임. 107개 중 null값 1개를 뺀 106개가 결과값으로 나옴.
