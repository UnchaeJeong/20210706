--7장 [1. 서브쿼리]p.192

SELECT first_name, salary
FROM employees
WHERE first_name = 'Nancy';

SELECT first_name, salary
FROM employees
WHERE salary > 12008;
-- 
SELECT first_name, salary
FROM employees
WHERE salary > (SELECT salary
                FROM employees
                WHERE first_name='Nancy');
--단일행, 다중행 서브쿼리
SELECT first_name, job_id, hire_date
FROM employees
WHERE job_id = (
    SELECT job_id
    FROM employees
    WHERE employee_id=103
);
--값 하나 넘겨올 때 연산자 쓸 수 있다. 
SELECT first_name, salary
FROM employees
WHERE salary > ANY(
    SELECT salary
    FROM employees
    WHERE first_name = 'David'
);
--
SELECT first_name, salary
FROM employees
WHERE first_name='David';
--세 명이 나옴. => 단일행 서브쿼리 못씀. 다중행 서브쿼리 쓸 수 있음.
-->ANY, <ANY, >ALL, <ALL 

--[4.상호연관 서브쿼리] 부모에 있는 서브쿼리를 가져다 쓰는 것.
SELECT first_name, salary
FROM employees a
WHERE salary > (
    SELECT avg(salary)
    FROM employees b
    WHERE b.department_id = a.department_id
);
--부모 것을 WHERE에서 가져다 쓰는 것. 창조해서 쓰는 것. 계산양 많은 것은 단점.
--뷰 v 테이블 = 인라인 뷰는 가상의 테이블로 쿼리문이 끝나면 사라짐.(컴퓨터가끝나면?)
--FROM절 SELECT 인라인뷰 (테이블 베이스로 가져옴)
--SELECT문에 SELECT 스칼라 서브쿼리 (값을 뿌려주는 것)
--WHERE 절에 SELECT문 중첩

--[5.스칼라서브쿼리]
SELECT first_name, (
    SELECT department_name
    FROM departments d
    WHERE d.department_id=e.department_id) department_name
FROM employees e
ORDER BY first_name;
-- =
SELECT first_name, department_name
FROM employees e
JOIN departments d ON (e.department_id=d.department_id)
ORDER BY first_name;
-- f10버튼으로 속도 확인 스칼라 서브쿼리의 경우 조인할 행의 수를 줄여 쿼리 성능 향상 가능
--JOIN은 FROM단에서 일어남. 테이블단에서 조합. 
-- 스칼라서브쿼리 : 테이블 값을 조합하는 것. 훨씬 빠르다. 

--[6.7. 인라인 뷰, 삼중 쿼리] 테이블 검사 때(상위 1등-10등, 20-30등 볼 때 사용가능)
SELECT row_number, first_name, salary
FROM (SELECT first_name, salary,
    row_number() OVER(ORDER BY salary DESC) AS row_number
    FROM employees)
WHERE row_number BETWEEN 11 AND 20;
--OVER partition orderby = 분석함수
-- 변수 중에 row_num, row_id 내부적으로 만든 변수. 넘버링 해주는 걸 리턴해준 값 = row_number
-- 등수를 내맘대로 꺼내 볼 수 있다. 
--=
SELECT rownum, first_name, salary
FROM (SELECT first_name, salary
    FROM employees
    ORDER BY salary DESC)
WHERE rownum BETWEEN 1 AND 10;
--1 and 10 숫자값을 바꾸면 값이 안나옴. 왜? 
-- rownum은 내부적으로 지원하는 값(내부변수). 사용가능. 
-- rownum 1값 세팅. rownum>=1라고 보면(시작값이 1임) rownum>=2라고 해버리면 쿼리값을 가져오지 않는다.
-- 값을 써야만 rownum이 2로 3으로 ... 증가. 문제는 rownum이 1로 스타트하는데 
-- rownum>=2라고 하면 거짓으로 테이블 값을 가져오지 않음.
-- rownum을 저장해뒀다가 사용할 때 rownumber로 사용하는 것.

SELECT rnum, first_name, salary
FROM(
    SELECT first_name, salary, rownum as rnum
    FROM( SELECT first_name, salary
        FROM employees
        ORDER BY salary DESC)
        )
WHERE rnum > 1 AND rnum <= 10;
-- FROM절 돌아갈 때 rownum rnum으로 저장.
-- 게시판 만들거나 뽑아올 때 유용하게 쓰임.

--[8. 계층 쿼리] 트리형태 디스플레이, 계산할 때
SELECT employee_id,
    LPAD(' ',3*(LEVEL-1))||first_name||' '||last_name,
    LEVEL
FROM employees
START WITH manager_id IS NULL --시작.
CONNECT BY PRIOR employee_id=manager_id;--level 2로 3으로 ... 들어감.
--level-1은 내부에서 값을 지원해주는 것. !START WITH, CONNECT BY PRIOR 함수 기억하기!
-- 레벨값에 따라 ' ' 3개씩 붙는 것. 보여줄 때 댓글형식으로 꺼내는 방법. 
-- !프론트엔드에서 게시판 만들 때 댓글 다는 게 되는가, 안되는가 보는 방법!

SELECT employee_id, first_name||' '||last_name, manager_id
FROM employees
WHERE employee_id >=100
ORDER BY employee_id ASC;
--뿌리 = 스티븐 킹 manager_id는 널. 스티븐킹을 기준으로 해라.  level값은 1.
--100	Steven King	1 시작을 하고. 

SELECT employee_id,
    LPAD(' ',3*(LEVEL-1))||first_name||' '||last_name, LEVEL
FROM employees
START WITH employee_id=113
CONNECT BY PRIOR manager_id=employee_id;
--조상 찾아 올라가는 SELECT문.

--SYS_CONNECT_BY_PATH(column, char)
SELECT employee_id,
    LPAD(' ',3*(LEVEL-1))||SYS_CONNECT_BY_PATH(first_name,'/') PATH,
    LEVEL
FROM employees
START WITH manager_id IS NULL --시작.
CONNECT BY PRIOR employee_id=manager_id;
--새로 만든 것 v 기존 것과 비교
SELECT employee_id,
    LPAD(' ',3*(LEVEL-1))||first_name||' '||last_name,
    LEVEL
FROM employees
START WITH manager_id IS NULL --시작.
CONNECT BY PRIOR employee_id=manager_id;
-- connected by root, isleaf, 
SELECT employee_id,
    LPAD(' ',3*(LEVEL-1))||SYS_CONNECT_BY_PATH(first_name,'@') PATH,
    CONNECT_BY_ROOT first_name as ROOT_NAME,
    CONNECT_BY_ISLEAF LEAF,
    CONNECT_BY_ISCYCLE CYCLE,
    LEVEL
FROM employees
START WITH manager_id IS NULL --시작.
CONNECT BY NOCYCLE PRIOR employee_id=manager_id;
--ORA-30930: NOCYCLE keyword is required with CONNECT_BY_ISCYCLE pseudocolumn
--select문  CONNECT_BY_ISCYCLE CYCLE -- CONNECT BY NOCYCLE PRIOR
--nocycle 루프 있는지 확인. 0 = 없는 것. 1 = 뺑뺑이 돈다.



