--DML (CRUD)
--[2.1 ���̺� ���� Ȯ��]
desc departments;

SELECT * FROM departments
WHERE department_id = 280;
--
INSERT INTO departments
VALUES(280, 'Data Analytics', null, 1700);
--INSERT INTO table[ (col1, col2 ....)]
--                VALUES( ....)
-- ������ ������ �ڵ����� �ϳ��� ��.

delete from departments
WHERE department_id = 280;

INSERT INTO departments (department_id, department_name, location_id)
VALUES (280, 'Data Analytics', 1700);
--���ϴ� ���� �ְ� ���� �� ()������� value ���ָ� ��.

SELECT * from departments
WHERE department_id = 280;
--Ȯ��
COMMIT;
ROLLBACK;
--commit�� rollback
-- ������ (�����) ���뿡 ���Ͽ� 
-- rollback : ���̺� ������ ������Ʈ �� �۾��� �� ���븸�� ���������� ��.(������Ʈ ���ϰ� �����·� ������ ��.) 
-- commit : ����� ������ ������ұ��� ������ ��������� �����ϴ� ��.

--[2.3. �ٸ� ���̺�κ��� �� ����]
CREATE TABLE managers AS --ctas, select���� ������ �ְ������(�����ʹ� �ʿ���� ��) !!!
    SELECT employee_id, first_name, job_id, salary, hire_date
    FROM employees
    WHERE 1=2; --�����͸� �ȳְڴٴ� �ǹ�.
--- = 
desc employees;
drop table managers;
-- =
CREATE TABLE managers(
    employee_id     NUMBER(6),
    first_name      varchar2(20),
    job_id          varchar2(10),
    salary          number(8,2),
    hire_date       date
);
desc managers;
--
INSERT INTO managers
    (employee_id, first_name, job_id, salary, hire_date)
    SELECT employee_id, first_name, job_id, salary, hire_date
    FROM employees
    WHERE job_id LIKE '%MAN';
--
SELECT * FROM managers;
--������ �Ǿ���ϴ� �κе�~~, �ϱ� �ʿ�, ���� ���� ���� ��.

--[3.1 update, ���̺� �� ����]
desc emps;

CREATE TABLE emps AS SELECT * FROM employees;

SELECT employee_id, first_name, salary
FROM emps
WHERE employee_id = 103;

UPDATE emps
    SET salary = salary*1.1
WHERE employee_id=103;

--
SELECT employee_id, first_name, job_id, salary, manager_id
FROM emps
WHERE employee_id IN(108,109);
--
UPDATE emps
SET(job_id, salary, manager_id) =
    (SELECT job_id, salary, manager_id
    FROM emps
    WHERE employee_id = 108)
WHERE employee_id = 109;

-- [4.1 DELETE �� ����]
SELECT * FROM emps
WHERE employee_id = 104;

DELETE FROM emps
WHERE employee_id = 103;
--ORA-02292: integrity constraint (HR.EMPS_MANGER_ID_FK) violated - child record found

SELECT employee_id, first_name, manager_id
FROM emps;

SELECT employee_id, first_name, manager_id
FROM emps
WHERE manager_id IN(105,106,107);

DELETE FROM emps
WHERE employee_id IN(105,106,107);

ALTER TABLE emps
ADD(CONSTRAINT emps_emp_id_pk PRIMARY KEY (employee_id),
    CONSTRAINT emps_manger_id_fk FOREIGN KEY (manager_id)
    REFERENCES emps(employee_id)
); --���� ����. -- primary key. ��������ϸ� �� ������. -- �����̶� ���� ��.
ROLLBACK;

--[4.2 �ٸ����̺��� �̿��� �� ����]
desc depts;
CREATE TABLE depts AS
    SELECT * FROM departments;

desc depts;
DELETE FROM emps
WHERE department_id =
    (SELECT department_id
    FROM depts
    WHERE department_name = 'Shipping');
--INSERT, UPDATE< DELETE, MERGE <-- commit, rollback ����
--commit�� ���ؼ� ������Ʈâ���� 1 row deleted.�� �ȶ�.
COMMIT;

--[5. merge �ʿ��� �͸� �̾Ƽ� ���� ����.]
CREATE TABLE emps_it 
AS SELECT * FROM employees WHERE 1=2;

SELECT * FROM emps_it;

INSERT INTO emps_it
    (employee_id, first_name, last_name, email, hire_date, job_id)
VALUES(105,'David', 'Kim','DAVIDKIM','06/03/04', 'IT_PROG');

MERGE INTO emps_it a
    USING (SELECT * FROM employees WHERE job_id = 'IT_PROG') b
    ON (a.employee_id = b.employee_id)
WHEN MATCHED THEN
    UPDATE SET
        a.phone_number = b.phone_number,
        a.hire_date = b.hire_date,
        a.job_id = b.job_id,
        a.salary = b.salary,
        a.commission_pct = b.commission_pct,
        a.manager_id = b.manager_id,
        a.department_id = b.department_id
    WHEN NOT MATCHED THEN
        INSERT VALUES
        (b.employee_id, b.first_name, b.last_name, b.email,
        b.phone_number, b.hire_date, b.job_id, b.salary,
        b.commission_pct, b.manager_id, b.department_id);
-- ���븸 ����. matched / unmatched ������Ʈ, ���ϴ� �͸� ������Ʈ �ϰڴٴ� ��.
-- �����͸� �������ų� ������Ʈ�ϴ� ���� Ȯ����! DML, DCL, TCL �� DML�� Ȯ����. DB �ʿ��� ���ϰ� �ȴٸ�.

--p.224 [6.CTAS] ���̺� �ִ� ���� �ӽú����� ���ٰ� ���������� ��.
CREATE TABLE emp2 AS SELECT * FROM employees; --WHERE 1=2; --���̺� Ʋ�� ���鶧
select * from emp2;

--[7. multiple INSERT]
INSERT ALL INTO emp2 VALUES( )--���Ǿ��� �� �־��.
           INTO emp3 VALUES()-- ���̺� �� �����ٰ� ���� �Ѳ����� �־��� �� ����.
           SELECT * FROM dual; --���� ���̺�
           
--[7.2 conditional insert all]
INSERT ALL
    WHEN department_id = 10 THEN
        INTO emp_10 VALUES()
    WHEN department_id=20 THEN
        INTO emp_20 VALUES()
    SELECT * FROM employees;

INSERT FIRST --ù ���� �ɸ��� �ؿ� ������ ���� �ʴ´�.
    WHEN salary <= 5000 THEN
        INTO emp_sa15000 VALUES()
    WHEN salary <= 10000 THEN
        INTO emp_sal10000 VALUES()
    SELECT employee_id, first_name, slaary FROM employee;
--INSERT ALL / FIRST ������ ** ���� �ĺ���


        
