--7�� [1. ��������]p.192

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
--������, ������ ��������
SELECT first_name, job_id, hire_date
FROM employees
WHERE job_id = (
    SELECT job_id
    FROM employees
    WHERE employee_id=103
);
--�� �ϳ� �Ѱܿ� �� ������ �� �� �ִ�. 
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
--�� ���� ����. => ������ �������� ����. ������ �������� �� �� ����.
-->ANY, <ANY, >ALL, <ALL 

--[4.��ȣ���� ��������] �θ� �ִ� ���������� ������ ���� ��.
SELECT first_name, salary
FROM employees a
WHERE salary > (
    SELECT avg(salary)
    FROM employees b
    WHERE b.department_id = a.department_id
);
--�θ� ���� WHERE���� ������ ���� ��. â���ؼ� ���� ��. ���� ���� ���� ����.
--�� v ���̺� = �ζ��� ��� ������ ���̺�� �������� ������ �����.(��ǻ�Ͱ�������?)
--FROM�� SELECT �ζ��κ� (���̺� ���̽��� ������)
--SELECT���� SELECT ��Į�� �������� (���� �ѷ��ִ� ��)
--WHERE ���� SELECT�� ��ø

--[5.��Į�󼭺�����]
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
-- f10��ư���� �ӵ� Ȯ�� ��Į�� ���������� ��� ������ ���� ���� �ٿ� ���� ���� ��� ����
--JOIN�� FROM�ܿ��� �Ͼ. ���̺�ܿ��� ����. 
-- ��Į�󼭺����� : ���̺� ���� �����ϴ� ��. �ξ� ������. 

--[6.7. �ζ��� ��, ���� ����] ���̺� �˻� ��(���� 1��-10��, 20-30�� �� �� ��밡��)
SELECT row_number, first_name, salary
FROM (SELECT first_name, salary,
    row_number() OVER(ORDER BY salary DESC) AS row_number
    FROM employees)
WHERE row_number BETWEEN 11 AND 20;
--OVER partition orderby = �м��Լ�
-- ���� �߿� row_num, row_id ���������� ���� ����. �ѹ��� ���ִ� �� �������� �� = row_number
-- ����� ������� ���� �� �� �ִ�. 
--=
SELECT rownum, first_name, salary
FROM (SELECT first_name, salary
    FROM employees
    ORDER BY salary DESC)
WHERE rownum BETWEEN 1 AND 10;
--1 and 10 ���ڰ��� �ٲٸ� ���� �ȳ���. ��? 
-- rownum�� ���������� �����ϴ� ��(���κ���). ��밡��. 
-- rownum 1�� ����. rownum>=1��� ����(���۰��� 1��) rownum>=2��� �ع����� �������� �������� �ʴ´�.
-- ���� ��߸� rownum�� 2�� 3���� ... ����. ������ rownum�� 1�� ��ŸƮ�ϴµ� 
-- rownum>=2��� �ϸ� �������� ���̺� ���� �������� ����.
-- rownum�� �����ص״ٰ� ����� �� rownumber�� ����ϴ� ��.

SELECT rnum, first_name, salary
FROM(
    SELECT first_name, salary, rownum as rnum
    FROM( SELECT first_name, salary
        FROM employees
        ORDER BY salary DESC)
        )
WHERE rnum > 1 AND rnum <= 10;
-- FROM�� ���ư� �� rownum rnum���� ����.
-- �Խ��� ����ų� �̾ƿ� �� �����ϰ� ����.

--[8. ���� ����] Ʈ������ ���÷���, ����� ��
SELECT employee_id,
    LPAD(' ',3*(LEVEL-1))||first_name||' '||last_name,
    LEVEL
FROM employees
START WITH manager_id IS NULL --����.
CONNECT BY PRIOR employee_id=manager_id;--level 2�� 3���� ... ��.
--level-1�� ���ο��� ���� �������ִ� ��. !START WITH, CONNECT BY PRIOR �Լ� ����ϱ�!
-- �������� ���� ' ' 3���� �ٴ� ��. ������ �� ����������� ������ ���. 
-- !����Ʈ���忡�� �Խ��� ���� �� ��� �ٴ� �� �Ǵ°�, �ȵǴ°� ���� ���!

SELECT employee_id, first_name||' '||last_name, manager_id
FROM employees
WHERE employee_id >=100
ORDER BY employee_id ASC;
--�Ѹ� = ��Ƽ�� ŷ manager_id�� ��. ��Ƽ��ŷ�� �������� �ض�.  level���� 1.
--100	Steven King	1 ������ �ϰ�. 

SELECT employee_id,
    LPAD(' ',3*(LEVEL-1))||first_name||' '||last_name, LEVEL
FROM employees
START WITH employee_id=113
CONNECT BY PRIOR manager_id=employee_id;
--���� ã�� �ö󰡴� SELECT��.

--SYS_CONNECT_BY_PATH(column, char)
SELECT employee_id,
    LPAD(' ',3*(LEVEL-1))||SYS_CONNECT_BY_PATH(first_name,'/') PATH,
    LEVEL
FROM employees
START WITH manager_id IS NULL --����.
CONNECT BY PRIOR employee_id=manager_id;
--���� ���� �� v ���� �Ͱ� ��
SELECT employee_id,
    LPAD(' ',3*(LEVEL-1))||first_name||' '||last_name,
    LEVEL
FROM employees
START WITH manager_id IS NULL --����.
CONNECT BY PRIOR employee_id=manager_id;
-- connected by root, isleaf, 
SELECT employee_id,
    LPAD(' ',3*(LEVEL-1))||SYS_CONNECT_BY_PATH(first_name,'@') PATH,
    CONNECT_BY_ROOT first_name as ROOT_NAME,
    CONNECT_BY_ISLEAF LEAF,
    CONNECT_BY_ISCYCLE CYCLE,
    LEVEL
FROM employees
START WITH manager_id IS NULL --����.
CONNECT BY NOCYCLE PRIOR employee_id=manager_id;
--ORA-30930: NOCYCLE keyword is required with CONNECT_BY_ISCYCLE pseudocolumn
--select��  CONNECT_BY_ISCYCLE CYCLE -- CONNECT BY NOCYCLE PRIOR
--nocycle ���� �ִ��� Ȯ��. 0 = ���� ��. 1 = ������ ����.



