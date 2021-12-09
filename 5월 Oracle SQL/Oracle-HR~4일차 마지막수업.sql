--p.261[테이블 구조 변경 ALTER TABLE)
select * from emps;

CREATE TABLE emp_dept50
AS
    SELECT employee_id, first_name, salary*12 AS ann_sal, hire_date
    FROM employees
    WHERE department_id=50;
    
DESC emp_dept50;
SELECT * FROM emp_dept50;
ALTER TABLE emp_dept50
ADD(job VARCHAR2(10)); -- 집어넣을 Col, data type => 테이블 열 생성

DESC emp_dept50;
SELECT * FROM emp_dept50;

--[2.3 열 이름 변경]
ALTER TABLE emp_dept50
RENAME COLUMN job TO job_id; --패턴 익히기 alter table rename column
desc emp_dept50;
--[2.4 열수정]
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
--[2.5열삭제]
desc emp_dept50;
--JOB_ID               VARCHAR2(10) 
ALTER TABLE emp_dept50
DROP COLUMN job_id;  
--삭제

--[2.6 set used] -- 그 테이블만 주구장창 볼 때, 빨리 빨리 보여줘야 할 때, 막상지우려고 했더니 수요가 많으면
-- 임시적으로 사용하지 않다가(지워지지 않음) 여유가 생길 때 지울 수 있다.
ALTER TABLE emp_dept50 SET UNUSED(first_name);
desc emp_dept50;
--EMPLOYEE_ID          NUMBER(6) 
--ANN_SAL              NUMBER    
--HIRE_DATE   NOT NULL DATE   

ALTER TABLE emp_dept50 DROP UNUSED COLUMNS; -- 삭제.

--[2.7 객체 이름 변경]
RENAME emp_dept50 TO employees_dept50;
desc emp_dept50;
--ORA-04043: emp_dept50 객체가 존재하지 않습니다.

--[3. 테이블 삭제 drop table)
desc employees_dept50;
DROP TABLE employees_dept50;
desc employees_dept50;
--ORA-04043: employees_dept50 객체가 존재하지 않습니다.

--[4.TRUNCATE 테이블 데이터 비우기]
SELECT * FROM emp2;
TRUNCATE TABLE emp2;
--Table EMP2이(가) 잘렸습니다.
SELECT * FROM emp2; -- 테이블만 남고 값은 날아감.
desc emp2; -- 테이블있다는 것 확인.

--11장. 제약조건 - not null, unique key, primary key, foreign key, check
--열 레벨 제약조건
CREATE TABLE emp4(
    empno number(4)     CONSTRAINT emp4_empno_pk PRIMARY KEY,
    ename varchar2(10)  NOT NULL,
    sal number(7,2) CONSTRAINT emp4_sal_ck CHECK(sal<=10000),
    deptno number(2) CONSTRAINT emp4_deptno_dept_deptid_fk
                    REFERENCES departments(department_id)
);
--Table EMP4이(가) 생성되었습니다.

INSERT INTO emp4 (ename) VALUES ('aaa'); --primary key는 null이 될 수 없음.
--INSERT INTO emp4 (ename) VALUES ('aaa')
--오류 보고 -
--ORA-01400: cannot insert NULL into ("HR"."EMP4"."EMPNO")
INSERT INTO emp4 (empno,ename) VALUES (1,'aaa');
--1 행 이(가) 삽입되었습니다.
SELECT * FROM emp4;
INSERT INTO emp4(empno,ename) VALUES (1,'bbb');
--INSERT INTO emp4(empno,ename) VALUES (1,'bbb')
--오류 보고 -
--ORA-00001: unique constraint (HR.EMP4_EMPNO_PK) violated
INSERT INTO emp4(empno,ename) VALUES (2,'bbb');
--1 행 이(가) 삽입되었습니다.
SELECT * FROM emp4;
--1	aaa		
--2	bbb		
INSERT INTO emp4(empno,ename,sal) VALUES(3,'bbb',10001);
--ORA-02290: check constraint (HR.EMP4_SAL_CK) violated
--위 식에서    sal number(7,2) CONSTRAINT emp4_sal_ck CHECK(sal<=10000), 조건 떄문
INSERT INTO emp4(empno,ename,sal) VALUES(3,'bbb',10000);
--1 행 이(가) 삽입되었습니다.
