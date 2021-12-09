--DML (CRUD)
--[2.1 테이블 구조 확인]
desc departments;

SELECT * FROM departments
WHERE department_id = 280;
--
INSERT INTO departments
VALUES(280, 'Data Analytics', null, 1700);
--INSERT INTO table[ (col1, col2 ....)]
--                VALUES( ....)
-- 갯수가 맞으면 자동으로 하나씩 들어감.

delete from departments
WHERE department_id = 280;

INSERT INTO departments (department_id, department_name, location_id)
VALUES (280, 'Data Analytics', 1700);
--원하는 열만 넣고 싶을 때 ()순서대로 value 써주면 됨.

SELECT * from departments
WHERE department_id = 280;
--확인
COMMIT;
ROLLBACK;
--commit과 rollback
-- 삽입한 (변경된) 내용에 대하여 
-- rollback : 테이블 위에서 업데이트 등 작업을 한 내용만을 지워버리는 것.(업데이트 안하고 원상태로 돌리는 것.) 
-- commit : 변경된 내용을 저장장소까지 완전히 저장공간에 저장하는 것.

--[2.3. 다른 테이블로부터 행 복사]
CREATE TABLE managers AS --ctas, select문에 열제목만 넣고싶을때(데이터는 필요없을 때) !!!
    SELECT employee_id, first_name, job_id, salary, hire_date
    FROM employees
    WHERE 1=2; --데이터를 안넣겠다는 의미.
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
--숙달이 되어야하는 부분들~~, 암기 필요, 보통 위와 같이 씀.

--[3.1 update, 테이블 행 갱신]
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

-- [4.1 DELETE 행 삭제]
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
); --제약 조건. -- primary key. 지우려고하면 다 없어짐. -- 문법이라도 익힐 것.
ROLLBACK;

--[4.2 다른테이블을 이용한 행 삭제]
desc depts;
CREATE TABLE depts AS
    SELECT * FROM departments;

desc depts;
DELETE FROM emps
WHERE department_id =
    (SELECT department_id
    FROM depts
    WHERE department_name = 'Shipping');
--INSERT, UPDATE< DELETE, MERGE <-- commit, rollback 영향
--commit을 안해서 프롬프트창에서 1 row deleted.가 안뜸.
COMMIT;

--[5. merge 필요한 것만 뽑아서 저장 가능.]
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
-- 뼈대만 보기. matched / unmatched 업데이트, 원하는 것만 업데이트 하겠다는 것.
-- 데이터를 가져오거나 업데이트하는 것은 확실히! DML, DCL, TCL 중 DML은 확실히. DB 쪽에서 일하게 된다면.

--p.224 [6.CTAS] 테이블에 있는 것을 임시변수로 쓰다가 지워버리면 됨.
CREATE TABLE emp2 AS SELECT * FROM employees; --WHERE 1=2; --테이블 틀만 만들때
select * from emp2;

--[7. multiple INSERT]
INSERT ALL INTO emp2 VALUES( )--조건없이 다 넣어라.
           INTO emp3 VALUES()-- 테이블 두 개에다가 값을 한꺼번에 넣어줄 수 있음.
           SELECT * FROM dual; --더미 테이블
           
--[7.2 conditional insert all]
INSERT ALL
    WHEN department_id = 10 THEN
        INTO emp_10 VALUES()
    WHEN department_id=20 THEN
        INTO emp_20 VALUES()
    SELECT * FROM employees;

INSERT FIRST --첫 번만 걸리면 밑에 수행은 보지 않는다.
    WHEN salary <= 5000 THEN
        INTO emp_sa15000 VALUES()
    WHEN salary <= 10000 THEN
        INTO emp_sal10000 VALUES()
    SELECT employee_id, first_name, slaary FROM employee;
--INSERT ALL / FIRST 차이점 ** 예제 쳐보기


        
