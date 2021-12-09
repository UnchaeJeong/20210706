SELECT last_name, LOWER(last_name), INITCAP(last_name), UPPER(last_name)
FROM employees;

-- LENGTH, INSTR
SELECT first_name, LENGTH(first_name), INSTR(first_name,'a')
FROM employees;

DROP TABLE TEST;
-- 한 글자당 3바이트
CREATE TABLE TEST(
COL CHAR(10)
);
-- 한 글자당 3바이트
CREATE TABLE TEST(
COL VARCHAR(10)
);
-- 한 글자당 2바이트
CREATE TABLE TEST(
COL NVARCHAR2(10)
);

INSERT INTO TEST VALUES('한글');
SELECT LENGTHB(COL) FROM TEST;

SELECT * FROM nls_database_parameters;

--SUBSTR, CONCAT
SELECT first_name, SUBSTR(first_name, 1, 3), CONCAT(first_name, last_name)
FROM employees;

SELECT first_name, SUBSTR(first_name, 1, 3), first_name  || last_name
FROM employees;

-- LPAD, RPAD
SELECT
    RPAD(first_name, 10, '-') AS name,
    LPAD(salary, 10, '*') AS sal
FROM employees;

-- LTRIM, RTRIM
SELECT LTRIM('JavaSpecialist', 'Java') FROM dual;

SELECT LTRIM(' JavaSpecialist') FROM dual;

SELECT TRIM(' JavaSpecialist ') FROM dual;

-- REPLACE, TRANSLATE
SELECT REPLACE('JavaSpecialist', 'Java', 'BigData') FROM dual;


-- 문자열 조작 실전 문제
SELECT
    RPAD(substr(first_name, 1, 3), LENGTH(first_name), '*') AS name,
    LPAD(salary, 10, '*')  AS salary
FROM
    employees
WHERE
    LOWER(job_id) = 'it_prog';

-- REG1EXP_LIKE
CREATE TABLE TEST_REGEXP(COL1 VARCHAR2(10));
INSERT INTO TEST_REGEXP VALUES('ABCDE01234');
INSERT INTO TEST_REGEXP VALUES('01234ABCDE');
INSERT INTO TEST_REGEXP VALUES('abcde01234');
INSERT INTO TEST_REGEXP VALUES('01234abcde');
INSERT INTO TEST_REGEXP VALUES('1-234-5678');
INSERT INTO TEST_REGEXP VALUES('234-567890');
INSERT INTO TEST_REGEXP VALUES('A2');
INSERT INTO TEST_REGEXP VALUES('2B');
INSERT INTO TEST_REGEXP VALUES('a2');
INSERT INTO TEST_REGEXP VALUES('2b');
INSERT INTO TEST_REGEXP VALUES('dk4bd');


SELECT * FROM TEST_REGEXP;

SELECT * FROM TEST_REGEXP
WHERE REGEXP_LIKE(col1, '[0-9][a-z]');
SELECT * FROM TEST_REGEXP
WHERE REGEXP_LIKE(col1, '^[^a-z][0-9]$');

SELECT *
FROM test_regexp
WHERE REGEXP_LIKE(col1, '[0-9]{3}-[0-9]{4}$');

SELECT *
FROM test_regexp
WHERE REGEXP_LIKE(col1, '[[:digit:]]{3}-[[:digit:]]{4}$');

SELECT *
FROM test_regexp
WHERE REGEXP_LIKE(col1, '[[:digit:]]{3}-[[:digit:]]{4}');

SELECT *
FROM test_regexp
WHERE REGEXP_LIKE(col1, '[A-Z]{5}[0-9]');


CREATE TABLE QA_MASTER(
    QA_NO VARCHAR2(10)
    );
    
ALTER TABLE QA_MASTER ADD CONSTRAINT QA_NO_CHK CHECK
    (REGEXP_LIKE(QA_NO,
    '^([[:alpha:]]{2}-[[:digit:]]{2}-[[:digit:]]{4})$'));
    
