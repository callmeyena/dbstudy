/*
    드라이브(DRIVE) 테이블과 드리븐(DRIVEN) 테이블
    1. 드라이브(DRIVE) 테이블
        1) 조인 관계를 처리하는 메인 테이블
        2) 1:M 관계에서 1에 해당하는 테이블
        3) 행(ROW)의 개수가 일반적으로 적고, PK를 조인 조건으로 사용하기 때문에 인덱스(INDEX) 활용이 가능하다. 인덱스(무슨 데이터를 어디에 뒀다 기록을 남겨두는 것)를 타면 빠르고 인덱스를 타지 못하면 느리다.
    2. 드리븐(DRIVEN) 테이블
        1) 1:M 관계에서 M에 해당하는 테이블
        2) 행(ROW)의 개수가 일반적으로 많고, FK를 조인 조건으로 사용하기 때문에 인덱스(INDEX) 활용이 불가하다.
    3. 조인 성능 향상을 위해서 가급적 드라이브(DRIVE) 테이블을 먼저 작성한다. 드리븐(DRIVEN) 테이블은 나중에 작성한다.
*/

-- 1. 내부 조인(두 테이블에 일치하는 정보를 조인한다.)
-- 1) 표준 문법
SELECT E.EMP_NO, E.NAME, D.DEPT_NO, D.DEPT_NAME
  FROM DEPARTMENT_TBL D INNER JOIN EMPLOYEE_TBL E -- 항상 PK칼럼을 먼저 적어주기! (그 다음 FK) 앞에 적어주는 테이블을 DRIVE TABLE, 뒤에 있는 테이블이 DRIVEN TABLE, 성능 좋은 것 먼저 앞에 둔다고 생각하기~! 
    ON D.DEPT_NO = E.DEPART;
    
-- 2) 오라클 문법
SELECT E.EMP_NO, E.NAME, D.DEPT_NO, D.DEPT_NAME
  FROM DEPARTMENT_TBL D, EMPLOYEE_TBL E
 WHERE D.DEPT_NO = E.DEPART;
 
 -- 2. 왼쪽 외부 조인(왼쪽에 있는 테이블은 일치하는 정보가 없어도 무조건 조인한다.)
 
 -- 1) 표준 문법
 SELECT D.DEPT_NO, D.DEPT_NAME, E.EMP_NO, E.NAME
   FROM DEPARTMENT_TBL D LEFT OUTER JOIN EMPLOYEE_TBL E
     ON D.DEPT_NO = E.DEPART;        -- 일치하는 정보가 없더라도 왼쪽의 정보는 조회하라 EX) 회원번호(1) / 주문내역(M) 회원가입은 했지만 주문내역이 없는 회원을 조회 할 때 사용하는 조인
     
 -- 2) 오라클 문법
 SELECT D.DEPT_NO, D.DEPT_NAME, E.EMP_NO, E.NAME
   FROM DEPARTMENT_TBL D, EMPLOYEE_TBL E
  WHERE D.DEPT_NO = E.DEPART(+);    -- 왼쪽 외부 조인이냐 오른쪽 외부 조인이냐에 따라 (+)위치 바뀜
 
-- 외래키 제약 조건 비활성화(일시 중지)
-- 제약조건이름 : FK_EMP_DEPT
ALTER TABLE EMPLOYEE_TBL
    DISABLE CONSTRAINT FK_EMP_DEPT;
    
-- 외래키 제약조건이 없는 상태이므로, 제약조건을 위배하는 데이터를 입력 할 수 있다.
INSERT INTO EMPLOYEE_TBL(EMP_NO, NAME, DEPART, POSITION, GENDER, HIRE_DATE, SALARY)
VALUES(EMPLOYEE_SEQ.NEXTVAL, '김성실', 5, '대리', 'F', '98/12/01', 3500000);
COMMIT;
 
-- 외래키 제약조건을 위반하는 데이터 삭제하기
DELETE FROM EMPLOYEE_TBL WHERE EMP_NO = 1005;   -- PK를 조건으로 사용하면 인덱스를 타기 때문에 빠르다.
DELETE FROM EMPLOYEE_TBL WHERE NAME = '김성실';  -- 인덱스를 타지 않는 일반 칼럼은 느리게 동작한다.
COMMIT;


-- 외래키 제약조건의 활성화(다시 시작)
-- 제약조건: FK_EMP_DEPT
ALTER TABLE EMPLOYEE_TBL
ENABLE CONSTRAINT FK_EMP_DEPT;

-- 3. 오른쪽 외부 조인(오른쪽에 있는 테이블은 일치하는 정보가 없어도 무조건 조인한다.)
-- 1) 표준 문법
SELECT D.DEPT_NO, D.DEPT_NAME, E.EMP_NO, E.NAME
  FROM DEPARTMENT_TBL D RIGHT OUTER JOIN EMPLOYEE_TBL E
    ON D.DEPT_NO =  E.DEPART;
    
-- 2) 오라클 문법
SELECT D.DEPT_NO, D.DEPT_NAME, E.EMP_NO, E.NAME
  FROM DEPARTMENT_TBL D, EMPLOYEE_TBL E
 WHERE D.DEPT_NO(+) = E.DEPART;
 S