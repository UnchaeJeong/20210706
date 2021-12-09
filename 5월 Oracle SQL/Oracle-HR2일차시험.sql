--p.107 연습문제
--1
SELECT * 
FROM employees
where lower(email) like '%lee%';

--2
select * from employees;

select first_name, salary, job_id
from employees
where manager_id = 103;

--3
select *
from employees
where department_id = 80
and job_id = 'SA_MAN'
or department_id = 20
and manager_id = 100;

--4
select replace(phone_number,'.','-')
from employees;

--5
select * from employees;
select first_name||' '||last_name AS full_name, salary, hire_date, trunc(to_date(hire_date),'day')
from employees;

CREATE TAble test_regexp(col1 VARCHAR2(10));
INSERT INTO test_regexp VALUES('ABCDE01234');
INSERT INTO test_regexp VALUES('01234ABCDE');
INSERT INTO test_regexp VALUES('abcde01234');
INSERT INTO test_regexp VALUES('01234abcde');
INSERT INTO test_regexp VALUES('1-234-5678');
INSERT INTO test_regexp VALUES('234-567890');
--추가
INSERT INTO test_regexp VALUES('2AB-567890');
INSERT INTO test_regexp VALUES('A2');
INSERT INTO test_regexp VALUES('2B');
INSERT INTO test_regexp VALUES('a2');
INSERT INTO test_regexp VALUES('22');
--추가
INSERT INTO test_regexp VALUES('0223102411');