INSERT INTO QA_MASTER VALUES('QA-01-0001');
INSERT INTO QA_MASTER VALUES('00-01-0001');
INSERT INTO QA_MASTER VALUES('aa-01-0001');
INSERT INTO QA_MASTER VALUES('aa-q1-0001');

SELECT * FROM QA_MASTER;

-- REGEXP_INSTR
INSERT INTO test_regexp VALUES('@!=)(9&%$#');
INSERT INTO test_regexp VALUES('자바3');
SELECT col1,
    REGEXP_INSTR(col1, '[0-9]') AS data1,
    REGEXP_INSTR(col1, '%') AS data2
FROM test_regexp;

-- REGEXP_SUBSTR
SELECT col1, REGEXP_SUBSTR(col1, '[C-Z]+')
FROM test_regexp;

-- REGEXP_REPLACE
SELECT col1, REGEXP_REPLACE(col1, '[0-2]+', '*')
FROM test_regexp;

INSERT INTO test_regexp VALUES('0223102411');

--REGEXP 실전 문제
SELECT first_name, phone_number
FROM employees
WHERE regexp_like (phone_number,
    '^[0-9]{3}.[0-9]{3}.[0-9]{4}$');
    
SELECt first_name, phone_number
FROM employees
WHERE regexp_like (phone_number,
    '^[[:digit:]]{3}.[[:digit:]]{3}.[[:digit:]]{4}$');
    
SELECT first_name,
    regexp_replace (phone_number, '[[:digit:]]{4}$','****') AS PHONE,
    regexp_substr (phone_number, '[[:digit:]]{4}$') AS PHONE2
FROM employees
WHERE regexp_like (phone_number,
    '^[0-9]{3}.[0-9]{3}.[0-9]{4}$');

-- 숫자함수
-- ROUND, TRUNC
SELECT ROUND(45.923,2), ROUND(45.923,0), ROUND(45.923, -1)
FROM DUAL;

SELECT TRUNC(45.923,2), TRUNC(45.923), TRUNC(45.923, -1)
FROM DUAL;

-- 날짜함수
SELECT SYSDATE FROM DUAL;
SELECT SYSTIMESTAMP FROM DUAL;
-- 날짜 연산
SELECT first_name, (SYSDATE - hire_date)/7 AS "Weeks"
FROM employees
WHERE department_id=60;

-- MONTHS_BETWEEN
SELECT first_name, SYSDATE, hire_date,
            MONTHS_BETWEEN(SYSDATE, hire_date) AS workmonth
FROM employees
WHERE first_name='Diana';

-- ADD_MONTHS
SELECT first_name, hire_date, ADD_MONTHS(hire_date, 100)
FROM employees
WHERE first_name='Diana';

-- NEXT_DAY
SELECT SYSDATE, NEXT_DAY(SYSDATE, '월')
FROM dual;

-- LAST_DAY
SELECT SYSDATE, LAST_DAY(SYSDATE)
FROM DUAL;

-- ROUND, TRUNC
SELECT SYSDATE, ROUND(SYSDATE), TRUNC(SYSDATE)
FROM DUAL;
SELECT TRUNC(SYSDATE, 'Month')
FROM DUAL;
SELECT TRUNC(SYSDATE, 'Year')
FROM DUAL;
SELECT ROUND(TO_DATE('17/03/16'), 'Month')
FROM dual;
SELECT TRUNC(TO_DATE('17/03/16'), 'Month')
FROM DUAL;
SELECT TRUNC(TO_DATE('17/03/16'), 'Day')
FROM DUAL;

-- 암시적 형 변환
SELECT employee_id, first_name, hire_date
FROM employees
WHERE hire_date='03/06/17';

desc employees;


-- 명시적 형 변환
-- 날짜를 문자로 변환
SELECT first_name, TO_CHAR(hire_date, 'MM/YY') AS HireMonth
FROM employees
WHERE first_name='Steven';

SELECT first_name,
    TO_CHAR(hire_date, 'YYYY"년" MM"월" DD"일"') HIREDATE
FROM employees;

