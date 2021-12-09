SELECT COUNT(*) FROM employees;
SELECT * FROM employees;

SELECT first_name, last_name 
FROM employees;

SELECT *
FROM departments;

SELECT location_id, department_id, department_name, manager_id
FROM departments;

SELECT first_name, hire_date, salary
FROM employees;

SELECT first_name, last_name, salary, salary+300
FROM employees;


SELECT first_name, last_name, salary, salary+salary*0.1
FROM employees;

SELECT first_name, last_name, 3+4-5+7
FROM employees;

SELECT first_name, last_name, salary
FROM employees;

SELECT first_name, department_id, commission_pct
FROM employees;

SELECT first_name AS 이름, salary 급여
FROM employees;

SELECT first_name || ' ' || last_name || '''s salary is $' || salary "Employee Details"
FROM employees;

SELECT department_id
FROM employees;

SELECT DISTINCT department_id
FROM employees;

SELECT ROWID, ROWNUM, employee_id, first_name
FROM employees;

SELECT first_name, job_id, department_id
FROM employees
WHERE job_id='IT_PROG';

SELECT first_name, last_name, hire_date
FROM employees
WHERE last_name='King';

SELECT *
FROM nls_database_parameters
WHERE parameter='NLS_DATE_FORMAT';

SELECT first_name, salary, hire_date
FROM employees
WHERE salary >=15000;

SELECT first_name, salary, hire_date
FROM employees
WHERE hire_date='04/01/30';

SELECT first_name, salary, hire_date
FROM employees
WHERE first_name='Steven';

SELECT first_name, salary
FROM employees
WHERE salary BETWEEN 10000 AND 12000;

SELECT first_name, salary
FROM employees
WHERE salary BETWEEN 10000 AND 10000;

SELECT first_name, salary, hire_date
FROM employees
WHERE hire_date BETWEEN '03/01/01' AND '03/12/13';

SELECT first_name, salary, hire_date
FROM employees
WHERE first_name BETWEEN 'A' AND 'Bzzzzzzzz';

SELECT first_name, salary
FROM employees
WHERE salary BETWEEN 10000 AND 10000;

SELECT first_name, salary, hire_date
FROM employees
WHERE first_name BETWEEN 'A' AND 'B';

SELECT first_name, salary, hire_date
FROM employees
WHERE first_name BETWEEN 'A' AND 'Bz';

SELECT employee_id, first_name, salary, manager_id
FROM employees
WHERE manager_id IN(101,102,103);

SELECT first_name, last_name, job_id, department_id
FROM employees
WHERE job_id IN('IT_PROG','FI_MGR', 'AD_VP');

SELECT * FROM employees;

SELECT first_name, last_name
FROM employees
WHERE first_name IN('David','Steven');

SELECT first_name, last_name
From employees
WHERE first_name IN('Steven','David');

SELECT first_name, last_name, job_id, department_id
FROM employees
WHERE job_id LIKE 'IT%';

SELECT first_name, hire_date
FROM employees
WHERE hire_date LIKE '03%';

SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date LIKE '%/06/%';

SELECT first_name, last_name
FROM employees
WHERE first_name IN 'Steven';

SELECT first_name, email
FROM employees
WHERE email LIKE '__AI%';

SELECT first_name, job_id
FROM employees
WHERE job_id = 'SA_MAN';
WHERE job_id LIKE 'SA*_M%' ESCAPE '*';

SELECT first_name, manager_id
FROM employees
WHERE manager_id IS NULL;

SELECT first_name, job_id, commission_pct
FROM employees
WHERE commission_pct IS NOT NULL;

SELECT first_name, job_id, salary
FROM employees
--WHERE salary >= 5000
WHERE job_id='IT_PROG' OR salary >= 5000;





--ESCAPE



CREATE TABLE TEST(
col NCHAR(10));
INSERT INTO TEST VALUES('SA_MAN');
INSERT INTO TEST VALUES('SAAMAN');
INSERT INTO TEST VALUES('SABMAN');

SELECT * FROM TEST;
SELECT * FROM test
WHERE col LIKE 'SA/_M%' ESCAPE'/';

-- NOT
SELECT first_name, department_id
FROM employees
WHERE department_id NOT IN(50,60,70,80,90,100);

SELECT first_name, department_id
FROM employees
WHERE department_id NOT BETWEEN 50 AND 100;

--p50. 논리 연산자 우선순위
SELECT first_name, job_id, salary
FROM employees
WHERE job_id = 'IT_PROG'
OR job_id = 'FI_MGR'
AND salary >= 6000;


SELECT first_name, job_id, salary
FROM employees
WHERE (job_id = 'IT_PROG'
OR job_id = 'FI_MRG')
AND salary >= 6000;

--p.51 데이터 정렬
SELECT first_name, hire_date
FROM employees
ORDER BY hire_date;

SELECT first_name, salary*12 annsal
FROM employees
ORDER BY annsal;

SELECT first_name, salary*12 연봉
FROM employees
ORDER BY 1;
-- 열 번호로 정렬하겠다. 1,2

[연습문제]
--1
SELECT job_id, first_name, last_name, salary
FROM employees;
--2
SELECT first_name||' '|| last_name name
FROM employees;
--3
SELECT * FROM employees
where department_id='50';
--4
select first_name, last_name, department_id, job_id
FROM employees
where department_id='50';
--5
SELECT first_name, last_name, salary, salary+300
FROM employees;
--6
Select first_name, last_name, salary
FROM employees
where salary >=10000;
--7
select * from employees;
select first_name, last_name, job_id, commission_pct
FROM employees
where commission_pct IS NOT NULL

--8
select first_name, last_name, hire_date, salary
FROM employees
WHERE hire_date BETWEEN '03/01/01' and '03/12/31';

--9
select first_name, hire_date, salary
FROM employees
where hire_date LIKE '03%';

--10
select first_name,  salary
from employees
order by 2 desc;

--11
select first_name,  salary
from employees
where department_id = '60'
order by 2 desc;

--12
select first_name, job_id
from employees
where job_id = 'IT_PROG'
or job_id = 'SA_MAN'

--13
select first_name||' '||last_name||' '
from employees;



select first_name||' ' ||last_name||' '||'사원의 급여는'||' '||salary||'달러입니다.' as info
from employees;

--14
select first_name, job_id
from employees
where job_id LIKE '%MAN';

--15
select first_name, job_id
from employees
order by job_id;

--함수
--LTRIM('JavaSpecialist,'Jav')

select ltrim('ajvSpecialist', 'jav')
from dual;


SELECT last_name, LOWER(last_name), INITCAP(last_name), UPPER(last_name)
FROM employees
WHERE last_name LIKE 'A%';

SELECT last_name, LOWER(last_name),INITCAP(last_name), UPPER(last_name)
FROM employees
WHERE lower(last_name)='austin';

SELECT first_name, length(first_name), INSTR(first_name,'a')
from employees;


SELECT first_name, length(first_name), INSTR(first_name,'A')
from employees;

Drop Table test;

CREATE TABLE test(
col NCHAR);

INSERT INTO test VALUES('한글');
SELECT LENGTH(col)
FROM test;
--한글 하나 당 3byte

SELECT * FROM nls_database_parameters;
--AL32UTF8 영어 이외에 3byte로 준다는 의미.
--CHAR v NCHAR
Drop Table test;

drop table test;

create table test(
col nvarchar2(10));
insert into test values('한글');
select length(col)
from test;

drop table test;

create table test(
col varchar2(10));
insert into test values('한글');
select length(col)
from test;


--SUBSTR, CONCAT
SELECT first_name, SUBSTR(first_name,1,3), CONCAT(first_name,last_name)
FROM employees;
SELECT first_name, SUBSTR(first_name,1,3),first_name||last_name
from employees;

SELECT RPAD(first_name,10,'-') As name,
    LPAD(salary,10,'*') As sal
FROM employees;

SELECT LTRIM('JavaSpecialist','Java')FROM dual;
SELECT LTRIM(' JavaSpecialist') FROM dual; --디폴트가 공백.
SELECT ' JavaSpecialist' FROM dual;
SELECT TRIM(' JavaSpecialist  ') FROM dual; -- 양 쪽 다

SELECT REPLACE('JavaSpecialist','Java','BigData') FROM dual;
SELECT TRANSLATE('javaspecialist',
    'abcdefghijklmnopqrstuvwxyz', 'defghijklmnopqrstuvwxyzabc') FROM dual;
    -- 1:1 매핑 시켜서 암호처럼 나오는 것. mdydvshfldolvw

select length(first_name),first_name name
from employees
where lower(job_id) = 'it_prog';
SELECT
    RPAD(substr(first_name,1,3),length(first_name),'*') AS name, LPAD(salary,10,'*') AS salary
FROM employees
WHERE LOWER(job_id) ='it_prog';
    
--p.70
CREATE TAble test_regexp(col1 VARCHAR2(10));
INSERT INTO test_regexp VALUES('ABCDE01234');
INSERT INTO test_regexp VALUES('01234ABCDE');
INSERT INTO test_regexp VALUES('abcde01234');
INSERT INTO test_regexp VALUES('01234abcde');
INSERT INTO test_regexp VALUES('1-234-5678');
INSERT INTO test_regexp VALUES('234-567890');

SELECT * FROM test_regexp;

SELECT *
FROM test_regexp
WHERE REGEXP_LIKE(col,'[0-9][a-z]');

