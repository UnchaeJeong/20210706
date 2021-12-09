select *
from test_regexp
WHERE REGEXP_LIKE(col1,'[0-9][a-z]');

select *
from test_regexp
where regexp_like(col1, '[[:digit:]]{3}-[[:digit:]]{4}$');

select col1,
    regexp_instr(col1, '[0-9]') as data1,
    regexp_instr(col1,'%') as data2
FROM test_regexp;

select col1, regexp_substr(col1,'[c-z]+')
from test_regexp;

select col1, regexp_replace(col1, '[0-2]+','*')
FROM test_regexp;

select col1, regexp_substr(col1,'[c-z]+')
from test_regexp;

select first_name, (sysdate - hire_date)/7 as "weeks"
from employees
where department_id=60;

select first_name, sysdate, hire_date,
     months_between(sysdate, hire_date) as workmonth
FROM employees
where first_name='Diana';

select first_name, TO_CHAR(hire_date, 'MM/YY') hiredmonth
from employees
where lower(first_name)='steven';

select first_name, last_name, --TO_Char(salary, '$999,999') salary
from employees
where lower(first_name)='david';

select to_number('$5,500.00', '$99,999.99') - 4000
from dual;

select first_name, hire_date
from employees
where hire_date=to_date('2003/06/17', 'YYYY/MM/DD');

select first_name,salary, commission_pct,
    salary + salary*NVL(commission_pct,0) ann_sal
from employees;

select first_name,
NVL2(commission_pct, salary+(salary*commission_pct),salary) ann_sal
from employees;

select first_name,
    coalesce(salary + (salary*commission_pct),salary) ann_sal
From employees;

select first_name, coalesce(salary*commission_pct, 0) as bonus
from employees
where coalesce(salary*commission_pct, 0) <650;

select first_name, coalesce(salary*commission_pct,0) as bonus
from employees
where LNNVL(salary*commission_pct>=650);

select first_name, coalesce(salary*commission_pct, 0)
from employees
where salary*commission_pct < 650


UNION
SELECT first_name, COALESCE(salary*commission_pct,0)
from employees
where salary*commission_pct is null;

select job_id, salary,
case job_id when 'IT_PROG' then salary*1.10
            when 'FI_MGR'  then salary*1.15
            when 'FI_ACCOUNT' then salary*1.20
        else salary
    end revised_salary
FROM employees;

