-- 사원 번호를 전달하면 해당 사원의 이름을 반환하는 함수 만들기

-- 함수 만들 때: CREATE OR REPLACE FUNCTION GET_NAME(사원번호를 받을 매개변수(EMPNO EMPLOYEE_TBL.EMP_NO%TYPE) 선언)
CREATE OR REPLACE FUNCTION GET_NAME(EMPNO EMPLOYEE_TBL.EMP_NO%TYPE) -- EMPNO = 1001
RETURN VARCHAR2     -- 몇 바이트인지 크기 안 적어도 됨(타입만 적으셈)
IS
    EMPNAME EMPLOYEE_TBL.NAME%TYPE;
BEGIN
    SELECT NAME
      INTO EMPNAME
      FROM EMPLOYEE_TBL
     WHERE EMP_NO = EMPNO;  -- EMPNO = 1001
    RETURN EMPNAME;
END;
-- EMPLOYEE_TBL에서 EMP_NO가 1001인 사람의 NAME을 추출해서 EMPNAME에 값을 저장해라. 그리고 RETURN해라.

-- 사원명
-- 구창민

SELECT GET_NAME(1001) AS 사원명
  FROM EMPLOYEE_TBL
 WHERE EMP_NO = 1001;       -- 1001번만 보고 싶을 땐 WHERE에 같은 조건식 달기
 
SELECT DISTINCT GET_NAME(1001) AS 사원명
  FROM EMPLOYEE_TBL;        -- 첫번째 쿼리는 구창민 네 번 나옴 근데 그렇게 말고 한 번만 보고싶으면 DISTINCT써서 출력하기

SELECT GET_NAME(EMP_NO) AS 사원명
  FROM EMPLOYEE_TBL;        -- 전체 조회
  
   
-- 삽입/삭제/수정하면 메시지를 출력하는 트리거 만들기
-- 언제 동작할지 적혀있으니 그거 보고 조정하랍니다..(BEFORE/AFTER도 있음)

SET SERVEROUTPUT ON; -- 실행 최소 한 번은 해야 메시지 확인이 가능함

CREATE OR REPLACE TRIGGER MY_TRIGGER
    AFTER   
    INSERT OR DELETE OR UPDATE
    ON DEPARTMENT_TBL
    FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('와 내가 이런걸 배웠었나?');
END;

INSERT INTO DEPARTMENT_TBL(DEPT_NO, DEPT_NAME, LOCATION) VALUES(5, '개발부', '서울');


-- 전달된 부서번호의 부서를 삭제하는 프로시저를 작성하시오.
-- 전달된 부서에 근무하는 모든 사원을 함께 삭제하시오.
CREATE OR REPLACE PROCEDURE DELETE_PROC(DEPTNO IN DEPARTMENT_TBL.DEPT_NO%TYPE)      -- IN: 입력 파라미터/ DEPTNO는 DEPART_TBL에 DEPT_NO와 같은 타입
IS
-- 변수가 필요하다면 여기서 선언 해줘야한다.
BEGIN   -- 사원 먼저 지우기(외래키를 가진 곳 먼저 삭제)
    DELETE 
      FROM EMPLOYEE_TBL
     WHERE DEPART = DEPTNO;
    DELETE
      FROM DEPARTMENT_TBL
     WHERE DEPT_NO = DEPTNO;
    COMMIT;
EXCEPTION
     WHEN OTHERS THEN   -- 모든 예외의 경우
        DBMS_OUTPUT.PUT_LINE(SQLCODE);
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
        ROLLBACK;
END;

-- 프로시저를 실행하는 방법
EXECUTE DELETE_PROC(1);     -- 부서가 1인 부서를 지워라

    
