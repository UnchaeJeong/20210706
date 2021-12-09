--p.261[���̺� ���� ���� ALTER TABLE)
select * from emps;

CREATE TABLE emp_dept50
AS
    SELECT employee_id, first_name, salary*12 AS ann_sal, hire_date
    FROM employees
    WHERE department_id=50;
    
DESC emp_dept50;
SELECT * FROM emp_dept50;
ALTER TABLE emp_dept50
ADD(job VARCHAR2(10)); -- ������� Col, data type => ���̺� �� ����

DESC emp_dept50;
SELECT * FROM emp_dept50;

--[2.3 �� �̸� ����]
ALTER TABLE emp_dept50
RENAME COLUMN job TO job_id; --���� ������ alter table rename column
desc emp_dept50;
--[2.4 ������]
desc emp_dept50;
--FIRST_NAME           VARCHAR2(20) 
ALTER TABLE emp_dept50
MODIFY (first_name VARCHAR2(30));
--FIRST_NAME           VARCHAR2(30)

ALTER TABLE emp_dept50
MODIFY(first_name VARCHAR2(10));
--FIRST_NAME           VARCHAR2(10) 
ALTER TABLE emp_dept50
MODIFY(first_name VARCHAR2(7));
--ORA-01441: cannot decrease column length because some value is too big
--[2.5������]
desc emp_dept50;
--JOB_ID               VARCHAR2(10) 
ALTER TABLE emp_dept50
DROP COLUMN job_id;  
--����

--[2.6 set used] -- �� ���̺� �ֱ���â �� ��, ���� ���� ������� �� ��, ����������� �ߴ��� ���䰡 ������
-- �ӽ������� ������� �ʴٰ�(�������� ����) ������ ���� �� ���� �� �ִ�.
ALTER TABLE emp_dept50 SET UNUSED(first_name);
desc emp_dept50;
--EMPLOYEE_ID          NUMBER(6) 
--ANN_SAL              NUMBER    
--HIRE_DATE   NOT NULL DATE   

ALTER TABLE emp_dept50 DROP UNUSED COLUMNS; -- ����.

--[2.7 ��ü �̸� ����]
RENAME emp_dept50 TO employees_dept50;
desc emp_dept50;
--ORA-04043: emp_dept50 ��ü�� �������� �ʽ��ϴ�.

--[3. ���̺� ���� drop table)
desc employees_dept50;
DROP TABLE employees_dept50;
desc employees_dept50;
--ORA-04043: employees_dept50 ��ü�� �������� �ʽ��ϴ�.

--[4.TRUNCATE ���̺� ������ ����]
SELECT * FROM emp2;
TRUNCATE TABLE emp2;
--Table EMP2��(��) �߷Ƚ��ϴ�.
SELECT * FROM emp2; -- ���̺� ���� ���� ���ư�.
desc emp2; -- ���̺��ִٴ� �� Ȯ��.

--11��. �������� - not null, unique key, primary key, foreign key, check
--�� ���� ��������
CREATE TABLE emp4(
    empno number(4)     CONSTRAINT emp4_empno_pk PRIMARY KEY,
    ename varchar2(10)  NOT NULL,
    sal number(7,2) CONSTRAINT emp4_sal_ck CHECK(sal<=10000),
    deptno number(2) CONSTRAINT emp4_deptno_dept_deptid_fk
                    REFERENCES departments(department_id)
);
--Table EMP4��(��) �����Ǿ����ϴ�.

INSERT INTO emp4 (ename) VALUES ('aaa'); --primary key�� null�� �� �� ����.
--INSERT INTO emp4 (ename) VALUES ('aaa')
--���� ���� -
--ORA-01400: cannot insert NULL into ("HR"."EMP4"."EMPNO")
INSERT INTO emp4 (empno,ename) VALUES (1,'aaa');
--1 �� ��(��) ���ԵǾ����ϴ�.
SELECT * FROM emp4;
INSERT INTO emp4(empno,ename) VALUES (1,'bbb');
--INSERT INTO emp4(empno,ename) VALUES (1,'bbb')
--���� ���� -
--ORA-00001: unique constraint (HR.EMP4_EMPNO_PK) violated
INSERT INTO emp4(empno,ename) VALUES (2,'bbb');
--1 �� ��(��) ���ԵǾ����ϴ�.
SELECT * FROM emp4;
--1	aaa		
--2	bbb		
INSERT INTO emp4(empno,ename,sal) VALUES(3,'bbb',10001);
--ORA-02290: check constraint (HR.EMP4_SAL_CK) violated
--�� �Ŀ���    sal number(7,2) CONSTRAINT emp4_sal_ck CHECK(sal<=10000), ���� ����
INSERT INTO emp4(empno,ename,sal) VALUES(3,'bbb',10000);
--1 �� ��(��) ���ԵǾ����ϴ�.