SELECT first_name,
    TO_CHAR(hire_date,
                    'fmDdspth "of" Month YYYY fmHH:MI:SS AM',
                    'NLS_DATE_LANGUAGE=english') AS HIREDATE
FROM employees;

-- 숫자를 문자로
SELECT first_name, last_name, TO_CHAR(salary, '$999,999')
    SALARY
FROM employees
WHERE first_name='David';

SELECT TO_CHAR(2000000, '$999,999') SALARY
FROM DUAL;

SELECT first_name, last_name,
            salary*0.123456 SALARY1,
            TO_CHAR(salary*0.123456, '$999,999.99') SALARY2
FROM employees
WHERE first_name='David';

-- 문자를 숫자로
SELECT to_number('$5,500.00', '$99,999.99') -4000
from dual;

-- 문자를 날짜로
SELECT first_name, hire_date
FROM employees
WHERE hire_date=TO_DATE('2003/06/17', 'YYYY/MM/DD');

SELECT first_name, hire_date
FROM employees
WHERE hire_date=TO_DATE('2003년06월17일',
'YYYY"년"MM"월"DD"일"');

SELECT first_name,
    salary + salary*NVL(commission_pct, 0) AS ann_sal
FROM employees;

SELECT first_name,
    NVL2(commission_pct, salary+salary*commission_pct, salary) ann_sal
FROM employees;

SELECT first_name,
    COALESCE(salary + (salary*commission_pct), salary) AS ann_sal
FROM employees;

-- LNNVL
SELECT first_name, COALESCE(salary*commission_pct, 0) AS bonnus
FROM employees
WHERE salary*commission_pct < 650;

SELECT first_name, COALESCE(salary*commission_pct, 0) AS bonnus
FROM employees
WHERE COALESCE(salary*commission_pct, 0) < 650;

SELECT first_name, COALESCE(salary*commission_pct, 0) AS bonnus
FROM employees
WHERE LNNVL(salary*commission_pct > 650);

-- DECODE
SELECT job_id, salary,
            DECODE(job_id, 'IT_PROG', salary*1.10,
                                    'FI_MGR', salary*1.15,
                                    'FI_ACCOUNT', salary*1.20,
                                    salary)
            revised_salary
FROM employees;

-- CASE
SELECT job_id, salary,
    CASE job_id WHEN 'IT_PROG' THEN salary*1.10
                      WHEN 'FI_MGR'   THEN salary*1.15
                      WHEN 'FI_ACCOUNT'   THEN salary*1.20
                ELSE salary
    END AS REVISED_SALARY
FROM employees;

SELECT employee_id, salary,
    CASE WHEN salary < 5000 THEN salary*1.2
             WHEN salary < 10000 THEN salary*1.10
             WHEN salary < 15000 THEN salary*1.05
             ELSE salary
    END AS revised_salary
FROM employees;


SELECT
    TO_CHAR(LAST_DAY(TO_DATE('01', 'MM')), 'dd') AS "1",
    TO_CHAR(LAST_DAY(TO_DATE('02', 'MM')), 'dd') AS "2",
    TO_CHAR(LAST_DAY(TO_DATE('03', 'MM')), 'dd') AS "3",
    TO_CHAR(LAST_DAY(TO_DATE('04', 'MM')), 'dd') AS "4",
    TO_CHAR(LAST_DAY(TO_DATE('05', 'MM')), 'dd') AS "5",
    TO_CHAR(LAST_DAY(TO_DATE('06', 'MM')), 'dd') AS "6",
    TO_CHAR(LAST_DAY(TO_DATE('07', 'MM')), 'dd') AS "7",
    TO_CHAR(LAST_DAY(TO_DATE('08', 'MM')), 'dd') AS "8",
    TO_CHAR(LAST_DAY(TO_DATE('09', 'MM')), 'dd') AS "9",
    TO_CHAR(LAST_DAY(TO_DATE('10', 'MM')), 'dd') AS "10",
    TO_CHAR(LAST_DAY(TO_DATE('11', 'MM')), 'dd') AS "11",
    TO_CHAR(LAST_DAY(TO_DATE('12', 'MM')), 'dd') AS "12"
FROM dual;


